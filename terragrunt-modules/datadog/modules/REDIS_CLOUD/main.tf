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
resource "datadog_monitor" "spni_rdsc_bdb_avg_latency" {
  for_each = { for redis_cloud in var.redis_cloud_monitors : redis_cloud.component_name => redis_cloud }
  name    = "${var.environment}-${each.value.component_name}-rdsc-bdb-avg-latency"
  type    = "metric alert"
  priority           = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true

  query = each.value.query != "" ? each.value.query : <<EOT
    min(${each.value.query_time_window}):avg:rdsc.bdb_avg_latency{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.rdsc_bdb_avg_latency_threshold_critical}
  EOT
  message = <<EOT
${each.value.message} average latency is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT  

 escalation_message = <<EOT
${each.value.message} average latency is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT  
  monitor_thresholds {
    critical = each.value.rdsc_bdb_avg_latency_threshold_critical
  }

    tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:redis_cloud",
    "component_name:${each.value.component_name}",
    "component_type:redis_cloud",
    "roster:${each.value.roster}"
  ]  
}  
resource "datadog_monitor" "spni_rdsc_redis_used_memory" {
  for_each = { for redis_cloud in var.redis_cloud_monitors : redis_cloud.component_name => redis_cloud }
  name    = "${var.environment}-${each.value.component_name}-rdsc-redis-used-memory"
  type    = "metric alert"
  priority           = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true

  query = each.value.query != "" ? each.value.query : <<EOT
    min(${each.value.query_time_window}):avg:rdsc.redis_used_memory{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} by {bdb,node,slots} > ${each.value.rdsc_redis_used_memory_threshold_critical}
  EOT
  message = <<EOT
${each.value.message} used memory is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT  

 escalation_message = <<EOT
${each.value.message} used memory is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT 

  monitor_thresholds {
    critical = each.value.rdsc_redis_used_memory_threshold_critical
  }

    tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:redis_cloud",
    "component_name:${each.value.component_name}",
    "component_type:redis_cloud",
    "roster:${each.value.roster}"
  ]  
}  

resource "datadog_monitor" "spni_rdsc_bdb_shard_cpu_user" {
  for_each = { for redis_cloud in var.redis_cloud_monitors : redis_cloud.component_name => redis_cloud }
  name    = "${var.environment}-${each.value.component_name}-rdsc-bdb-shard-cpu-user"
  type    = "metric alert"
  priority           = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true

  
  query = each.value.query != "" ? each.value.query : <<EOT
    min(${each.value.query_time_window}):avg:rdsc.bdb_shard_cpu_user{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.rdsc_bdb_shard_cpu_use_threshold_critical}
  EOT
  message = <<EOT
${each.value.message} shared CPU is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT  

 escalation_message = <<EOT
${each.value.message} shared CPU is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT 

  monitor_thresholds {
    critical = each.value.rdsc_bdb_shard_cpu_use_threshold_critical
  }

    tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:redis_cloud",
    "component_name:${each.value.component_name}",
    "component_type:redis_cloud",
    "roster:${each.value.roster}"
  ]  
}  
/*
resource "datadog_monitor" "spni_rdsc_bdb_conns" {
  for_each = { for redis_cloud in var.redis_cloud_monitors : redis_cloud.component_name => redis_cloud }
  name    = "${var.environment}-${each.value.component_name}-rdsc-bdb_conns"
  type    = "metric alert"
  priority           = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  notify_no_data     = false
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true

  query = each.value.query != "" ? each.value.query : <<EOT
    min(${each.value.query_time_window}):avg:rdsc.bdb_conns{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.rdsc_bdb_conns_threshold_critical}
  EOT
  message = <<EOT
${each.value.message} No.of connections is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT  

 escalation_message = <<EOT
${each.value.message} No.of connections is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT 

  monitor_thresholds {
    critical = each.value.rdsc_bdb_conns_threshold_critical
  }

    tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:redis_cloud",
    "component_name:${each.value.component_name}",
    "component_type:redis_cloud",
    "roster:${each.value.roster}"
  ]  
}  */

