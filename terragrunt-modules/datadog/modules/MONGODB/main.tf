terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

provider "datadog" {
  api_key = "${var.datadog_api_key}"
  app_key = "${var.datadog_app_key}"
}


# Monitoring alert creation for mongodb current open connections
resource "datadog_monitor" "spni_mongodb_connections" {
  for_each           = { for x in var.mongodb_service_name : x.component_name => x }
  name               = "spni-${var.environment}-mongodb-monitor-currentConnections-${each.value.component_name}"
  type               = "metric alert"
  priority           = each.value.priority
   on_missing_data    = "show_no_data"
  notify_audit       =  false

  message            = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Current MongoDB Atlas connections for cluster {{clustername}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Current MongoDB Atlas connections for cluster {{clustername}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  query = each.value.mongodb_connections_query == "" ? "avg(${each.value.query_time_window}):avg:mongodb.atlas.connections.current{clustername:${each.value.clustername}} by {clustername,host} > ${each.value.mongodb_connections_critical}" : each.value.mongodb_connections_query

  monitor_thresholds {
    critical = each.value.mongodb_connections_critical
  }

  include_tags = true

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:mongodb",
    "component_name:${each.value.component_name}",
    "component_type:mongodb",
    "roster:${each.value.roster}"
  ]
}


# Monitoring alert creation for mongodb read latency
resource "datadog_monitor" "spni_mongodb_disk_read_latency" {
  for_each           = { for x in var.mongodb_service_name : x.component_name => x }
  name               = "spni-${var.environment}-mongodb-monitor-disk-read-latency-${each.value.component_name}"
  type               = "metric alert"
  priority           = each.value.priority
   on_missing_data    = "show_no_data"
  notify_audit       =  false

  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — MongoDB read disk latency for cluster {{clustername}} is {{value}} ms.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — MongoDB read disk latency for cluster {{clustername}} is {{value}} ms.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  query = "avg(${each.value.query_time_window}):avg:mongodb.atlas.system.disk.latency.reads{clustername:${each.value.clustername}} by {clustername,host} > ${each.value.mongodb_disk_read_latency_critical}"

  monitor_thresholds {
    critical = each.value.mongodb_disk_read_latency_critical
  }

  include_tags = true

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:mongodb",
    "component_name:${each.value.component_name}",
    "component_type:mongodb",
    "roster:${each.value.roster}"
  ]
}

# Monitoring alert creation for mongodb write latency

resource "datadog_monitor" "spni_mongodb_disk_write_latency" {
  for_each           = { for x in var.mongodb_service_name : x.component_name => x }
  name               = "spni-${var.environment}-mongodb-monitor-disk-write-latency-${each.value.component_name}"
  type               = "metric alert"
  priority           = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false

  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — MongoDB write disk latency for cluster {{clustername}} is {{value}} ms.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — MongoDB write disk latency for cluster {{clustername}} is {{value}} ms.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  query = "avg(${each.value.query_time_window}):avg:mongodb.atlas.system.disk.latency.writes{clustername:${each.value.clustername}} by {clustername,host} > ${each.value.mongodb_disk_write_latency_critical}"

  monitor_thresholds {
    critical = each.value.mongodb_disk_write_latency_critical         
  }

  include_tags = true

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:mongodb",
    "component_name:${each.value.component_name}",
    "component_type:mongodb",
    "roster:${each.value.roster}"
  ]
}

# Monitoring alert creation for mongodb REPLICATION_LAG
resource "datadog_monitor" "spni_mongodb_replication_lag" {
  for_each           = { for x in var.mongodb_service_name : x.component_name => x }
  name               = "spni-${var.environment}-mongodb-monitor-replication-lag-${each.value.component_name}"
  type               = "metric alert"
  priority           = each.value.priority
   on_missing_data    = "show_no_data"
  notify_audit       =  false

  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Replication lag on MongoDB Atlas cluster {{clustername}} is {{value}} seconds.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Replication lag on MongoDB Atlas cluster {{clustername}} is {{value}} seconds.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  query = "avg(${each.value.query_time_window}):avg:mongodb.atlas.replset.replicationlag{clustername:${each.value.clustername}} by {clustername,host} > ${each.value.mongodb_replication_lag_critical}"

  monitor_thresholds {
    critical = each.value.mongodb_replication_lag_critical
  }

  include_tags = true

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:mongodb",
    "component_name:${each.value.component_name}",
    "component_type:mongodb",
    "roster:${each.value.roster}"
  ]
}

