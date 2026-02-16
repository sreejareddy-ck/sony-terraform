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


resource "datadog_monitor" "spni_ecs_cpu_utilization" {
  for_each = { for x in var.cluster_service_name : x.component_name => x }
  name  = "${var.environment}-${each.value.component_name}-ecs-cluster-cpu-usage-high"
  priority =  each.value.priority
  type     = "metric alert"

  query =  each.value.query == "" ? "min(${each.value.query_time_window}):avg:aws.ecs.service.cpuutilization{environment:${var.environment},component_name:${each.value.component_name}} by {clustername} > ${each.value.cluster_cpu_utilization_threshold_critical}": each.value.query
  
  message  = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name}  cluster: {{clustername.name}} — cpu utilisation is high {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
   escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} cluster: {{clustername.name}} — cpu utilisation is high {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  
  monitor_thresholds {
    critical = each.value.cluster_cpu_utilization_threshold_critical
  }

  evaluation_delay    = var.evaluation_delay
  new_group_delay     = var.new_group_delay
  on_missing_data    = "show_no_data"
  require_full_window = false
  renotify_interval   = 0
  notify_audit        = false
  timeout_h           = var.timeout_h
  include_tags        = true
  tags = [
        "env:${var.environment}",
        "service:${each.value.service_name}",
        "metric-type:operator",
        "resource_type:ecs",
        "component_name:${each.value.component_name}",
        "component_type:ecs",
        "roster:${each.value.roster}"
        ]
}

resource "datadog_monitor" "spni_ecs_memory_reservation" {
  for_each = { for x in var.cluster_service_name : x.component_name => x }
  name  = "${var.environment}-${each.value.component_name}-ecs-cluster-memory-usage-high"
  message  = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} cluster: {{clustername.name}} — memory reservation is high {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} cluster: {{clustername.name}} — memory reservation is high {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  priority = each.value.priority
  type     = "metric alert"

  query =  each.value.query == "" ? "min(${each.value.query_time_window}):avg:aws.ecs.service.memory_utilization{environment:${var.environment},component_name:${each.value.component_name}} by {clustername} > ${each.value.cluster_memory_reservation_threshold_critical}": each.value.query

  monitor_thresholds {
    critical = each.value.cluster_memory_reservation_threshold_critical
  }

  evaluation_delay    = var.evaluation_delay
  new_group_delay     = var.new_group_delay
  on_missing_data    = "show_no_data"
  require_full_window = false
  renotify_interval   = 0
  notify_audit        = false
  timeout_h           = var.timeout_h
  include_tags        = true
  tags = [
        "env:${var.environment}",
        "service:${each.value.service_name}",
        "metric-type:operator",
        "resource_type:ecs",
        "component_name:${each.value.component_name}",
        "component_type:ecs",
        "roster:${each.value.roster}"
        ]
}