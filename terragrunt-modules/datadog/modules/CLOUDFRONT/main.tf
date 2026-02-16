  
terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

resource "datadog_monitor" "spni_cloudfront_4xx_error_rate" {
  for_each = { for CloudFront in var.CloudFront_monitors : CloudFront.component_name => CloudFront }

  name    = "${var.environment}-${each.value.component_name}-CloudFront-4xx-error-rate"
  type    = "metric alert"

  priority             = each.value.priority
  require_full_window  = false
  evaluation_delay     = var.evaluation_delay
  timeout_h            = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval    = 0
  notify_audit         = false
  include_tags         = true

  query = each.value.query != "" ? each.value.query : <<EOT
min(${each.value.query_time_window}):avg:aws.cloudfront.4xx_error_rate{
  environment:${var.environment},
  service_name:${each.value.service_name},
  component_name:${each.value.component_name}
} > ${each.value.cloudfront_4xx_errors_threshold_critical}
EOT
  message = <<EOT
${each.value.message} 4xx error rate is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT  

 escalation_message = <<EOT
${each.value.message} 4xx error rate is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT 
  monitor_thresholds {
    critical = each.value.cloudfront_4xx_errors_threshold_critical
  }

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:CloudFront",
    "component_name:${each.value.component_name}",
    "component_type:CloudFront",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_cloudfront_total_error_rate" {
  for_each = { for CloudFront in var.CloudFront_monitors : CloudFront.component_name => CloudFront }

  name    = "${var.environment}-${each.value.component_name}-CloudFront-total-error-rate"
  type    = "metric alert"
  priority             = each.value.priority
  require_full_window  = false
  evaluation_delay     = var.evaluation_delay
  timeout_h            = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval    = 0
  notify_audit         = false
  include_tags         = true

  query = each.value.query != "" ? each.value.query : <<EOT
min(${each.value.query_time_window}):avg:aws.cloudfront.total_error_rate{
  environment:${var.environment},
  service_name:${each.value.service_name},
  component_name:${each.value.component_name}
} > ${each.value.cloudfront_total_errors_threshold_critical}
EOT
  message = <<EOT
${each.value.message} Total error rate is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT  

 escalation_message = <<EOT
${each.value.message} Total error rate is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT 
  monitor_thresholds {
    critical = each.value.cloudfront_total_errors_threshold_critical
  }

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:CloudFront",
    "component_name:${each.value.component_name}",
    "component_type:CloudFront",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_cloudfront_5xx_error_rate" {
  for_each = { for CloudFront in var.CloudFront_monitors : CloudFront.component_name => CloudFront }

  name    = "${var.environment}-${each.value.component_name}-CloudFront-5xx-error-rate"
  type    = "metric alert"
  priority             = each.value.priority
  require_full_window  = false
  evaluation_delay     = var.evaluation_delay
  timeout_h            = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval    = 0
  notify_audit         = false
  include_tags         = true

  query = each.value.query != "" ? each.value.query : <<EOT
min(${each.value.query_time_window}):avg:aws.cloudfront.5xx_error_rate{
  environment:${var.environment},
  service_name:${each.value.service_name},
  component_name:${each.value.component_name}
} > ${each.value.cloudfront_5xx_errors_threshold_critical}
EOT
  message = <<EOT
${each.value.message} 5xx error rate is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT  

 escalation_message = <<EOT
${each.value.message} 5xx error rate is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT 
  monitor_thresholds {
    critical = each.value.cloudfront_5xx_errors_threshold_critical
  }

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:CloudFront",
    "component_name:${each.value.component_name}",
    "component_type:CloudFront",
    "roster:${each.value.roster}"
  ]
}
