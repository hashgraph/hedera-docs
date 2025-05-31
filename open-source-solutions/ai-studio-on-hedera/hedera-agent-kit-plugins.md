# Hedera Agent Kit Plugin Development Guide

The Hedera Agent Kit supports a powerful plugin system that allows developers to extend the agent's capabilities with custom tools and integrations. This guide covers everything you need to know about creating and using plugins.

## Overview

Plugins in the Hedera Agent Kit are modular extensions that provide additional tools to the agent. They are built on top of the Standards Agent Kit plugin architecture and integrate seamlessly with LangChain tools.

## Plugin Architecture

### Core Interfaces

All plugins must implement the `IPlugin` interface from `@hashgraphonline/standards-agent-kit`:

```typescript
interface IPlugin<T extends BasePluginContext = BasePluginContext> {
  id: string;                    // Unique identifier for the plugin
  name: string;                  // Human-readable name
  description: string;           // What the plugin does
  version: string;              // Plugin version
  author: string;               // Plugin author
  
  initialize(context: T): Promise<void>;  // Initialize with context
  getTools(): StructuredTool[];          // Return available tools
  cleanup?(): Promise<void>;             // Optional cleanup method
}
```

### Plugin Context

When initialized, plugins receive a context object that provides access to shared resources:

```typescript
interface GenericPluginContext {
  logger: Logger;                        // Logger instance
  config: Record<string, unknown>;       // Configuration options
  client: IPluginClient;                 // Network client interface
  stateManager?: IPluginStateManager;    // Optional state manager
}
```

## Creating a Basic Plugin

### Step 1: Set Up the Plugin Class

The simplest way to create a plugin is to extend the `GenericPlugin` base class:

```typescript
import {
  GenericPlugin,
  GenericPluginContext,
} from '@hashgraphonline/standards-agent-kit';
import { StructuredTool, DynamicStructuredTool } from '@langchain/core/tools';
import { z } from 'zod';

export class HelloWorldPlugin extends GenericPlugin {
  id = 'hello-world-plugin';
  name = 'Hello World Plugin';
  description = 'A simple plugin that says hello.';
  version = '1.0.0';
  author = 'Hedera Agent Kit Demo';
  namespace = 'hello';  // Optional namespace for organizing tools

  override async initialize(context: GenericPluginContext): Promise<void> {
    await super.initialize(context);
    this.context.logger.info('HelloWorldPlugin initialized');
  }

  getTools(): StructuredTool[] {
    return [
      new DynamicStructuredTool({
        name: 'say_hello',
        description: 'Says hello to the given name.',
        schema: z.object({
          name: z.string().describe('The name to say hello to.'),
        }),
        func: async ({ name }: { name: string }): Promise<string> => {
          return `Hello, ${name}! This message is from the HelloWorldPlugin.`;
        },
      }),
    ];
  }
}
```

### Step 2: Add Custom Tools

Tools are created using LangChain's `StructuredTool` or `DynamicStructuredTool` classes. Each tool must have:

- **name**: A unique identifier for the tool
- **description**: What the tool does (used by the AI to understand when to use it)
- **schema**: A Zod schema defining the tool's parameters
- **func**: The implementation function

Here's an example of a more complex tool:

```typescript
class GetWeatherTool extends StructuredTool {
  name = 'get_current_weather';
  description = 'Get the current weather for a location';

  schema = z.object({
    location: z.string().describe('The city and state, e.g. San Francisco, CA'),
    unit: z
      .enum(['celsius', 'fahrenheit'])
      .optional()
      .describe('The unit of temperature'),
  });

  constructor(private apiKey?: string) {
    super();
  }

  async _call(input: z.infer<typeof this.schema>): Promise<string> {
    if (!this.apiKey) {
      return 'Error: Weather API key not configured.';
    }

    try {
      // Make API call to weather service
      const response = await axios.get('https://api.weatherapi.com/v1/current.json', {
        params: {
          key: this.apiKey,
          q: input.location,
        },
      });

      const temp = input.unit === 'fahrenheit' 
        ? response.data.current.temp_f 
        : response.data.current.temp_c;
      const unit = input.unit === 'fahrenheit' ? '°F' : '°C';

      return `Current weather in ${response.data.location.name}: ${temp}${unit}`;
    } catch (error) {
      return `Error fetching weather: ${error.message}`;
    }
  }
}
```

