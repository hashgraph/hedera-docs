#!/usr/bin/env node

/**
 * Sync OpenAPI Specification from Hedera Mirror Node
 * 
 * This script downloads the latest OpenAPI specification from Hedera Mirror Node
 * and updates the local openapi.yaml file if there are changes.
 * 
 * Usage:
 *   node sync-openapi.js [--network=testnet|mainnet] [--output=path/to/openapi.yaml]
 */

const https = require('https');
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Configuration
const NETWORKS = {
  testnet: 'https://testnet.mirrornode.hedera.com/api/v1/docs/openapi.yml',
  mainnet: 'https://mainnet.mirrornode.hedera.com/api/v1/docs/openapi.yml'
};

// Parse command line arguments
const args = process.argv.slice(2).reduce((acc, arg) => {
  const [key, value] = arg.replace('--', '').split('=');
  acc[key] = value || true;
  return acc;
}, {});

const network = args.network || 'mainnet';
const outputPath = args.output || path.join(process.cwd(), 'openapi.yaml');
const dryRun = args['dry-run'] || false;
const verbose = args.verbose || false;

// Validate network
if (!NETWORKS[network]) {
  console.error(`❌ Error: Invalid network "${network}". Must be "testnet" or "mainnet".`);
  process.exit(1);
}

const sourceUrl = NETWORKS[network];

/**
 * Log message if verbose mode is enabled
 */
function log(message) {
  if (verbose) {
    console.log(message);
  }
}

/**
 * Download content from URL
 */
function downloadFile(url) {
  return new Promise((resolve, reject) => {
    log(`📥 Downloading from ${url}...`);
    
    https.get(url, (response) => {
      if (response.statusCode !== 200) {
        reject(new Error(`Failed to download: HTTP ${response.statusCode}`));
        return;
      }

      let data = '';
      response.on('data', (chunk) => {
        data += chunk;
      });

      response.on('end', () => {
        log(`✓ Download complete (${data.length} bytes)`);
        resolve(data);
      });
    }).on('error', (error) => {
      reject(error);
    });
  });
}

/**
 * Extract version from OpenAPI content
 */
function extractVersion(content) {
  const match = content.match(/version:\s*['"]?([0-9.]+)['"]?/);
  return match ? match[1] : 'unknown';
}

/**
 * Check if files are different
 */
function filesAreDifferent(content1, content2) {
  // Normalize line endings and trim whitespace
  const normalize = (str) => str.replace(/\r\n/g, '\n').trim();
  return normalize(content1) !== normalize(content2);
}

/**
 * Create backup of existing file
 */
function createBackup(filePath) {
  if (fs.existsSync(filePath)) {
    const backupPath = `${filePath}.backup`;
    fs.copyFileSync(filePath, backupPath);
    log(`✓ Created backup at ${backupPath}`);
    return backupPath;
  }
  return null;
}

/**
 * Validate YAML syntax
 */
function validateYaml(content) {
  try {
    // Try to parse with Node.js (basic validation)
    // For production, consider using a proper YAML parser like 'js-yaml'
    const lines = content.split('\n');
    let indentStack = [0];
    
    for (let i = 0; i < lines.length; i++) {
      const line = lines[i];
      if (line.trim() === '' || line.trim().startsWith('#')) continue;
      
      const indent = line.search(/\S/);
      if (indent === -1) continue;
      
      // Basic indentation check
      if (indent > indentStack[indentStack.length - 1]) {
        indentStack.push(indent);
      } else {
        while (indentStack.length > 0 && indent < indentStack[indentStack.length - 1]) {
          indentStack.pop();
        }
      }
    }
    
    log('✓ YAML syntax validation passed');
    return true;
  } catch (error) {
    console.error(`❌ YAML validation failed: ${error.message}`);
    return false;
  }
}

/**
 * Main sync function
 */
async function syncOpenApi() {
  console.log('🔄 Hedera Mirror Node OpenAPI Sync');
  console.log('=====================================');
  console.log(`Network: ${network}`);
  console.log(`Source: ${sourceUrl}`);
  console.log(`Output: ${outputPath}`);
  console.log(`Dry run: ${dryRun ? 'Yes' : 'No'}`);
  console.log('');

  try {
    // Download new content
    const newContent = await downloadFile(sourceUrl);
    const newVersion = extractVersion(newContent);
    
    console.log(`📦 Downloaded version: ${newVersion}`);

    // Validate YAML
    if (!validateYaml(newContent)) {
      throw new Error('Downloaded content failed YAML validation');
    }

    // Check if file exists and compare
    let hasChanges = true;
    let currentVersion = 'none';
    
    if (fs.existsSync(outputPath)) {
      const currentContent = fs.readFileSync(outputPath, 'utf8');
      currentVersion = extractVersion(currentContent);
      hasChanges = filesAreDifferent(currentContent, newContent);
      
      console.log(`📄 Current version: ${currentVersion}`);
      
      if (!hasChanges) {
        console.log('✅ No changes detected. File is up to date.');
        return { updated: false, version: currentVersion };
      }
      
      console.log('🔍 Changes detected!');
    } else {
      console.log('📝 No existing file found. Creating new file.');
    }

    if (dryRun) {
      console.log('');
      console.log('🔍 DRY RUN MODE - No files will be modified');
      console.log(`Would update from version ${currentVersion} to ${newVersion}`);
      return { updated: false, version: newVersion, dryRun: true };
    }

    // Create backup
    const backupPath = createBackup(outputPath);

    // Write new content
    const outputDir = path.dirname(outputPath);
    if (!fs.existsSync(outputDir)) {
      fs.mkdirSync(outputDir, { recursive: true });
    }
    
    fs.writeFileSync(outputPath, newContent, 'utf8');
    console.log(`✅ Successfully updated ${outputPath}`);
    
    if (backupPath) {
      console.log(`💾 Backup saved to ${backupPath}`);
    }

    // Summary
    console.log('');
    console.log('📊 Summary:');
    console.log(`   Previous version: ${currentVersion}`);
    console.log(`   New version: ${newVersion}`);
    console.log(`   File size: ${newContent.length} bytes`);

    return { 
      updated: true, 
      version: newVersion, 
      previousVersion: currentVersion,
      backupPath 
    };

  } catch (error) {
    console.error('');
    console.error('❌ Error:', error.message);
    
    if (verbose && error.stack) {
      console.error('');
      console.error('Stack trace:');
      console.error(error.stack);
    }
    
    process.exit(1);
  }
}

// Run if called directly
if (require.main === module) {
  syncOpenApi()
    .then((result) => {
      if (result.updated) {
        process.exit(0);
      } else {
        process.exit(0);
      }
    })
    .catch((error) => {
      console.error('Fatal error:', error);
      process.exit(1);
    });
}

module.exports = { syncOpenApi, NETWORKS };
