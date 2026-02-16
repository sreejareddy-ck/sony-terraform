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

resource "datadog_monitor" "spni_emr_application_failed" {
  for_each = { for x in var.emr_service_name : x. component_name => x }
  name  = "spni-${var.environment}-emr-monitor-application-failed-${each.value.service_name}-${each.value. component_name}"
  type = "metric alert"
  priority = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900
  require_full_window = false
  query = each.value.query == "" ? "sum(${each.value.query_time_window}):sum:aws.elasticmapreduce.apps_failed.sum{component_name:${each.value.component_name} AND environment:${var.environment}} by {name} / sum:aws.elasticmapreduce.apps_submitted.sum{component_name:${each.value.component_name} AND environment:${var.environment}} by {name} * 100 > ${each.value.application_failed_metric}" : each.value.query
  message            = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Application failed for EMR Service {{name.name}} with value {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"Application failed for EMR Service {{name.name}} is {{value}} at {{last_triggered_at}} ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Application failed for EMR Service {{name.name}} with value {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:emr",
    "component_name:${each.value.component_name}",
    "component_type:emr",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds {
      critical = each.value.application_failed_metric
    }
}

resource "datadog_monitor" "spni_emr_application_pending" {
  for_each = { for x in var.emr_service_name : x. component_name => x }
  name  = "spni-${var.environment}-emr-monitor-application-pending-${each.value.service_name}-${each.value. component_name}"
  type = "metric alert"
  priority = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  require_full_window = false
  evaluation_delay = 900
  query = each.value.query == "" ? "sum(${each.value.query_time_window}):sum:aws.elasticmapreduce.container_pending_ratio{component_name:${each.value.component_name} AND environment:${var.environment}} by {name}  > ${each.value.application_pending_metric}" : each.value.query
  message            = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Application pending for EMR Service {{name.name}} with value {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"Application pending for EMR Service {{name.name}} is {{value}} at {{last_triggered_at}} ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Application pending for EMR Service {{name.name}} with value {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:emr",
    "component_name:${each.value.component_name}",
    "component_type:emr",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds {
      critical = each.value.application_pending_metric
    }
}

resource "datadog_monitor" "spni_emr_cluster_hfdc_utilisation"{
  for_each = { for x in var.emr_service_name : x. component_name => x }
  name  = "spni-${var.environment}-emr-monitor-cluster-hfdc-utilisation-${each.value.service_name}-${each.value. component_name}"
  type = "metric alert"
  priority = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  require_full_window = false
  evaluation_delay = 900
  query = each.value.query == "" ? "sum(${each.value.query_time_window}):avg:aws.elasticmapreduce.hdfsutilization{component_name:${each.value.component_name} AND environment:${var.environment}} by {name} > ${each.value.cluster_hfdc_utilisation_metric}" : each.value.query
  message            = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Cluster hfdc utilisation for EMR Service {{name.name}} with value {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Cluster hfdc utilisation for EMR Service {{name.name}} with value {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"Cluster hfdc utilisation for EMR Service {{name.name}} is {{value}} at {{last_triggered_at}} ${each.value.notification_channel}"
   tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:emr",
    "component_name:${each.value.component_name}",
    "component_type:emr",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds {
      critical = each.value.cluster_hfdc_utilisation_metric
    }
}

#EMR Cluster memory usage 
resource "datadog_monitor" "spni_emr_cluster_memory_usage" {
  for_each = { for x in var.emr_service_name : x. component_name => x }
  name  = "spni-${var.environment}-emr-monitor-cluster-memory-usage-${each.value.service_name}-${each.value. component_name}"
  type = "metric alert"
  priority = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900
  require_full_window = false
  query = each.value.query == "" ? "avg(last_10m):avg:aws.elasticmapreduce.yarnmemory_available_percentage{component_name:${each.value.component_name} AND environment:${var.environment}} by {name} < ${each.value.cluster_yarn_memory_utilisation_metric}" : each.value.query
  message            = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Cluster memory usage for EMR Service {{name.name}} with value {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"Cluster memory usage for EMR Service {{name.name}} is {{value}} at {{last_triggered_at}} ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Cluster memory usage for EMR Service {{name.name}} with value {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:emr",
    "component_name:${each.value.component_name}",
    "component_type:emr",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds {
      critical = each.value.cluster_yarn_memory_utilisation_metric
    }
}


resource "datadog_monitor" "spmi_emr_unhealthy_nodes" {
  for_each = { for x in var.emr_service_name : x. component_name => x }
  name  = "spni-${var.environment}-emr-monitor-unhealthy-nodes-${each.value.service_name}-${each.value. component_name}"
  type = "metric alert"
  priority = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  require_full_window = false
  evaluation_delay = 900
  query = each.value.query == "" ? "avg(${each.value.query_time_window}):avg:aws.elasticmapreduce.mrunhealthy_nodes.sum{component_name:${each.value.component_name} AND environment:${var.environment}} by {name} / avg:aws.elasticmapreduce.mrtotal_nodes.sum{component_name:${each.value.component_name} AND environment:${var.environment}} by {name} * 100 > ${each.value.cluster_unhealthy_nodes_metric}" : each.value.query 
  message            = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Unhealthy nodes for EMR Service {{name.name}} with value {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Unhealthy nodes for EMR Service {{name.name}} with value {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"Unhealthy nodes for EMR Service {{name.name}} is {{value}} at {{last_triggered_at}} ${each.value.notification_channel}"
 tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:emr",
    "component_name:${each.value.component_name}",
    "component_type:emr",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds {
      critical = each.value.cluster_unhealthy_nodes_metric
    }
}

