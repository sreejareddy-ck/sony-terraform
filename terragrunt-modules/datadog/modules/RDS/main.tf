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


resource "datadog_monitor" "spni_rds_cpu" {
  for_each           = { for x in var.rds_service_name : x.component_name => x }
  name               = "spni-${var.environment}-rds-monitor-cpu-${each.value.component_name}"
  type               = "metric alert"
  priority           = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900
  query = each.value.rds_cpu_query == "" ? "avg(${each.value.query_time_window}):avg:aws.rds.cpuutilization{component_name:${each.value.component_name} AND environment:${var.environment}*} by {dbinstanceidentifier} > ${each.value.rds_cpu_metric_critical}" : each.value.rds_cpu_query
  message =<<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — CPU utilization for RDS cluster {{dbclusteridentifier}} is {{value}}%

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM 
#"Database cpu is {{value}}  on {{dbclusteridentifier}} ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — CPU utilization for RDS cluster {{dbclusteridentifier}} is {{value}}%

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  monitor_thresholds {
    critical = "${each.value.rds_cpu_metric_critical}"
  }
  include_tags = true 
   tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:rds",
    "component_name:${each.value.component_name}",
    "component_type:rds",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_rds_dbconnections" {
  for_each           = { for x in var.rds_service_name : x.component_name => x }
  name               = "spni-${var.environment}-rds-monitor-databaseConnections-${each.value.component_name}"
  type               = "metric alert"
  priority           = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900
  message            = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Number of database connections for RDS cluster {{dbclusteridentifier}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM 
#Database Connection is {{value}} for {{dbclusteridentifier}} ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Number of database connections for RDS cluster {{dbclusteridentifier}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  query = each.value.rds_dbconnections_query == "" ? "avg(${each.value.query_time_window}):avg:aws.rds.database_connections{component_name:${each.value.component_name} AND environment:${var.environment}*} by {dbinstanceidentifier} > ${each.value.rds_dbconnections_metric_critical}" : each.value.rds_dbconnections_query
  monitor_thresholds {
    critical = each.value.rds_dbconnections_metric_critical
  }
  include_tags = true
   tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:rds",
    "component_name:${each.value.component_name}",
    "component_type:rds",
    "roster:${each.value.roster}"
  ]
}




resource "datadog_monitor" "spni_rds_memory" {
  for_each           = { for x in var.rds_service_name : x.component_name => x }
  name               = "spni-${var.environment}-rds-monitor-memory-${each.value.component_name}"
  type               = "metric alert"
  priority           = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900
  message            = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Memory utilization for RDS cluster {{dbclusteridentifier}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM 
#"Memory Utilisation is {{value}} for {{dbclusteridentifier}} ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Memory utilization for RDS cluster {{dbclusteridentifier}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  query = each.value.rds_memory_query == "" ? "avg(${each.value.query_time_window}):avg:aws.rds.freeable_memory{component_name:${each.value.component_name} AND environment:${var.environment}*} by {dbinstanceidentifier} < ${each.value.rds_freeable_memory_metrics_critical}" : each.value.rds_memory_query
  monitor_thresholds {
    critical = each.value.rds_freeable_memory_metrics_critical
  }
  include_tags = true
   tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:rds",
    "component_name:${each.value.component_name}",
    "component_type:rds",
    "roster:${each.value.roster}"
  ]
}
resource "datadog_monitor" "spni_free_storage_percent" {
  for_each           = { for x in var.rds_service_name : x.component_name => x }
  name               = "spni-${var.environment}-rds-monitor-free-storage-${each.value.component_name}"
  type               = "metric alert"
  priority           = each.value.priority
   on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900
  message            = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Free storage percent for RDS cluster {{dbclusteridentifier}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM 
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Free storage percent for RDS cluster {{dbclusteridentifier}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  
  query = each.value.rds_memory_query == "" ? "avg(${each.value.query_time_window}):avg:aws.rds.free_storage_space{component_name:${each.value.component_name} AND environment:${var.environment}*} by {dbinstanceidentifier} / avg:aws.rds.total_storage_space{component_name:${each.value.component_name} AND environment:${var.environment}*} by {dbinstanceidentifier} * 100 < ${each.value.rds_free_storage_threshold}":each.value.rds_free_storage_query
  monitor_thresholds {
    critical = each.value.rds_free_storage_threshold 
  }
  include_tags = true
   tags = [
    "env:${var.environment}",
    "service_name:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:rds",
    "component_name:${each.value.component_name}",
    "component_type:rds",
    "roster:${each.value.roster}"
  ]
}
