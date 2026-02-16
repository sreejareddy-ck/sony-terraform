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


#Create a Datadog monitor for each Clickhouse service Memory Usage
resource "datadog_monitor" "spni_clickhouse_memory_usage" {
  for_each = { for x in var.Clickhouse_service_name : x.service_name => x }
  name  = "spni-${var.environment}-clickhouse_memory_usage-${each.value.service_name}"
  type = "metric alert"
  priority = each.value.priority
  no_data_timeframe =   10
  notify_no_data =   true
  query = each.value.query == "" ? "avg(${each.value.query_time_window}):avg:clickhouse.ClickHouseMetrics_MemoryTracking{clickhouse_service_name:${each.value.service_name}} by {clickhouse_service_name} / avg:clickhouse.ClickHouseAsyncMetrics_CGroupMemoryTotal{clickhouse_service_name:${each.value.service_name}} by {clickhouse_service_name} * 100 > ${each.value.critical_memory_threshold}" : each.value.query
  message = <<EOM
${each.value.message} for service: ${each.value.service_name} reports memory utilization for Clickhouse service: {{clickhouse_service_name.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
#"Memory utilisation for Clickhouse Service {{clickhouse_service_name.name}} is {{value}} at {{last_triggered_at}} ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for service: ${each.value.service_name} reports memory utilization for Clickhouse service: {{clickhouse_service_name.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:clickhouse",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds{
      critical = each.value.critical_memory_threshold
    }
}

#Monitr Failed Inserd Queries
resource "datadog_monitor" "spni_clickhouse_failed_inserted_queries" {
  for_each = { for x in var.Clickhouse_service_name : x.service_name => x }
  name  = "spni-${var.environment}-clickhouse_failed_inserted_queries-${each.value.service_name}"
  type = "metric alert"
  priority = each.value.priority
  no_data_timeframe =   10
  notify_no_data =   true
  query = each.value.query == "" ? "sum(${each.value.query_time_window}):sum:clickhouse.ClickHouseProfileEvents_FailedInsertQuery.count{clickhouse_service_name:${each.value.service_name}} by {clickhouse_service_name}.as_count() > ${each.value.failed_inserted_queries}" : each.value.query
  message =  <<EOM
${each.value.message} for service: ${each.value.service_name} reports failed inserted queries for Clickhouse service: {{clickhouse_service_name.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
#Failed Inserted Queries for Clickhouse Service {{clickhouse_service_name.name}} is {{value}} at {{last_triggered_at}} ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for service: ${each.value.service_name} reports failed inserted queries for Clickhouse service: {{clickhouse_service_name.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
   tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:clickhouse",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds{
      critical = each.value.failed_inserted_queries
    }
}


#Monitor Insert Query 
resource "datadog_monitor" "spni_clickhouse_insert_query" {
  for_each = { for x in var.Clickhouse_service_name : x.service_name => x }
  name  = "spni-${var.environment}-clickhouse_insert_query-${each.value.service_name}"
  type = "metric alert"
  priority = each.value.priority
  no_data_timeframe =   10
  notify_no_data =   true
  query = each.value.query == "" ? "sum(${each.value.query_time_window}):sum:clickhouse.ClickHouseProfileEvents_InsertQuery.count{clickhouse_service_name:${each.value.service_name}} by {clickhouse_service_name}.as_count() > ${each.value.Insert_query_count_threshold}" : each.value.query
  message = <<EOM
${each.value.message} for service: ${each.value.service_name} — Insert Query for Clickhouse Service {{clickhouse_service_name.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
#"Insert Query for Clickhouse Service {{clickhouse_service_name.name}} is {{value}} at {{last_triggered_at}} ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for service: ${each.value.service_name} — Insert Query for Clickhouse Service {{clickhouse_service_name.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
   tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:clickhouse",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds{
      critical = each.value.Insert_query_count_threshold
    }
}
 #monitor Delay Inserted Queries

 resource "datadog_monitor" "spni_clickhouse_delay_inserted_queries" {
  for_each = { for x in var.Clickhouse_service_name : x.service_name => x }
  name  = "spni-${var.environment}-clickhouse_delay_inserted_queries-${each.value.service_name}"
  type = "metric alert"
  priority = each.value.priority
  no_data_timeframe =   10
  notify_no_data =   false
  query = each.value.query == "" ? "sum(${each.value.query_time_window}):sum:clickhouse.ClickHouseMetrics_DelayedInserts.count{clickhouse_service_name:${each.value.service_name}} by {clickhouse_service_name}.as_count() > ${each.value.Insert_query_latency_threshold}" : each.value.query
  message = <<EOM
${each.value.message} for service: ${each.value.service_name} — Delay Inserted Queries for Clickhouse Service {{clickhouse_service_name.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  escalation_message = <<EOM
${each.value.message} for service: ${each.value.service_name} — Delay Inserted Queries for Clickhouse Service {{clickhouse_service_name.name}} is {{value}} at {{last_triggered_at}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

 tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:clickhouse",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds{
      critical = each.value.Insert_query_latency_threshold
    }
 }


 