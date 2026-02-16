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

resource "datadog_monitor" "spni_mwaa_cpu_usage_monitor" {
  for_each = { for x in var.mwaa_service_name : x.service_name => x }
  name  = "spni-${var.environment}-mwaa-monitor-cpu-usage-${each.value.component_name}"
  priority = each.value.priority
  type  = "query alert"
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900
  query =  each.value.query == "" ? "avg(${each.value.query_time_window}):avg:aws.mwaa.cpuutilization{environment:${each.value.component_name}*} by {environment} > ${each.value.mwaa_cpu_metric_critical}" : each.value.query
  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — CPU utilization for environment {{environment.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"cpu utilisation for {{environment.name}} is {{value}}  at {{last_triggered_at}} ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — CPU utilization for environment {{environment.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:mwaa",
    "component_name:${each.value.component_name}",
    "component_type:mwaa",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds {
      critical = each.value.mwaa_cpu_metric_critical  // This means the alert will trigger when the condition is met for 1 consecutive evaluation
    }
}

resource "datadog_monitor" "spni_mwaa_memory_usage_monitor" {
  for_each = { for x in var.mwaa_service_name : x.service_name => x }
  name  = "spni-${var.environment}-mwaa-monitor-memory-usage-${each.value.component_name}"
  priority = each.value.priority
  type  = "query alert"
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900
  query = each.value.query == "" ? "avg(${each.value.query_time_window}):avg:aws.mwaa.memory_utilization{environment:${each.value.component_name}} by {environment} > ${each.value.mwaa_memory_metric_critical}": each.value.query
  # query = each.value.query == "" ? "avg(last_5m):avg:aws.mwaa.memory_utilization{environment:${each.value.component_name}} by {environment} > ${each.value.mwaa_memory_metric_critical}": each.value.query
  message            = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Memory utilization for environment {{environment.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"Memory utilisation for {{environment.name}} is {{value}}  at {{last_triggered_at}} ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Memory utilization for environment {{environment.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:mwaa",
    "component_name:${each.value.component_name}",
    "component_type:mwaa",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds {
      critical = each.value.mwaa_memory_metric_critical  // This means the alert will trigger when the condition is met for 1 consecutive evaluation
    }
}


resource "datadog_monitor" "spni_mwaa_oldest_task_monitor" {
  for_each = { for x in var.mwaa_service_name : x.service_name => x }
  name  = "spni-${var.environment}-mwaa-monitor-oldest_task-${each.value.component_name}"
  priority = each.value.priority
  type  = "query alert"
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900
  query = each.value.query == "" ? "avg(${each.value.query_time_window}):avg:aws.mwaa.approximate_age_of_oldest_task{environment:${each.value.component_name}} /60 > ${each.value.mwaa_oldest_task_metric_critical}": each.value.query
  message            = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Oldest task for environment {{environment.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"oldest_task for {{environment.name}} is {{value}}  at {{last_triggered_at}} ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Oldest task for environment {{environment.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:mwaa",
    "component_name:${each.value.component_name}",
    "component_type:mwaa",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds {
      critical = each.value.mwaa_oldest_task_metric_critical  // This means the alert will trigger when the condition is met for 1 consecutive evaluation
    }
}


resource "datadog_monitor" "spni_mwaa_queued_tasks_usage_monitor" {
  for_each = { for x in var.mwaa_service_name : x.service_name => x }
  name  = "spni-${var.environment}-mwaa-monitor-queued_tasks-${each.value.component_name}"
  priority = each.value.priority
  type  = "query alert"
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900
  query = each.value.query == "" ? "avg(${each.value.query_time_window}):avg:aws.mwaa.queued_tasks{environment:${each.value.component_name}} by {environment} > ${each.value.mwaa_queued_tasks_metric_critical}": each.value.query
  message            = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Queued tasks for environment {{environment.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"queued tasks for {{environment.name}} is {{value}}  at {{last_triggered_at}} ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Queued tasks for environment {{environment.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
   tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:mwaa",
    "component_name:${each.value.component_name}",
    "component_type:mwaa",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds {
      critical = each.value.mwaa_queued_tasks_metric_critical  // This means the alert will trigger when the condition is met for 1 consecutive evaluation
    }
}

resource "datadog_monitor" "spni_mwaa_dag_run_failure_monitor" {
  for_each = { for x in var.mwaa_service_name : x.service_name => x }
  name  = "spni-${var.environment}-mwaa-monitor-dag_run_failure-${each.value.component_name}"
  priority = each.value.priority
  type  = "query alert"
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900
  query = each.value.query == "" ? "sum(${each.value.query_time_window}):sum:aws.mwaa.task_instance_finished{state:failed,environment:${each.value.component_name}} by {dag,state,task}.as_count() > ${each.value.mwaa_dag_run_failure_metric_critical}": each.value.query
  message            =  <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — DAG run failure for DAG {{dag.name}}, task {{task.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"dag run failure for {{dag.name}} {{task.name}} is {{value}}  at {{last_triggered_at}} ${each.value.notification_channel}"
  escalation_message =  <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — DAG run failure for DAG {{dag.name}}, task {{task.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
 tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:mwaa",
    "component_name:${each.value.component_name}",
    "component_type:mwaa",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds {
      critical = each.value.mwaa_dag_run_failure_metric_critical  // This means the alert will trigger when the condition is met for 1 consecutive evaluation
    }
}