### Step 3: Integrate with Hedera Agent Kit

To use your plugin with the Hedera Agent Kit, pass it during initialization:

```typescript
import { HederaAgentKit } from '../src';
import { ServerSigner } from '../src/signer/server-signer';
import { HelloWorldPlugin } from './hello-world-plugin';
import { IPlugin } from '@hashgraphonline/standards-agent-kit';

// Create signer
const signer = new ServerSigner(
  process.env.HEDERA_ACCOUNT_ID!,
  process.env.HEDERA_PRIVATE_KEY!,
  'testnet'
);

// Initialize agent kit with plugin
const agentKit = new HederaAgentKit(signer, {
  plugins: [new HelloWorldPlugin() as IPlugin],
  appConfig: {
    // Any configuration your plugins need
    weatherApiKey: process.env.WEATHER_API_KEY,
  }
});

// Initialize the kit (this initializes all plugins)
await agentKit.initialize();

// Get all available tools (includes plugin tools)
const tools = agentKit.getAggregatedLangChainTools();
```

## Advanced Plugin Features

### Using Configuration

Plugins can access configuration through the context:

```typescript
export class ConfigurablePlugin extends GenericPlugin {
  private apiEndpoint?: string;
  
  async initialize(context: GenericPluginContext): Promise<void> {
    await super.initialize(context);
    
    // Access configuration
    this.apiEndpoint = context.config.apiEndpoint as string;
    
    if (!this.apiEndpoint) {
      this.context.logger.warn('API endpoint not configured');
    }
  }
}
```

### Accessing Hedera Network

Plugins can interact with the Hedera network through the client interface:

```typescript
getTools(): StructuredTool[] {
  return [
    new DynamicStructuredTool({
      name: 'check_network',
      description: 'Check which Hedera network we are connected to',
      schema: z.object({}),
      func: async (): Promise<string> => {
        const network = this.context.client.getNetwork();
        return `Connected to Hedera ${network} network`;
      },
    }),
  ];
}
```

### Plugin Cleanup

Implement the optional `cleanup` method to properly dispose of resources:

```typescript
export class ResourcePlugin extends GenericPlugin {
  private intervalId?: NodeJS.Timer;
  
  async initialize(context: GenericPluginContext): Promise<void> {
    await super.initialize(context);
    // Start some background task
    this.intervalId = setInterval(() => {
      this.context.logger.debug('Background task running');
    }, 60000);
  }
  
  async cleanup(): Promise<void> {
    if (this.intervalId) {
      clearInterval(this.intervalId);
    }
    this.context.logger.info('ResourcePlugin cleaned up');
  }
}
```

## Real-World Example: HBAR Price Plugin

Here's a complete example of a plugin that fetches HBAR prices:

```typescript
import { IPlugin } from '../PluginInterface';
import { StructuredTool } from '@langchain/core/tools';
import { z } from 'zod';
import axios from 'axios';

const HEDERA_MIRROR_NODE_API = 'https://mainnet.mirrornode.hedera.com/api/v1';

class GetHbarPriceTool extends StructuredTool {
  name = 'getHbarPrice';
  description = 'Retrieves the current price of HBAR in USD from the Hedera Mirror Node.';
  schema = z.object({}); // No input required

  protected async _call(): Promise<string> {
    try {
      const response = await axios.get(`${HEDERA_MIRROR_NODE_API}/network/exchangerate`);
      
      const { current_rate } = response.data;
      const priceUsd = current_rate.cent_equivalent / current_rate.hbar_equivalent / 100;
      
      return `The current price of HBAR is $${priceUsd.toFixed(6)} USD.`;
    } catch (error) {
      return `Failed to retrieve HBAR price: ${error.message}`;
    }
  }
}

export class HbarPricePlugin implements IPlugin {
  id = 'hedera-hbar-price';
  name = 'Hedera HBAR Price Plugin';
  description = 'Provides tools to interact with Hedera network data, specifically HBAR price.';
  version = '1.0.0';
  author = 'Hedera Agent';

  private tools: StructuredTool[];

  constructor() {
    this.tools = [new GetHbarPriceTool()];
  }

  async initialize(): Promise<void> {
    // No specific initialization needed
    return Promise.resolve();
  }

  getTools(): StructuredTool[] {
    return this.tools;
  }

  async cleanup(): Promise<void> {
    // No cleanup necessary
    return Promise.resolve();
  }
}
```