# Monitoring alert creation for mongodb SYSTEM_MEMORY_USED
resource "datadog_monitor" "spni_mongodb_memory_used" {
  for_each           = { for x in var.mongodb_service_name : x.component_name => x }

  name               = "spni-${var.environment}-mongodb-monitor-memory-used-${each.value.component_name}"
  type               = "metric alert"
  priority           = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false

  query = each.value.mongodb_memory_used_query == "" ? "avg(${each.value.query_time_window}):avg:mongodb.atlas.system.memory.used{clustername:${each.value.clustername}} by {clustername,host} > ${each.value.mongodb_memory_used_critical}" : each.value.mongodb_memory_used_query

  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Memory usage on MongoDB Atlas cluster {{clustername}} is {{value}} bytes.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Memory usage on MongoDB Atlas cluster {{clustername}} is {{value}} bytes.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  monitor_thresholds {
    critical = each.value.mongodb_memory_used_critical
  }

  include_tags = true

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:mongodb",
    "component_name:${each.value.component_name}",
    "component_type:mongodb",
    "roster:${each.value.roster}"
  ]
}


# Monitoring alert creation for mongodb SYSTEM_CPU used
resource "datadog_monitor" "spni_mongodb_cpu_user" {
  for_each           = { for x in var.mongodb_service_name : x.component_name => x }

  name               = "spni-${var.environment}-mongodb-monitor-cpu-user-${each.value.component_name}"
  type               = "metric alert"
  priority           = each.value.priority
 on_missing_data    = "show_no_data"
  notify_audit       =  false

  query = each.value.mongodb_cpu_user_query == "" ? "avg(${each.value.query_time_window}):avg:mongodb.atlas.system.cpu.norm.user{clustername:${each.value.clustername}} by {clustername,host} > ${each.value.mongodb_cpu_user_critical}" : each.value.mongodb_cpu_user_query

  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — User CPU utilization on MongoDB Atlas cluster {{clustername}} is {{value}}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — User CPU utilization on MongoDB Atlas cluster {{clustername}} is {{value}}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  monitor_thresholds {
    critical = each.value.mongodb_cpu_user_critical
  }

  include_tags = true

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:mongodb",
    "component_name:${each.value.component_name}",
    "component_type:mongodb",
    "roster:${each.value.roster}"
  ]
}

# Monitoring alert creation for mongodb DISK_PARTITION_IOPS_READ 

resource "datadog_monitor" "spni_mongodb_disk_iops_reads" {
  for_each           = { for x in var.mongodb_service_name : x.component_name => x }

  name               = "spni-${var.environment}-mongodb-monitor-disk-iops-reads-${each.value.component_name}"
  type               = "metric alert"
  priority           = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false

  query = "avg(${each.value.query_time_window}):avg:mongodb.atlas.system.disk.iops.reads{clustername:${each.value.clustername}} by {clustername,host} > ${each.value.mongodb_disk_iops_reads_critical}"

  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Disk IOPS (reads) on MongoDB Atlas cluster {{clustername}} is {{value}} ops/sec.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Disk IOPS (reads) on MongoDB Atlas cluster {{clustername}} is {{value}} ops/sec.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  monitor_thresholds {
    critical = each.value.mongodb_disk_iops_reads_critical
  }

  include_tags = true

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:mongodb",
    "component_name:${each.value.component_name}",
    "component_type:mongodb",
    "roster:${each.value.roster}"
  ]
}

# Monitoring alert creation for mongodb DISK_PARTITION_IOPS_WRITE
resource "datadog_monitor" "spni_mongodb_disk_iops_writes" {
  for_each           = { for x in var.mongodb_service_name : x.component_name => x }

  name               = "spni-${var.environment}-mongodb-monitor-disk-iops-writes-${each.value.component_name}"
  type               = "metric alert"
  priority           = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false

  query = "avg(${each.value.query_time_window}):avg:mongodb.atlas.system.disk.iops.writes{clustername:${each.value.clustername}} by {clustername,host} > ${each.value.mongodb_disk_iops_writes_critical}"

  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Disk IOPS (writes) on MongoDB Atlas cluster {{clustername}} is {{value}} ops/sec.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Disk IOPS (writes) on MongoDB Atlas cluster {{clustername}} is {{value}} ops/sec.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  monitor_thresholds {
    critical = each.value.mongodb_disk_iops_writes_critical
  }

  include_tags = true

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:mongodb",
    "component_name:${each.value.component_name}",
    "component_type:mongodb",
    "roster:${each.value.roster}"
  ]
}
