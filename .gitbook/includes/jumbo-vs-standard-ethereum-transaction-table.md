---
title: jumbo vs standard ethereum transaction table
---

<table><thead><tr><th width="224.57293701171875">Feature</th><th>Jumbo Ethereum Transaction</th><th>Standard Ethereum Transaction</th></tr></thead><tbody><tr><td><strong>callData Size Limit</strong></td><td>24KB (creation) / 128KB (call)</td><td>~6KB total transaction size</td></tr><tr><td><strong>callDataFileId Needed?</strong></td><td>Only if limits exceeded</td><td>Always for large payloads</td></tr><tr><td><strong>Gas Calculation</strong></td><td>Always for large payloads</td><td>Same</td></tr><tr><td><strong>Batch Inclusion</strong></td><td>Not supported</td><td>Supported</td></tr><tr><td><strong>Network Throttling</strong></td><td>Dedicated throttle bucket</td><td>Standard throttling</td></tr></tbody></table>
