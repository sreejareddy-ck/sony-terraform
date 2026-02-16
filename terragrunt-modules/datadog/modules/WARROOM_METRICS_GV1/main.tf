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


resource "datadog_monitor" "spni_war_room_alert" {
  for_each           = { for i,cfg in var.spni_war_room_alert : i => cfg }
  name               = "spni-${var.environment}-gv1-war_room_metrics-${each.value.metric_name}-${each.value.metric_keyword}"
  type               = "query alert"
  priority           =  each.value.priority
  evaluation_delay  =   each.value.evaluation_delay
  notify_no_data  =     each.value.notify_nodata
  notify_audit       =  false
  message            = <<EOM
${each.value.message}  threshold is breached for platform: {{platform.name}}

Value is {{value}} at {{local_time 'last_triggered_at' 'Asia/Kolkata'}} 

Notification: ${each.value.notification_channel}
EOM
  escalation_message = <<EOM
${each.value.message}  threshold is breached for platform: {{platform.name}}

Value is {{value}} at {{local_time 'last_triggered_at' 'Asia/Kolkata'}}

Notification: ${each.value.notification_channel}
EOM
  query =  each.value.query == "" ? "sum(${each.value.query_time_window}):avg:${each.value.metric_name}{${each.value.metric_keyword}} by {${each.value.group_by}}.as_count() ${each.value.operator} ${each.value.monitor_thresholds}" : each.value.query
  monitor_thresholds {
    critical = each.value.monitor_thresholds
  }
/*  
  include_tags = true
  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:spm",
    "resource_type:application",
    "roster:${each.value.roster}"
  ]
*/   
}







