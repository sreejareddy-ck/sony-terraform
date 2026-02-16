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


resource "datadog_monitor" "cold_start_rate" {
  for_each = { for lambda in var.lambda_monitors : lambda.component_name => lambda }

  name               = "${var.environment}-${each.value.component_name}-lambda-cold-start-rate-high"
  type               = "query alert"
  priority           = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  notify_no_data     = false
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true

  query = each.value.query != "" ? each.value.query : <<EOT
sum(${each.value.query_time_window["cold_start_rate"]}):sum:aws.lambda.enhanced.invocations{environment:${var.environment},cold_start:true,functionname:${each.value.component_name}}.as_count() /sum:aws.lambda.enhanced.invocations{environment:${var.environment},functionname:${each.value.component_name}}.as_count() >= ${each.value.cold_start_threshold_critical}
EOT

  message = <<EOM
{{#is_alert}}

${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — *High Cold Start Rate Detected* for `${each.value.function_name}`

More than {{eval "threshold * 100"}}% of this function’s invocations were cold starts.

**Next Steps:**
- [Invocation Spikes](/investigate/lambda/high-cold-starts/invocations?name=${each.value.function_name}&ts={{first_triggered_at_epoch}})
- [Cold Start Traces](/investigate/lambda/high-cold-starts/cold-start-invocations?name=${each.value.function_name}&ts={{first_triggered_at_epoch}})
- [Provisioned Concurrency](/investigate/lambda/high-cold-starts/concurrency)

Runbook: ${each.value.runbook}  

Notification: ${each.value.notification_channel} 

{{/is_alert}}

{{#is_recovery}}
Cold start rate has recovered for `${each.value.function_name}`.

[Recovery metrics](/investigate/lambda/high-cold-starts/metrics?name=${each.value.function_name}&ts={{last_triggered_at_epoch}})

{{/is_recovery}}
EOM
   escalation_message = <<EOM
{{#is_alert}}

${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — *High Cold Start Rate Detected* for `${each.value.function_name}`

More than {{eval "threshold * 100"}}% of this function’s invocations were cold starts.

**Next Steps:**
- [Invocation Spikes](/investigate/lambda/high-cold-starts/invocations?name=${each.value.function_name}&ts={{first_triggered_at_epoch}})
- [Cold Start Traces](/investigate/lambda/high-cold-starts/cold-start-invocations?name=${each.value.function_name}&ts={{first_triggered_at_epoch}})
- [Provisioned Concurrency](/investigate/lambda/high-cold-starts/concurrency)

Runbook: ${each.value.runbook}  

Notification: ${each.value.notification_channel}  

{{/is_alert}}

{{#is_recovery}}
Cold start rate has recovered for `${each.value.function_name}`.

[Recovery metrics](/investigate/lambda/high-cold-starts/metrics?name=${each.value.function_name}&ts={{last_triggered_at_epoch}})

{{/is_recovery}}
EOM
  monitor_thresholds {
    critical = each.value.cold_start_threshold_critical
  }

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:lambda",
    "component_name:${each.value.component_name}",
    "component_type:lambda",
    "roster:${each.value.roster}"
  ]
}


resource "datadog_monitor" "pct_errors" {
  for_each = { for lambda in var.lambda_monitors : lambda.component_name => lambda }
  name    = "${var.environment}-${each.value.component_name}-lambda-error-rate-high"
  type    = "metric alert"
  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — *High Error Rate Detected* for `${each.value.function_name}`

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel} 
EOM
  #"*High Error Rate Detected* for `${each.value.function_name}` "
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — *High Error Rate Detected* for `${each.value.function_name}`

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel} 
EOM
  priority           = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  notify_no_data     = false
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true

  query = each.value.query != "" ? each.value.query : <<EOT
    sum(${each.value.query_time_window["pct_errors"]}):default((default(sum:aws.lambda.errors{environment:${var.environment},functionname:${each.value.component_name}}.as_count(), 0) /
    default(sum:aws.lambda.invocations{environment:${var.environment},functionname:${each.value.component_name}}.as_count(), 1)) * 100, 0) >= ${each.value.pct_errors_threshold_critical}
  EOT


  monitor_thresholds {
    critical = each.value.pct_errors_threshold_critical
  }

    tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:lambda",
    "component_name:${each.value.component_name}",
    "component_type:lambda",
    "roster:${each.value.roster}"
  ]  
}  

# Throttles
resource "datadog_monitor" "throttles" {
  for_each = { for lambda in var.lambda_monitors : lambda.component_name => lambda }
  name    = "${var.environment}-${each.value.component_name}-lambda-throttle-high"
  type    = "metric alert"
  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — *High Throttling Detected* for `${each.value.function_name}`
Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"*High Throttling Detected* for `${each.value.function_name}` "
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — *High Throttling Detected* for `${each.value.function_name}`

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  priority           = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  notify_no_data     = false
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true

 query = each.value.query != "" ? each.value.query : <<EOQ
    sum(${each.value.query_time_window["throttles"]}):default((default(sum:aws.lambda.throttles{environment:${var.environment},functionname:${each.value.component_name}}.as_count(), 0) / (default(sum:aws.lambda.throttles{environment:${var.environment},functionname:${each.value.component_name}}.as_count(), 0) + default(sum:aws.lambda.invocations{environment:${var.environment},functionname:${each.value.component_name}}.as_count(), 1))), 0) >= ${each.value.throttles_threshold_critical}
  EOQ


  monitor_thresholds {
    critical = each.value.throttles_threshold_critical
  }

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:lambda",
    "component_name:${each.value.component_name}",
    "component_type:lambda",
    "roster:${each.value.roster}"
  ]  
}
