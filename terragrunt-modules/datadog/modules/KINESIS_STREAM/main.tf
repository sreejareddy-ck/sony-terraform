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

resource "datadog_monitor" "spni_GetRecords_iterator_age" {
  for_each = { for i in var.KINESIS_STREAM_service_name : i.component_name => i }
  name     = "spni-kinesis-stream-${var.environment}-GetRecords-iterator-age-${each.value.component_name}"
  priority = each.value.priority
  type     = "metric alert"
  evaluation_delay = 900
  query    = each.value.query == "" ? "avg(${each.value.query_time_window}):avg:aws.kinesis.get_records_iterator_age_milliseconds{component_name:${each.value.component_name} AND environment:${var.environment}} by {streamname} > ${each.value.GetRecords_iterator_age_metric_critical}" : each.value.query
  message  = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — GetRecords iterator age of the stream {{streamname.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM 
  #"GetRecords iterator age of the stream {{streamname.name}} is {{value}} for last 5minutes"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — GetRecords iterator age of the stream {{streamname.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
 tags = [
  "env:${var.environment}",
  "service:${each.value.service_name}",
  "metric-type:operator",
  "resource_type:kinesis-stream",
  "component_name:${each.value.component_name}",
  "component_type:datastream",
  "roster:${each.value.roster}"
]
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  include_tags = true
    monitor_thresholds {
      critical = each.value.GetRecords_iterator_age_metric_critical

      }
}

resource "datadog_monitor" "spni_read_throttling"{
  for_each = { for i in var.KINESIS_STREAM_service_name : i.component_name => i }
  name     = "spni-kinesis-stream-${var.environment}-read-throttling-${each.value.component_name}"
  priority = each.value.priority
  type     = "metric alert"
  evaluation_delay = 900
  query    = each.value.query == "" ? "sum(${each.value.query_time_window}):sum:aws.kinesis.read_provisioned_throughput_exceeded{component_name:${each.value.component_name} AND environment:${var.environment}} by {streamname}.as_count() / sum:aws.kinesis.get_records_success{component_name:${each.value.component_name}} by {streamname}.as_count() * 100 >  ${each.value.read_throttling_metric_critical}" : each.value.query
  message  =  <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Read throttling of the stream {{streamname.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"Read throttling of the stream {{streamname.name}} is {{value}} for last 5minutes"
  escalation_message =<<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Read throttling of the stream {{streamname.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  tags = [
  "env:${var.environment}",
  "service:${each.value.service_name}",
  "metric-type:operator",
  "resource_type:kinesis-stream",
  "component_name:${each.value.component_name}",
  "component_type:datastream",
  "roster:${each.value.roster}"
]
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  include_tags = true
    monitor_thresholds {
      critical = each.value.read_throttling_metric_critical
      }
}

resource "datadog_monitor" "spni_write_throttling"{
  for_each = { for i in var.KINESIS_STREAM_service_name : i.component_name => i }
  name     = "spni-kinesis-stream-${var.environment}-write-throttling-${each.value.component_name}"
  priority = each.value.priority
  type     = "metric alert"
  evaluation_delay = 900
  query    = each.value.query == "" ? "sum(${each.value.query_time_window}):sum:aws.kinesis.put_records_throttled_records{component_name:${each.value.component_name} AND environment:${var.environment}} by {streamname}.as_count() / sum:aws.kinesis.put_records_success{component_name:${each.value.component_name} AND environment:${var.environment}} by {streamname}.as_count() > ${each.value.write_throttling_metric_critical}" : each.value.query
  message  =  <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Write throttling of the stream {{streamname.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"Write throttling of the stream {{streamname.name}} is {{value}} for last 5minutes"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Write throttling of the stream {{streamname.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
   tags = [
  "env:${var.environment}",
  "service:${each.value.service_name}",
  "metric-type:operator",
  "resource_type:kinesis-stream",
  "component_name:${each.value.component_name}",
  "component_type:datastream",
  "roster:${each.value.roster}"
]
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  include_tags = true
    monitor_thresholds {
      critical = each.value.write_throttling_metric_critical
      }
}


#readlatency

resource "datadog_monitor" "spni_read_latency"{
  for_each = { for i in var.KINESIS_STREAM_service_name : i.component_name => i }
  name     = "spni-kinesis-stream-${var.environment}-read-latency-${each.value.component_name}"
  priority = each.value.priority
  type     = "metric alert"
  evaluation_delay = 900
  query    = each.value.query == "" ? "avg(${each.value.query_time_window}):avg:aws.kinesis.get_records_latency{component_name:${each.value.component_name} AND environment:${var.environment}} by {streamname} > ${each.value.read_latency_metric_critical}" : each.value.query
  message  =  <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Read latency of the stream {{streamname.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"Read latency of the stream {{streamname.name}} is {{value}} for last 5minutes"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Read latency of the stream {{streamname.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
   tags = [
  "env:${var.environment}",
  "service:${each.value.service_name}",
  "metric-type:operator",
  "resource_type:kinesis-stream",
  "component_name:${each.value.component_name}",
  "component_type:datastream",
  "roster:${each.value.roster}"
]
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  include_tags = true
    monitor_thresholds {
      critical = each.value.read_latency_metric_critical
      }
}
#write latency

resource "datadog_monitor" "spni_write_latency"{
  for_each = { for i in var.KINESIS_STREAM_service_name : i.component_name => i }
  name     = "spni-kinesis-stream-${var.environment}-write-latency-${each.value.component_name}"
  priority = each.value.priority
  type     = "metric alert"
  evaluation_delay = 900
  query    = each.value.query == "" ? "avg(${each.value.query_time_window}):avg:aws.kinesis.put_records_latency{component_name:${each.value.component_name} AND environment:${var.environment}} by {streamname} > ${each.value.write_latency_metric_critical}" : each.value.query
  message  =  <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Write latency of the stream {{streamname.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"Write latency of the stream {{streamname.name}} is {{value}} for last 5minutes"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Write latency of the stream {{streamname.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  tags = [
  "env:${var.environment}",
  "service:${each.value.service_name}",
  "metric-type:operator",
  "resource_type:kinesis-stream",
  "component_name:${each.value.component_name}",
  "component_type:datastream",
  "roster:${each.value.roster}"
]
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  include_tags = true
    monitor_thresholds {
      critical = each.value.write_latency_metric_critical
      }
}
