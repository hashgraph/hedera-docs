# Hedera Status API

## Overview

The **Hedera Status API** enables programmatic access to the current operational status, incident reports, and scheduled maintenance for the Hedera network. This API is especially useful for developers and system operators who want to integrate real-time status updates into their applications or monitor system health programmatically.

#### **Key Features**

* **Real-time Status Updates**: Retrieve the current operational state of all Consensus Nodes.
* **Incident Reports**: Access detailed information about current and past incidents, including affected components and resolution status.
* **Scheduled Maintenance**: Get advance notice and real-time updates on planned maintenance windows.

{% hint style="success" %}
For real-time visual monitoring, visit [https://status.hedera.com](https://status.hedera.com).
{% endhint %}

## Base URL

The base URL for all endpoints is:

```bash
https://status.hedera.com/api/v2
```

## Endpoints

<table data-full-width="true"><thead><tr><th width="388.5224609375">Endpoint</th><th>Description</th></tr></thead><tbody><tr><td><code>GET /summary.json</code></td><td>Get a summary of the status page, including a status indicator, component statuses, unresolved incidents, and any upcoming or in-progress scheduled maintenance.</td></tr><tr><td><strong><code>GET /status.json</code></strong></td><td><p>Get the status rollup for the whole page. This endpoint includes an indicator - one of <em>none</em>, <em>minor</em>, <em>major</em>, or <em>critical</em>, as well as a human description of the blended component status. </p><p><br>Examples of the blended status include "All Systems Operational," "Partial System Outage," and "Major Service Outage."</p></td></tr><tr><td><strong><code>GET /components.json</code></strong></td><td>List all components. Each component is listed along with its status - one of <em><code>operational</code></em>, <em><code>degraded_performance</code></em>, <em><code>partial_outage</code></em>, or <em><code>major_outage</code></em>.</td></tr><tr><td><code>GET /incidents.json</code></td><td>Get a list of the 50 most recent incidents. This includes all unresolved incidents as described above, as well as those in the <em>Resolved</em> and <em>Postmortem</em> state.</td></tr><tr><td><code>GET /incidents/unresolved.json</code></td><td>Get a list of any unresolved incidents. This endpoint will only return incidents in the <em>Investigating</em>, <em>Identified</em>, or <em>Monitoring</em> state.</td></tr><tr><td><strong><code>GET /scheduled-maintenances.json</code></strong></td><td>Get a list of the 50 most recent scheduled maintenance. This includes scheduled maintenance as described in the above two endpoints, as well as those in the <em>Completed</em> state.</td></tr><tr><td><strong><code>GET /scheduled-maintenances/upcoming.json</code></strong></td><td>Get a list of any upcoming maintenance. This endpoint will only return scheduled maintenances still in the <em>Scheduled</em> state.</td></tr><tr><td><code>GET /scheduled-maintenances/active.json</code></td><td>Get a list of any active maintenance. This endpoint will only return scheduled maintenance in the <em>In Progress</em> or <em>Verifying</em> state.</td></tr></tbody></table>

{% openapi src="../.gitbook/assets/openapi_v5.json" path="/summary.json" method="get" %}
[openapi_v5.json](../.gitbook/assets/openapi_v5.json)
{% endopenapi %}

{% openapi src="../.gitbook/assets/openapi_v5.json" path="/status.json" method="get" %}
[openapi_v5.json](../.gitbook/assets/openapi_v5.json)
{% endopenapi %}

***

{% openapi src="../.gitbook/assets/openapi_v5.json" path="/components.json" method="get" %}
[openapi_v5.json](../.gitbook/assets/openapi_v5.json)
{% endopenapi %}

***

{% openapi src="../.gitbook/assets/openapi_v5.json" path="/incidents.json" method="get" %}
[openapi_v5.json](../.gitbook/assets/openapi_v5.json)
{% endopenapi %}



{% openapi src="../.gitbook/assets/openapi_v5.json" path="/incidents/unresolved.json" method="get" %}
[openapi_v5.json](../.gitbook/assets/openapi_v5.json)
{% endopenapi %}

{% openapi src="../.gitbook/assets/openapi_v5.json" path="/scheduled-maintenances.json" method="get" %}
[openapi_v5.json](../.gitbook/assets/openapi_v5.json)
{% endopenapi %}

{% openapi src="../.gitbook/assets/openapi_v5.json" path="/scheduled-maintenances/upcoming.json" method="get" %}
[openapi_v5.json](../.gitbook/assets/openapi_v5.json)
{% endopenapi %}

{% openapi src="../.gitbook/assets/openapi_v5.json" path="/scheduled-maintenances/active.json" method="get" %}
[openapi_v5.json](../.gitbook/assets/openapi_v5.json)
{% endopenapi %}

***

## Additional Resources

For further integration support or detailed documentation on all available endpoints, visit the official [Hedera Status API page](https://status.hedera.com/api/v2).
