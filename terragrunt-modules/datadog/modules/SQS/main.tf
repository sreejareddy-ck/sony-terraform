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

resource "datadog_monitor" "spni_sqs_no_messages_visible_monitor" {
  for_each = { for x in var.sqs_service_name : x.component_name => x }
  name  = "spni-${var.environment}-sqs-monitor-noofmessagesvisible-${each.value.component_name}"
  priority = each.value.priority
  type  = "query alert"
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900
  query =  each.value.query == "" ? "avg(${each.value.query_time_window["no_messages_visible_monitor"]}):avg:aws.sqs.approximate_number_of_messages_visible{service_name:${each.value.service_name},component_name:${each.value.component_name},environment:${var.environment}*} by {queuename} > ${each.value.sqs_no_messages_visible_metric_critical}" : each.value.query
  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Number of visible messages in SQS Queue {{queuename.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
#"{{queuename.name}} no of messages is {{value}}  at {{last_triggered_at}} ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Number of visible messages in SQS Queue {{queuename.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:sqs",
    "component_name:${each.value.component_name}",
    "component_type:sqs",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds {
      critical = each.value.sqs_no_messages_visible_metric_critical  // This means the alert will trigger when the condition is met for 1 consecutive evaluation

    }
}

resource "datadog_monitor" "spni_sqs_oldestmessage_monitor" {
  for_each = { for x in var.sqs_service_name : x.component_name => x }
  name  = "spni-${var.environment}-sqs-monitor-oldestmessage-${each.value.component_name}"
  priority = each.value.priority
  type  = "query alert"
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900
  query = each.value.query == "" ? "avg(${each.value.query_time_window["oldestmessage_monitor"]}):avg:aws.sqs.approximate_age_of_oldest_message{service_name:${each.value.service_name},component_name:${each.value.component_name},environment:${var.environment}} by {queuename} > ${each.value.sqs_age_of_oldest_message_metric_critical}": each.value.query
  message            = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} reports old messages remaining in the SQS queue: {{queuename.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} reports old messages remaining in the SQS queue: {{queuename.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:sqs",
    "component_name:${each.value.component_name}",
    "component_type:sqs",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds {
      critical = each.value.sqs_age_of_oldest_message_metric_critical  // This means the alert will trigger when the condition is met for 1 consecutive evaluation
    
    }
}