resource "datadog_monitor" "spni_rdsc_bdb_ingress_bytes" {
  for_each = { for redis_cloud in var.redis_cloud_monitors : redis_cloud.component_name => redis_cloud }
  name    = "${var.environment}-${each.value.component_name}-rdsc-bdb-ingress-bytes"
  type    = "metric alert"
  priority           = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true

  query = each.value.query != "" ? each.value.query : <<EOT
    min(${each.value.query_time_window}):avg:rdsc.bdb_ingress_bytes{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.rdsc_bdb_ingress_bytes_threshold_critical}
  EOT
  message = <<EOT
${each.value.message} ingress bytes is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT  

 escalation_message = <<EOT
${each.value.message} ingress bytes is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT 

  monitor_thresholds {
    critical = each.value.rdsc_bdb_ingress_bytes_threshold_critical
  }

    tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:redis_cloud",
    "component_name:${each.value.component_name}",
    "component_type:redis_cloud",
    "roster:${each.value.roster}"
  ]  
} 
resource "datadog_monitor" "spni_rdsc_bdb_egress_bytes" {
  for_each = { for redis_cloud in var.redis_cloud_monitors : redis_cloud.component_name => redis_cloud }
  name    = "${var.environment}-${each.value.component_name}-rdsc-bdb-egress-bytes"
  type    = "metric alert"
  priority           = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true

  query = each.value.query != "" ? each.value.query : <<EOT
    min(${each.value.query_time_window}):avg:rdsc.bdb_egress_bytes{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.rdsc_bdb_egress_bytes_threshold_critical}
  EOT
  message = <<EOT
${each.value.message} engress bytes is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT  

 escalation_message = <<EOT
${each.value.message} engress bytes is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT 

  monitor_thresholds {
    critical = each.value.rdsc_bdb_egress_bytes_threshold_critical
  }

    tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:redis_cloud",
    "component_name:${each.value.component_name}",
    "component_type:redis_cloud",
    "roster:${each.value.roster}"
  ]  
} 
resource "datadog_monitor" "spni_rdsc_node_ingress_bytes_max" {
  for_each = { for redis_cloud in var.redis_cloud_monitors : redis_cloud.component_name => redis_cloud }
  name    = "${var.environment}-${each.value.component_name}-rdsc-node-ingress-bytes-max"
  type    = "metric alert"
  priority           = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true

  query = each.value.query != "" ? each.value.query : <<EOT
    min(${each.value.query_time_window}):avg:rdsc.node_ingress_bytes_max{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.rdsc_node_ingress_bytes_max_threshold_critical}
  EOT
  message = <<EOT
${each.value.message} Node ingress bytes is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT  

 escalation_message = <<EOT
${each.value.message} Node ingress bytes is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT 

  monitor_thresholds {
    critical = each.value.rdsc_node_ingress_bytes_max_threshold_critical
  }

    tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:redis_cloud",
    "component_name:${each.value.component_name}",
    "component_type:redis_cloud",
    "roster:${each.value.roster}"
  ]  
} 
resource "datadog_monitor" "spni_rdsc_node_egress_bytes_max" {
  for_each = { for redis_cloud in var.redis_cloud_monitors : redis_cloud.component_name => redis_cloud }
  name    = "${var.environment}-${each.value.component_name}-rdsc-node-egress-bytes-max"
  type    = "metric alert"
  priority           = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true

  query = each.value.query != "" ? each.value.query : <<EOT
    min(${each.value.query_time_window}):avg:rdsc.node_egress_bytes_max{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.rdsc_node_egress_bytes_max_threshold_critical}
  EOT
  message = <<EOT
${each.value.message} Node egress bytes is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT  

 escalation_message = <<EOT
${each.value.message} Node egress bytes is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT 

  monitor_thresholds {
    critical = each.value.rdsc_node_egress_bytes_max_threshold_critical
  }

    tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:redis_cloud",
    "component_name:${each.value.component_name}",
    "component_type:redis_cloud",
    "roster:${each.value.roster}"
  ]  
}   
resource "datadog_monitor" "spni_rdsc_node_cpu_idle" {
  for_each = { for redis_cloud in var.redis_cloud_monitors : redis_cloud.component_name => redis_cloud }
  name    = "${var.environment}-${each.value.component_name}-rdsc-node-cpu-idle"
  type    = "metric alert"
  priority           = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true

  query = each.value.query != "" ? each.value.query : <<EOT
    min(${each.value.query_time_window}):100 - avg:rdsc.node_cpu_idle{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} < ${each.value.rdsc_node_cpu_idle_threshold_critical}
  EOT
  message = <<EOT
${each.value.message} Node CPU idle is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT  

 escalation_message = <<EOT
${each.value.message} Node CPU idle is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT 

  monitor_thresholds {
    critical = each.value.rdsc_node_cpu_idle_threshold_critical
  }

    tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:redis_cloud",
    "component_name:${each.value.component_name}",
    "component_type:redis_cloud",
    "roster:${each.value.roster}"
  ]  
}  
resource "datadog_monitor" "spni_proxy_cpu" {
  for_each = { for redis_cloud in var.redis_cloud_monitors : redis_cloud.component_name => redis_cloud }
  name    = "${var.environment}-${each.value.component_name}-rdsc-proxy-cpu"
  type    = "metric alert"
  priority           = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true

  query = each.value.query != "" ? each.value.query : <<EOT
    min(${each.value.query_time_window}):avg:rdsc.dmcproxy_process_cpu_usage_percent{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.rdsc_proxy_cpu_threshold_critical}
  EOT
  message = <<EOT
${each.value.message} Proxy cpu is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT  

 escalation_message = <<EOT
${each.value.message} Proxy cpu is high for ${each.value.component_name} of service: ${each.value.service_name} in ${var.environment}.

Notification: ${each.value.notification_channel}

Runbook: ${each.value.runbook}
EOT 
  monitor_thresholds {
    critical = each.value.rdsc_proxy_cpu_threshold_critical
  }

    tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:redis_cloud",
    "component_name:${each.value.component_name}",
    "component_type:redis_cloud",
    "roster:${each.value.roster}"
  ]  
}  