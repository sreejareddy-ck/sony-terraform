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


resource "datadog_monitor" "spni_clickpipes_error_total" {
  for_each = { for x in var.Clickpipes_service_name : x.service_name => x }
  name  = "spni-${var.environment}-clickpipes_error_total-${each.value.service_name}"
  type = "query alert"
  priority = each.value.priority
  no_data_timeframe =   10
  notify_no_data =   false
  query = each.value.query == "" ? "avg(${each.value.query_time_window["spni_clickpipes_error_total"]}):avg:clickhouse.ClickPipes_Errors_Total.count{clickpipe_name:${each.value.service_name}} by {clickpipe_name}  > ${each.value.critical_total_error_threshold}" : each.value.query
  message = <<EOM
${each.value.message}  for Clickpipes service: {{clickpipe_name.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  escalation_message = <<EOM
${each.value.message}  for Clickpipes service: {{clickpipe_name.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  tags = [
    "env:${var.environment}",
    "service:${each.value.component_name}",
    "metric-type:operator",
    "resource_type:clickpipes",
    "component_name:${each.value.component_name}",
    "component_type:${each.value.service_name}",
    "resource_type:clickpipes",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds{
      critical = each.value.critical_total_error_threshold
    }
}

resource "datadog_monitor" "spni_clickpipes_latency" {
  for_each = { for x in var.Clickpipes_service_name : x.service_name => x }
  name  = "spni-${var.environment}-clickpipes_latency-${each.value.service_name}"
  type = "query alert"
  priority = each.value.priority
  no_data_timeframe =   10
  notify_no_data =   false
  query = each.value.query == "" ? "avg(${each.value.query_time_window["spni_clickpipes_latency"]}):sum:clickhouse.ClickPipes_Latency{clickpipe_name:${each.value.service_name}} by {clickpipe_name} > ${each.value.critical_latency_threshold}" : each.value.query
  message =  <<EOM
${each.value.message} for service: ${each.value.service_name} reports high latency for {{clickpipe_name.name}}  is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
#Failed Inserted Queries for Clickhouse Service {{Clickpipes_service_name.name}} is {{value}} at {{last_triggered_at}} ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for service: ${each.value.service_name} reports high latency for {{clickpipe_name.name}}  is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
   tags = [
    "env:${var.environment}",
    "service:${each.value.component_name}",
    "metric-type:operator",
    "component_name:${each.value.component_name}",
    "component_type:clickpipes",
    "resource_type:clickpipes",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds{
      critical = each.value.critical_latency_threshold
    }
}

resource "datadog_monitor" "spni_clickpipes_SentBytes" {
  for_each = { for x in var.Clickpipes_service_name : x.service_name => x }
  name  = "spni-${var.environment}-clickpipes_SentBytes-${each.value.service_name}"
  type = "query alert"
  priority = each.value.priority
  no_data_timeframe =   10
  notify_no_data =   false
  query = each.value.query == "" ? "sum(${each.value.query_time_window["spni_clickpipes_SentBytes"]}):sum:clickhouse.ClickPipes_SentBytes_Total.count{clickpipe_name:${each.value.service_name}} by {clickpipe_name}.as_count() ${each.value.ingestion_operator} ${each.value.critical_sentbytes_threshold}" : each.value.query
  message = <<EOM
${each.value.message} for service: ${each.value.service_name} — Sentbytes Total count for {{clickpipe_name.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
#"Insert Query for Clickhouse Service {{Clickpipes_service_name.name}} is {{value}} at {{last_triggered_at}} ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for service: ${each.value.service_name} — Insert Query for Clickhouse Service {{Clickpipes_service_name.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
   tags = [
    "env:${var.environment}",
    "service:${each.value.component_name}",
    "metric-type:operator",
    "component_name:${each.value.component_name}",
    "component_type:clickpipes",
    "resource_type:clickpipes",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds{
      critical = each.value.critical_sentbytes_threshold
    }
}


 