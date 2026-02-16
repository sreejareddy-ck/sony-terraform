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

resource "datadog_monitor" "spni_cpu_usage" {
  for_each = { for ec2 in var.ec2_service_name : ec2.component_name => ec2 }

  name    = "${var.environment}-${each.value.component_name}-ec2-cpu-usage-high"
  type    = "metric alert"
  query   = "min(${each.value.query_time_window}):default_zero(100 - avg:system.cpu.idle{environment:${var.environment},component_name:${each.value.component_name},service_name:${each.value.service_name}} by {host}) > ${each.value.cpu_threshold_critical}"
  message = <<EOT
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} - *High CPU Usage Detected*

CPU utilization is above {{value}} on one or more EC2 instances.

Runbook: ${each.value.runbook}  

Notification: ${each.value.notification_channel} 

EOT

  monitor_thresholds {
    critical = each.value.cpu_threshold_critical
  }

  tags = [
    "environment:${var.environment}",
    "service:${each.value.service_name}",
    "component_name:${each.value.component_name}",
    "component_type:ec2",
    "roster:${each.value.roster}"
  ]

  priority            = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  renotify_interval   = 0
  evaluation_delay    = 900
  include_tags        = true
}

resource "datadog_monitor" "spni_disk_usage" {
  for_each = { for ec2 in var.ec2_service_name : ec2.component_name => ec2 }

  name    = "${var.environment}-${each.value.component_name}-ec2-disk-usage-high"
  type    = "metric alert"
  query   = "min(${each.value.query_time_window}):avg:system.disk.in_use{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} by {host} * 100 > ${each.value.disk_threshold_critical}"
  message = <<EOT
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} - *High Disk Usage Detected*

Disk usage is above {{value}} on one or more EC2 instances.

Runbook: ${each.value.runbook}  

Notification: ${each.value.notification_channel}  

EOT

  monitor_thresholds {
    critical = each.value.disk_threshold_critical
  }

  tags = [
    "environment:${var.environment}",
    "service:${each.value.service_name}",
    "component_name:${each.value.component_name}",
    "component_type:ec2",
    "roster:${each.value.roster}"
  ]

  priority            = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  renotify_interval   = 0
  evaluation_delay    = 900
  include_tags        = true
}

resource "datadog_monitor" "spni_memory_usage" {
  for_each = { for ec2 in var.ec2_service_name : ec2.component_name => ec2 }

  name    = "${var.environment}-${each.value.component_name}-ec2-memory-usage-high"
  type    = "metric alert"
  query   = <<EOT
min(${each.value.query_time_window}):(
  (
    avg:system.mem.used{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} by {host} -
    avg:system.mem.cached{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} by {host}
  ) / avg:system.mem.total{environment:${var.environment},service_name:${each.value.service_name},component_name:${each.value.component_name}} by {host}
) * 100 > ${each.value.memory_threshold_critical}
EOT

  message = <<EOT
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} - *High Memory Usage Detected*

Memory usage is above {{value}} on one or more EC2 instances.

Runbook: ${each.value.runbook}  
Notification: ${each.value.notification_channel}  

EOT

  monitor_thresholds {
    critical = each.value.memory_threshold_critical
  }

  tags = [
    "environment:${var.environment}",
    "service:${each.value.service_name}",
    "component_name:${each.value.component_name}",
    "component_type:ec2",
    "roster:${each.value.roster}"
  ]

  priority            = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  renotify_interval   = 0
  evaluation_delay    = 900
  include_tags        = true
}
