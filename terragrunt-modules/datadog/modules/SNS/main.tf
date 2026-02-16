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
resource "datadog_monitor" "spni_failure-rate" {
  for_each = { for sns in var.sns_monitors : sns.component_name => sns }
  name    = "${var.environment}-${each.value.component_name}-sns-failure-rate"
  type    = "metric alert"
  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — High failure Rate Detected. 

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel} 
EOM

  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — High failure Rate Detected.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel} 
EOM

  priority            = each.value.priority
  require_full_window = false
  evaluation_delay    = var.evaluation_delay
  timeout_h           = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval   = 0
  notify_audit        = false
  include_tags        = true

  query = each.value.query != "" ? each.value.query : "avg(${each.value.query_time_window}):100 * (sum:aws.sns.number_of_notifications_failed{environment:${var.environment}, service_name:${each.value.service_name}, component_name:${each.value.component_name}}.as_count()) / (sum:aws.sns.number_of_notifications_failed{environment:${var.environment}, service_name:${each.value.service_name}, component_name:${each.value.component_name}}.as_count() + sum:aws.sns.number_of_notifications_delivered{environment:${var.environment}, service_name:${each.value.service_name}, component_name:${each.value.component_name}}.as_count()) > ${each.value.sns_failure_rate_threshold_critical}"



  monitor_thresholds {
    critical = each.value.sns_failure_rate_threshold_critical
  }

    tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:sns",
    "component_name:${each.value.component_name}",
    "component_type:sns",
    "roster:${each.value.roster}"
  ]  
}  

resource "datadog_monitor" "spni_failed_notification_count" {
  for_each = { for sns in var.sns_monitors : sns.component_name => sns }
  name    = "${var.environment}-${each.value.component_name}-sns-failed-notification-count"
  type    = "metric alert"
  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — High failed notification count Detected. 

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — High failed notification count Detected.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel} 
EOM
  priority           = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true

  query = each.value.query != "" ? each.value.query : "sum(${each.value.query_time_window}):sum:aws.sns.number_of_notifications_failed{environment:${var.environment}, service_name:${each.value.service_name}, component_name:${each.value.component_name}}.as_count() > ${each.value.sns_failed_notification_count_threshold_critical}"
  


  monitor_thresholds {
    critical = each.value.sns_failed_notification_count_threshold_critical
  }

    tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:sns",
    "component_name:${each.value.component_name}",
    "component_type:sns",
    "roster:${each.value.roster}"
  ]  
}  

resource "datadog_monitor" "spni_Number_of_Messages_Published" {
  for_each = { for sns in var.sns_monitors : sns.component_name => sns }
  name    = "${var.environment}-${each.value.component_name}-sns-Number-of-Messages-Published"
  type    = "metric alert"
  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — High Number of Messages Published count Detected. 

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — High Number of Messages Published count Detected.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel} 
EOM
  priority           = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  #otify_no_data     = false
  on_missing_data      = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true

  query = each.value.query != "" ? each.value.query : "sum(${each.value.query_time_window}):sum:aws.sns.number_of_messages_published{environment:${var.environment}, service_name:${each.value.service_name}, component_name:${each.value.component_name}}.as_count() > ${each.value.sns_Number_of_Messages_Published_threshold_critical}"
 


  monitor_thresholds {
    critical = each.value.sns_Number_of_Messages_Published_threshold_critical
  }

    tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:sns",
    "component_name:${each.value.component_name}",
    "component_type:sns",
    "roster:${each.value.roster}"
  ]  
}  