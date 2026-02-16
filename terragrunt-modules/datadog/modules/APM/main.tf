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


resource "datadog_monitor" "spni_apm_latency" {
  for_each           = { for x in var.APM_service_name : x.service_name => x }
  name               = "spni-${var.environment}-apm-monitor-latency-${each.value.service_name}"
  type               = "metric alert"
  priority           =  each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  message            = <<EOM
${each.value.message} for service: ${each.value.service_name} has high APM latency.

Latency is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  escalation_message = <<EOM
${each.value.message} for service: ${each.value.service_name} has high APM latency.

Latency is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  query =  each.value.latency_query == "" ? "avg(${each.value.query_time_window}):p95:trace.${each.value.apm_latency_type}.request{env:${var.environment}*,service:${each.value.service_name}} > ${each.value.apm_latency_metric}" : each.value.query
  monitor_thresholds {
    critical = each.value.apm_latency_metric 
  }
  include_tags = true
  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:spm",
    "resource_type:application",
    "roster:${each.value.roster}"
  ] 
}

resource "datadog_monitor" "spni_apm_error_rate" {
  for_each           = { for x in var.APM_service_name : x.service_name => x }
  name               = "spni-${var.environment}-apm-monitor-error-rate-${each.value.service_name}"
  type               = "metric alert"
  priority           = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  message            = <<EOM
${each.value.message} for service: ${each.value.service_name} has high APM error rate

Error rate for APM Service {{service.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  escalation_message = <<EOM
${each.value.message} for service: ${each.value.service_name} has high APM error rate

Error rate for APM Service {{service.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  query = each.value.error_query == "" ? "sum(${each.value.query_time_window}):(sum:trace.${each.value.apm_error_rate_type}.errors{env:${var.environment},service:${each.value.service_name}}.as_count() / sum:trace.${each.value.apm_error_rate_type}.hits{env:${var.environment},service:${each.value.service_name}}.as_count()) * 100 > ${each.value.apm_error_rate_metric}" : each.value.query


  monitor_thresholds {
    critical = each.value.apm_error_rate_metric
  }
  include_tags = true
   tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:spm",
    "resource_type:application",
    "roster:${each.value.roster}"
  ] 
}

#apm_apdex
/*
resource "datadog_monitor" "spni_apm_apdex" {
  for_each           = { for x in var.APM_service_name : x.service_name => x }
  name               = "spni-${var.environment}-apm-monitor-apdex-${each.value.service_name}"
  type               = "metric alert"
  priority           = each.value.priority
  no_data_timeframe  = 10
  notify_no_data     = true
  message            = <<EOM
${each.value.message} for service: ${each.value.service_name} has low APM Apdex score.

Apdex for APM Service {{service.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  escalation_message = <<EOM
${each.value.message} for service: ${each.value.service_name} has low APM Apdex score.

Apdex for APM Service {{service.name}} is {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  query = "avg(${each.value.query_time_window}):avg:trace.${each.value.apm_apdex_type}.request.apdex{env:${var.environment}*,service:${each.value.service_name}} < ${each.value.apm_apdex_metric}"
  monitor_thresholds {
    critical = each.value.apm_apdex_metric
  }
  include_tags = true
  tags = [
    "environment:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:spm",
    "resource_type:application",
    "roster:${each.value.roster}"
  ] 
}
*/








