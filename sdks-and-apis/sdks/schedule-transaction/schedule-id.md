# Schedule ID

The entity ID of a schedule transaction.

A `ScheduleId` is composed of a \<shardNum>.\<realmNum>.\<scheduleNum> (eg. 0.0.10).

* **shardNum** represents the shard number (`shardId`). It will default to 0 today, as Hedera only performs in one shard.
* **realmNum** represents the realm number (`realmId`). It will default to 0 today, as realms are not yet supported.
* **scheduleNum** represents the schedule number (`scheduleId`)

Together these values make up your `ScheduleId`. When a `ScheduleId` is requested in a field, be sure enter all three values.

<table><thead><tr><th width="316.3333333333333">Constructor</th><th align="center">Type</th><th>Description</th></tr></thead><tbody><tr><td><code>new ScheduleId(&#x3C;shardNum>,&#x3C;realmNum>,&#x3C;scheduleNum>)</code></td><td align="center">long, long, long</td><td>Constructs a <code>ScheduleId</code> with 0 for <code>shardNum</code> and <code>realmNum</code> (e.g., <code>0.0.&#x3C;scheduleNum></code>)</td></tr></tbody></table>

### Example

{% tabs %}
{% tab title="Java" %}
```java
ScheduleId scheduleID = new ScheduleId(0,0,10); 
System.out.println(scheduleID)
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
const scheduleID = new ScheduleId(0,0,10); 
console.log(scheduleID)
```
{% endtab %}

{% tab title="Go" %}

{% endtab %}

{% tab title="Rust" %}
```rust
// Create a schedule ID
let schedule_id = ScheduleId::new(0, 0, 10);
println!("{:?}", schedule_id);

// v0.34.0
```
{% endtab %}
{% endtabs %}
