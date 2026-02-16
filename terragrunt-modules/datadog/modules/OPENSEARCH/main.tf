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
  opensearch_monitors_map = {
    for os in var.opensearch_monitors : os.component_name => os
  }
}

resource "datadog_monitor" "spni_opensearch_nodes_minimum" {
  for_each = local.opensearch_monitors_map

  name  = "${var.environment}-${each.value.component_name}-opensearch-nodes-minimum"
  type  = "query alert"
  priority = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true
  query = "min(${each.value.query_time_window}):avg:aws.es.nodes.minimum{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} < ${each.value.nodes_minimum_critical}"

  message = <<EOT
OpenSearch node count is LOW for ${each.value.component_name} in ${var.environment}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOT
  escalation_message = <<EOT
OpenSearch node count is LOW for ${each.value.component_name} in ${var.environment}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOT
  monitor_thresholds {
    critical = each.value.nodes_minimum_critical
  }

  tags = [
    "env:${var.environment}",
    "service_name:${each.value.service_name}",
    "component_name:${each.value.component_name}",
    "resource_type:opensearch",
    "component_type:elasticsearch",
    "metric-type:operator",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_opensearch_cpuutilization_maximum" {
  for_each = local.opensearch_monitors_map

  name  = "${var.environment}-${each.value.component_name}-opensearch-cpuutilization-maximum"
  type  = "query alert"
  priority = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true
  query = "min(${each.value.query_time_window}):avg:aws.es.cpuutilization.maximum{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.cpuutilization_maximum_critical}"

  message = <<EOT
OpenSearch CPU utilization is HIGH for ${each.value.component_name} in ${var.environment}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOT
  escalation_message = <<EOT
OpenSearch CPU utilization is HIGH for ${each.value.component_name} in ${var.environment}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOT
  monitor_thresholds {
    critical = each.value.cpuutilization_maximum_critical
  }

  tags = [
    "env:${var.environment}",
    "service_name:${each.value.service_name}",
    "component_name:${each.value.component_name}",
    "resource_type:opensearch",
    "component_type:elasticsearch",
    "metric-type:operator",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_opensearch_jvmmemory_pressure_maximum" {
  for_each = local.opensearch_monitors_map

  name  = "${var.environment}-${each.value.component_name}-opensearch-jvm-memory-pressure-maximum"
  type  = "query alert"
  priority = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true
  query = "min(${each.value.query_time_window}):avg:aws.es.jvmmemory_pressure.maximum{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.jvm_memory_pressure_maximum_critical}"

  message = <<EOT
OpenSearch JVM memory pressure is HIGH for ${each.value.component_name} in ${var.environment}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOT
  escalation_message = <<EOT
OpenSearch JVM memory pressure is HIGH for ${each.value.component_name} in ${var.environment}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOT
  monitor_thresholds {
    critical = each.value.jvm_memory_pressure_maximum_critical
  }

  tags = [
    "env:${var.environment}",
    "service_name:${each.value.service_name}",
    "component_name:${each.value.component_name}",
    "resource_type:opensearch",
    "component_type:elasticsearch",
    "metric-type:operator",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_opensearch_cluster_statusred_maximum" {
  for_each = local.opensearch_monitors_map

  name  = "${var.environment}-${each.value.component_name}-opensearch-cluster-statusred-maximum"
  type  = "query alert"
  priority = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true
  query = "min(${each.value.query_time_window}):avg:aws.es.cluster_statusred.maximum{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.cluster_statusred_maximum_critical}"

  message = <<EOT
OpenSearch cluster status RED for ${each.value.component_name} in ${var.environment}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOT
  escalation_message = <<EOT
OpenSearch cluster status RED for ${each.value.component_name} in ${var.environment}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOT

  monitor_thresholds {
    critical = each.value.cluster_statusred_maximum_critical
  }

  tags = [
    "env:${var.environment}",
    "service_name:${each.value.service_name}",
    "component_name:${each.value.component_name}",
    "resource_type:opensearch",
    "component_type:elasticsearch",
    "metric-type:operator",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_opensearch_free_storage_space_minimum" {
  for_each = local.opensearch_monitors_map

  name  = "${var.environment}-${each.value.component_name}-opensearch-free-storage-space-minimum"
  type  = "query alert"
  priority = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true
  query = "min(${each.value.query_time_window}):avg:aws.es.free_storage_space.minimum{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} < ${each.value.free_storage_space_minimum_critical}"

  message = <<EOT
OpenSearch free storage space is LOW for ${each.value.component_name} in ${var.environment}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOT
  escalation_message = <<EOT
OpenSearch free storage space is LOW for ${each.value.component_name} in ${var.environment}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOT

  monitor_thresholds {
    critical = each.value.free_storage_space_minimum_critical
  }

  tags = [
    "env:${var.environment}",
    "service_name:${each.value.service_name}",
    "component_name:${each.value.component_name}",
    "resource_type:opensearch",
    "component_type:elasticsearch",
    "metric-type:operator",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_opensearch_threadpool_search_rejected" {
  for_each = local.opensearch_monitors_map

  name  = "${var.environment}-${each.value.component_name}-opensearch-threadpool-search-rejected"
  type  = "query alert"
  priority = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true
  query = "min(${each.value.query_time_window}):avg:aws.es.threadpool_search_rejected{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.threadpool_search_rejected_critical}"

  message = <<EOT
OpenSearch threadpool search rejected is HIGH for ${each.value.component_name} in ${var.environment}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOT
  escalation_message = <<EOT
OpenSearch threadpool search rejected is HIGH for ${each.value.component_name} in ${var.environment}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOT
  monitor_thresholds {
    critical = each.value.threadpool_search_rejected_critical
  }

  tags = [
    "env:${var.environment}",
    "service_name:${each.value.service_name}",
    "component_name:${each.value.component_name}",
    "resource_type:opensearch",
    "component_type:elasticsearch",
    "metric-type:operator",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_opensearch_threadpool_write_rejected" {
  for_each = local.opensearch_monitors_map

  name  = "${var.environment}-${each.value.component_name}-opensearch-threadpool-write-rejected"
  type  = "query alert"
  priority = each.value.priority
  require_full_window = false
  evaluation_delay   = var.evaluation_delay
  timeout_h          = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval  = 0
  notify_audit       = false
  include_tags       = true
  query = "min(${each.value.query_time_window}):avg:aws.es.threadpool_write_rejected{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.threadpool_write_rejected_critical}"

  message = <<EOT
OpenSearch threadpool write rejected is HIGH for ${each.value.component_name} in ${var.environment}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOT
  escalation_message = <<EOT
OpenSearch threadpool write rejected is HIGH for ${each.value.component_name} in ${var.environment}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOT

  monitor_thresholds {
    critical = each.value.threadpool_write_rejected_critical
  }

  tags = [
    "env:${var.environment}",
    "service_name:${each.value.service_name}",
    "component_name:${each.value.component_name}",
    "resource_type:opensearch",
    "component_type:elasticsearch",
    "metric-type:operator",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_opensearch_iops_throttle" {
  for_each = local.opensearch_monitors_map

  name    = "${var.environment}-${each.value.component_name}-opensearch-iops-throttle"
  type    = "query alert"
  priority = each.value.priority
  require_full_window = false
  evaluation_delay    = var.evaluation_delay
  timeout_h           = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval   = 0
  notify_audit        = false
  include_tags        = true

  query = "min(${each.value.query_time_window}):avg:aws.es.iops_throttle{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.iops_throttle_critical}"

  message = <<EOT
OpenSearch **IOPS throttling** is happening for ${each.value.component_name} in ${var.environment}.
This indicates microbursting above thresholds.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOT

  escalation_message = <<EOT
OpenSearch **IOPS throttling** persists for ${each.value.component_name} in ${var.environment}.
Please investigate immediately.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOT

  monitor_thresholds {
    critical = each.value.iops_throttle_critical
  }

  tags = [
    "env:${var.environment}",
    "service_name:${each.value.service_name}",
    "component_name:${each.value.component_name}",
    "resource_type:opensearch",
    "component_type:elasticsearch",
    "metric-type:operator",
    "roster:${each.value.roster}"
  ]
}


resource "datadog_monitor" "spni_opensearch_throughput_throttle" {
  for_each = local.opensearch_monitors_map

  name    = "${var.environment}-${each.value.component_name}-opensearch-throughput-throttle"
  type    = "query alert"
  priority = each.value.priority
  require_full_window = false
  evaluation_delay    = var.evaluation_delay
  timeout_h           = var.timeout_h
  on_missing_data    = "show_no_data"
  renotify_interval   = 0
  notify_audit        = false
  include_tags        = true

  query = "min(${each.value.query_time_window}):avg:aws.es.throughput_throttle{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} > ${each.value.throughput_throttle_critical}"

  message = <<EOT
OpenSearch **Throughput throttling** is happening for ${each.value.component_name} in ${var.environment}.
This indicates microbursting above thresholds.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOT

  escalation_message = <<EOT
OpenSearch **Throughput throttling** persists for ${each.value.component_name} in ${var.environment}.
Please investigate immediately.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOT

  monitor_thresholds {
    critical = each.value.throughput_throttle_critical
  }

  tags = [
    "env:${var.environment}",
    "service_name:${each.value.service_name}",
    "component_name:${each.value.component_name}",
    "resource_type:opensearch",
    "component_type:elasticsearch",
    "metric-type:operator",
    "roster:${each.value.roster}"
  ]
}