## Using Plugins with Conversational Agents

When using plugins with the `HederaConversationalAgent`, they are automatically integrated:

```typescript
import { HederaConversationalAgent } from '../src/agent/conversational-agent';
import { HelloWorldPlugin } from './hello-world-plugin';

const conversationalAgent = new HederaConversationalAgent(signer, {
  operationalMode: 'provideBytes',
  userAccountId: process.env.USER_ACCOUNT_ID,
  openAIApiKey: process.env.OPENAI_API_KEY,
  pluginConfig: {
    plugins: [new HelloWorldPlugin() as IPlugin],
    appConfig: {
      // Plugin configuration
    }
  },
});

await conversationalAgent.initialize();

// The agent can now use plugin tools
const response = await conversationalAgent.processMessage(
  "Say hello to Hedera",
  chatHistory
);
```

## Best Practices

1. **Unique IDs**: Always use unique, descriptive IDs for your plugins to avoid conflicts
2. **Error Handling**: Always handle errors gracefully in your tools and return helpful error messages
3. **Logging**: Use the provided logger for debugging and tracking plugin behavior
4. **Type Safety**: Use TypeScript and Zod schemas to ensure type safety
5. **Documentation**: Provide clear descriptions for your tools to help the AI understand when to use them
6. **Configuration**: Make your plugins configurable through the appConfig
7. **Cleanup**: Always implement cleanup if your plugin uses resources that need disposal

## Plugin Registry (Optional)

For managing multiple plugins, you can use the `PluginRegistry` from Standards Agent Kit:

```typescript
import { PluginRegistry, PluginContext } from '@hashgraphonline/standards-agent-kit';

const context: PluginContext = {
  client: hcs10Client,
  logger: logger,
  config: {
    weatherApiKey: process.env.WEATHER_API_KEY,
  },
};

const pluginRegistry = new PluginRegistry(context);

// Register plugins
await pluginRegistry.registerPlugin(new WeatherPlugin());
await pluginRegistry.registerPlugin(new HbarPricePlugin());

// Get all tools from all plugins
const allTools = pluginRegistry.getAllTools();
```

## Troubleshooting

### Plugin Not Loading
- Ensure the plugin is properly instantiated and passed to the agent kit
- Check that `await agentKit.initialize()` is called before using tools
- Verify the plugin implements all required interface methods

### Tools Not Working
- Check tool descriptions are clear and specific
- Verify Zod schemas match expected parameters
- Ensure error handling returns helpful messages
- Check logs for initialization errors

### Configuration Issues
- Verify configuration is passed in the `appConfig` object
- Check that configuration keys match what the plugin expects
- Use the logger to debug configuration values

## Next Steps

- Explore the [Standards Agent Kit plugin examples](https://github.com/hashgraph-online/standards-agent-kit/tree/main/src/plugins)
- Check out community plugins for inspiration
- Share your plugins with the Hedera community

Remember that plugins are a powerful way to extend the Hedera Agent Kit's capabilities. Whether you're integrating with external APIs, adding custom business logic, or creating specialized Hedera operations, the plugin system provides a clean and maintainable way to enhance your agent's functionality.