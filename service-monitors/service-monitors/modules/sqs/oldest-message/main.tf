resource "datadog_monitor" "sqs_oldest_message" {
  message            = "${var.message}\n\nOperator Runbook: ${var.runbook}\n\n${var.slack_channel}\n${var.squadcast_webhook}"
  name               = "SQS component:${var.component_name} of service:${var.service_name} has old messages"
  query              = "min(last_2m):avg:aws.sqs.approximate_age_of_oldest_message{environment:prod , component_name:${var.component_name}, service_name:${var.service_name}} by {queuename} > ${var.critical_threshold}"
  type               = "metric alert"
  escalation_message = var.escalation_message
  evaluation_delay   = 180
  include_tags       = true
  monitor_thresholds {
    critical          = var.critical_threshold
    critical_recovery = var.critical_recovery
    warning           = var.warning_threshold
    warning_recovery  = var.warning_recovery
  }
  new_group_delay          = 0
  no_data_timeframe        = 10
  notification_preset_name = "hide_all"
  notify_audit             = true
  notify_no_data           = true
  renotify_interval        = 2
  renotify_occurrences     = 2
  renotify_statuses        = ["alert"]
  require_full_window      = true
  restricted_roles         = []
  tags = ["env:prod",
    "service:${var.datadog_service_tag}",
    "metric-type:operator",
    "environment:prod",
    "service_name:${var.service_name}",
    "component_name:${var.component_name}",
    "component_type:sqs",
    "resource_type:sqs",
    "roster:${var.roster}"
  ]
  validate = true
}
