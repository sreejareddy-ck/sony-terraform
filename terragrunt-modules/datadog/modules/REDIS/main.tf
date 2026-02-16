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

locals {
  redis_monitors_map = {
    for redis in var.redis_service_name : redis.component_name => redis
  }
}

resource "datadog_monitor" "spni_redis_avg_cpu_utilization" {
  for_each = local.redis_monitors_map

  name  = "${var.environment}-${each.value.component_name}-redis-avg-cpu-utilization"
  type  = "metric alert"
  priority = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true
  query = "min(${each.value.query_time_window}):avg:aws.elasticache.cpuutilization{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.redis_avg_cpu_utilization_critical}"

  message = <<EOT
${each.value.message} average CPU utilization is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT
  escalation_message = <<EOT
${each.value.message} average CPU utilization is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT
  monitor_thresholds {
    critical = each.value.redis_avg_cpu_utilization_critical
  }

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "component:${each.value.component_name}",
    "metric-type:operator",
    "resource_type:redis",
    "component_type:redis",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_redis_avg_engine_cpu_utilization" {
  for_each = local.redis_monitors_map

  name  = "${var.environment}-${each.value.component_name}-redis-avg-engine-cpu-utilization"
  type  = "metric alert"
  priority = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true
  query = "min(${each.value.query_time_window}):avg:aws.elasticache.engine_cpuutilization{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.redis_avg_engine_cpu_utilization_critical}"

  message = <<EOT
${each.value.message} engine CPU utilization is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT
  escalation_message = <<EOT
${each.value.message} engine CPU utilization is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT
  monitor_thresholds {
    critical = each.value.redis_avg_engine_cpu_utilization_critical
  }

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "component:${each.value.component_name}",
    "metric-type:operator",
    "resource_type:redis",
    "component_type:redis",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_redis_avg_get_type_latency" {
  for_each = local.redis_monitors_map

  name  = "${var.environment}-${each.value.component_name}-redis-avg-get-type-latency"
  type  = "query alert"
  priority = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true
  query = "min(${each.value.query_time_window}):avg:aws.elasticache.get_type_cmds_latency{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.redis_avg_get_type_latency_critical}"

  message = <<EOT
${each.value.message} GET latency is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT
  escalation_message = <<EOT
${each.value.message} GET latency is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT
  monitor_thresholds {
    critical = each.value.redis_avg_get_type_latency_critical
  }

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "component:${each.value.component_name}",
    "metric-type:operator",
    "resource_type:redis",
    "component_type:redis",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_redis_avg_memory_utilization" {
  for_each = local.redis_monitors_map

  name  = "${var.environment}-${each.value.component_name}-redis-avg-memory-utilization"
 type  = "metric alert"
  priority = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true
  query = "min(${each.value.query_time_window}):avg:aws.elasticache.database_memory_usage_percentage{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.redis_avg_memory_utilization_critical}"

  message = <<EOT
${each.value.message} memory utilization is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT
  escalation_message = <<EOT
${each.value.message} memory utilization is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT
  monitor_thresholds {
    critical = each.value.redis_avg_memory_utilization_critical
  }

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "component:${each.value.component_name}",
    "metric-type:operator",
    "resource_type:redis",
    "component_type:redis",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_redis_avg_set_type_latency" {
  for_each = local.redis_monitors_map

  name  = "${var.environment}-${each.value.component_name}-redis-avg-set-type-latency"
  type  = "query alert"
  priority = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true
  query = "min(${each.value.query_time_window}):avg:aws.elasticache.set_type_cmds_latency{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.redis_avg_set_type_latency_critical}"

  message = <<EOT
${each.value.message} SET latency is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT
  escalation_message = <<EOT
${each.value.message} SET latency is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT
  monitor_thresholds {
    critical = each.value.redis_avg_set_type_latency_critical
  }

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "component:${each.value.component_name}",
    "metric-type:operator",
    "resource_type:redis",
    "component_type:redis",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_redis_cache_hit_ratio" {
  for_each = local.redis_monitors_map

  name  = "${var.environment}-${each.value.component_name}-redis-cache-hit-ratio-low"
  type  = "query alert"
  priority = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true
  query = "min(${each.value.query_time_window}):avg:aws.elasticache.cache_hit_rate{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} < ${each.value.redis_cache_hit_ratio_critical}"

  message = <<EOT
${each.value.message} hit ratio is LOW for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT
  escalation_message = <<EOT
${each.value.message} hit ratio is LOW for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT
  monitor_thresholds {
    critical = each.value.redis_cache_hit_ratio_critical
  }

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "component:${each.value.component_name}",
    "metric-type:operator",
    "resource_type:redis",
    "component_type:redis",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_redis_connection_count" {
  for_each = local.redis_monitors_map

  name  = "${var.environment}-${each.value.component_name}-redis-connection-count-high"
  type  = "query alert"
  priority = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true
  query = "min(${each.value.query_time_window}):avg:aws.elasticache.curr_connections{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.redis_connection_count_critical}"

  message = <<EOT
${each.value.message} connection count is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT
  escalation_message = <<EOT
${each.value.message} connection count is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT
  monitor_thresholds {
    critical = each.value.redis_connection_count_critical
  }

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "component:${each.value.component_name}",
    "metric-type:operator",
    "resource_type:redis",
    "component_type:redis",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_redis_swap_usage" {
  for_each = local.redis_monitors_map

  name  = "${var.environment}-${each.value.component_name}-redis-swap-usage-high"
  type  = "query alert"
  priority = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true
  query = "min(${each.value.query_time_window}):avg:aws.elasticache.swap_usage{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.redis_swap_usage_critical}"

  message = <<EOT
${each.value.message} swap usage is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT
  escalation_message = <<EOT
${each.value.message} swap usage is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT
  monitor_thresholds {
    critical = each.value.redis_swap_usage_critical
  }

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "component:${each.value.component_name}",
    "metric-type:operator",
    "resource_type:redis",
    "component_type:redis",
    "roster:${each.value.roster}"
  ]
}
