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

resource "datadog_monitor" "spni_lb_5xx"{
  for_each = {for i in var.LB_service_name : i.component_name => i }
  name     = "spni-${var.environment}-lb-5xx-${each.value.component_name}"
  priority = each.value.priority
  type     = "metric alert"
  evaluation_delay = 900
  query    = each.value.query == "" ? "sum(${each.value.query_time_window}):sum:aws.applicationelb.httpcode_elb_5xx{component_name:${each.value.component_name} AND (env:${var.environment}* OR environment:${var.environment}*)} by {loadbalancer}.as_count() / sum:aws.applicationelb.request_count{component_name:${each.value.component_name} AND (env:${var.environment}* OR environment:${var.environment}*)} by {loadbalancer}.as_count() * 100 > ${each.value.lb_5xx_metric_critical}" : each.value.query
  message  =  <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — 5XX errors of the Load Balancer {{loadbalancer.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"Lb 5xx  of the loadbalancer {{loadbalancer.name}} is {{value}} for last 5minutes ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — 5XX errors of the Load Balancer {{loadbalancer.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
   tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:spm",
    "resource_type:alb",
    "component_name:${each.value.component_name}",
    "component_type:alb",
    "roster:${each.value.roster}"
  ]
  notify_no_data = false
  no_data_timeframe = 10
  include_tags = true
    monitor_thresholds {
      critical = each.value.lb_5xx_metric_critical
      }
  }

resource "datadog_monitor" "spni_lb_4xx" {
  for_each = {for i in var.LB_service_name : i.component_name => i }
  name     = "spni-${var.environment}-lb-4xx-${each.value.component_name}"
  priority = each.value.priority
  type     = "metric alert"
  evaluation_delay = 900
  query    = each.value.query == "" ? "sum(${each.value.query_time_window}):sum:aws.applicationelb.httpcode_elb_4xx{component_name:${each.value.component_name} AND (env:${var.environment}* OR environment:${var.environment}*)} by {loadbalancer}.as_count() / sum:aws.applicationelb.request_count{component_name:${each.value.component_name} AND (env:${var.environment}* OR environment:${var.environment}*)} by {loadbalancer}.as_count() * 100 > ${each.value.lb_4xx_metric_critical}" : each.value.query
  message  =  <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — 4XX errors of the Load Balancer {{loadbalancer.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"Lb 4xx of the loadbalancer {{loadbalancer.name}} is {{value}} for last 5minutes ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — 4XX errors of the Load Balancer {{loadbalancer.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:spm",
    "resource_type:alb",
    "component_name:${each.value.component_name}",
    "component_type:alb",
    "roster:${each.value.roster}"
  ]
  notify_no_data = false
  no_data_timeframe = 10
  include_tags = true
    monitor_thresholds {
      critical = each.value.lb_4xx_metric_critical
      }
}

resource "datadog_monitor" "spni_lb_target_5xx" {
  for_each = {for i in var.LB_service_name : i.component_name => i }
  name     = "spni-${var.environment}-lb-target-5xx-${each.value.component_name}"
  priority = each.value.priority
  type     = "metric alert"
  evaluation_delay = 900
  query    = each.value.query == "" ? "sum(${each.value.query_time_window}):sum:aws.applicationelb.httpcode_target_5xx{component_name:${each.value.component_name} AND (env:${var.environment}* OR environment:${var.environment}*)} by {loadbalancer}.as_count() / sum:aws.applicationelb.request_count{component_name:${each.value.component_name} AND (env:${var.environment}* OR environment:${var.environment}*)} by {loadbalancer}.as_count() * 100 > ${each.value.lb_target_5xx_metric_critical}" : each.value.query
  message  =  <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Target 5XX errors of the Load Balancer {{loadbalancer.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"Lb target 5xx of the loadbalancer {{loadbalancer.name}} is {{value}} for last 5minutes ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Target 5XX errors of the Load Balancer {{loadbalancer.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
   tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:alb",
    "component_name:${each.value.component_name}",
    "component_type:alb",
    "roster:${each.value.roster}"
  ]
  notify_no_data = false
  no_data_timeframe = 10
  include_tags = true
    monitor_thresholds {
      critical = each.value.lb_target_5xx_metric_critical
      }
}
/*resource "datadog_monitor" "spni_lb_target_4xx" {
  for_each = {for i in var.LB_service_name : i.component_name => i }
  name     = "spni-${var.environment}-lb-target-4xx-${each.value.component_name}"
  priority = each.value.priority
  type     = "metric alert"
  evaluation_delay = 900
  query    = each.value.query == "" ? "sum(${each.value.query_time_window}):sum:aws.applicationelb.httpcode_target_4xx{component_name:${each.value.component_name} AND (env:${var.environment}* OR environment:${var.environment}*)} by {loadbalancer}.as_count() / sum:aws.applicationelb.request_count{component_name:${each.value.component_name} AND (env:${var.environment}* OR environment:${var.environment}*)} by {loadbalancer}.as_count() * 100 > ${each.value.lb_target_4xx_metric_critical}" : each.value.query
  message  =  <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Target 4XX errors of the Load Balancer {{loadbalancer.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"Lb target 4xx of the loadbalancer {{loadbalancer.name}} is {{value}} for last 5minutes ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Target 4XX errors of the Load Balancer {{loadbalancer.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
   tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:alb",
    "component_name:${each.value.component_name}",
    "component_type:alb",
    "roster:${each.value.roster}"
  ]
  notify_no_data = false
  no_data_timeframe = 10
  include_tags = true
    monitor_thresholds {
      critical = each.value.lb_target_4xx_metric_critical
      }
}
*/
resource "datadog_monitor" "spni_lb_healthy_hosts_count" {
  for_each = {for i in var.LB_service_name : i.component_name => i }
  name     = "spni-${var.environment}-lb-healthy-hosts-count-${each.value.component_name}"
  priority = each.value.priority
  type     = "metric alert"
  evaluation_delay = 900
  query    = "max(${each.value.query_time_window}):(default_zero(avg:aws.applicationelb.healthy_host_count{environment:prod, service_name:${each.value.service_name}, component_name:${each.value.component_name}}) / (default_zero(avg:aws.applicationelb.healthy_host_count{environment:prod, service_name:${each.value.service_name}, component_name:${each.value.component_name}}) + default_zero(avg:aws.applicationelb.un_healthy_host_count{environment:prod, service_name:${each.value.service_name}, component_name:${each.value.component_name}}))) * 100 < ${each.value.lb_healthy_hosts_count_critical}"
  message  =  <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — healthy hosts count for LB Target Group {{targetgroup.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  #"Lb unhealthy hosts count of the loadbalancer {{targetgroup.name}} is {{value}} for last 5minutes ${each.value.notification_channel}"
  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — healthy hosts count for Target Group {{targetgroup.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:alb",
    "component_name:${each.value.component_name}",
    "component_type:alb",
    "roster:${each.value.roster}"
  ]
  notify_no_data = false
  no_data_timeframe = 10
  include_tags = true
    monitor_thresholds {
      critical = each.value.lb_healthy_hosts_count_critical
      #warning = each.value.lb_healthy_hosts_count_critical * 0.8
      }
}