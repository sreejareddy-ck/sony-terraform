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

#Aws firehose monitoring for datadog metrics ThrottledGetRecords,Firehose ThrottledGetRecords,DeliveryToS3.DataFreshness
resource "datadog_monitor" "spni_firhose_delivery_to_s3" {
  for_each = { for i in var.Firehose_service_name : i.component_name => i }
  name     = "spni-${var.environment}-firehose-delivery-to-s3-${each.value.component_name}"
  priority = each.value.priority
  type     = "metric alert"
  query    = each.value.query == "" ? "sum(${each.value.query_time_window}):sum:aws.firehose.delivery_to_s_3success{environment:${var.environment}* AND component_name:${each.value.component_name}*} by {deliverystreamname} <  ${each.value.s3_success_rate}" : each.value.query
  message  =  <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} has low S3 success rate for Firehose stream: {{deliverystreamname.name}} with value: {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
#"Firehose  {{deliverystreamname.name}} s3 success rate is dropped to {{value}} for last 5minutes ${each.value.notification_channel}"
  escalation_message =<<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} has low S3 success rate for Firehose stream: {{deliverystreamname.name}} with value: {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:kinesisfirehose",
    "component_name:${each.value.component_name}",
    "component_type:firehose",
    "roster:${each.value.roster}"
  ]
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  include_tags = true
  evaluation_delay = 900
  monitor_thresholds {
    critical = each.value.s3_success_rate
  }
}

resource "datadog_monitor" "spni_s3_data_freshness" {
  for_each = { for i in var.Firehose_service_name : i.component_name => i }
  name     = "spni-${var.environment}-firehose-s3-data-freshness-${each.value.component_name}"
  priority = each.value.priority
  type     = "metric alert"
  query    = each.value.query == "" ? "avg(${each.value.query_time_window}):avg:aws.firehose.delivery_to_s_3data_freshness{environment:${var.environment}* AND component_name:${each.value.component_name}*} by {deliverystreamname} > ${each.value.s3_data_freshness}" : each.value.query
  message  = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} has low S3 data freshness for Firehose stream: {{deliverystreamname.name}} with value: {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
 #Firehose {{deliverystreamname.name}} s3 data freshness is dropped to {{value}} for last 5minutes ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} has low S3 data freshness for Firehose stream: {{deliverystreamname.name}} with value: {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
 tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:kinesisfirehose",
    "component_name:${each.value.component_name}",
    "component_type:firehose",
    "roster:${each.value.roster}"
  ]
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  include_tags = true
  evaluation_delay = 900
  require_full_window = false
  monitor_thresholds {
    critical = each.value.s3_data_freshness
  }
}
resource "datadog_monitor" "spni_firehose_throttled_get_records" {
  for_each = { for i in var.Firehose_service_name : i.component_name => i }
  name     = "spni-${var.environment}-firehose-throttled-get-records-${each.value.component_name}"
  priority = each.value.priority
  type     = "metric alert"
  query    = each.value.query == "" ? "sum(${each.value.query_time_window}):sum:aws.firehose.throttled_records{environment:${var.environment}* AND component_name:${each.value.component_name}*} by {deliverystreamname} > ${each.value.throttled_get_records}" : each.value.query
  message  = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} has high throttled get records for Firehose stream: {{deliverystreamname.name}} with value: {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
#Firehose {{deliverystreamname.name}} throttled get records is dropped to {{value}} for last 5minutes ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} has high throttled get records for Firehose stream: {{deliverystreamname.name}} with value: {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:kinesisfirehose",
    "component_name:${each.value.component_name}",
    "component_type:firehose",
    "roster:${each.value.roster}"
  ]
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  include_tags = true
  evaluation_delay = 900
  monitor_thresholds {
    critical = each.value.throttled_get_records
  }
}








