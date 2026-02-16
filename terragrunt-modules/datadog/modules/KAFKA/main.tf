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

# Monitoring alert creation for Kafka under replicated partitions
resource "datadog_monitor" "spni_kafka_under_replicated_partitions" {
  for_each           = { for x in var.kafka_service_name : x.component_name => x }
  name               = "spni-${var.environment}-kafka-monitor-underReplicatedPartitions-${each.value.component_name}"
  type               = "metric alert"
  priority           = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900

  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Kafka under replicated partitions detected for cluster {{cluster_name}}. Current count: {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Kafka under replicated partitions detected for cluster {{cluster_name}}. Current count: {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  query = each.value.kafka_under_replicated_query == "" ? "avg(${each.value.query_time_window}):avg:aws.kafka.under_replicated_partitions{component_name:${each.value.component_name} AND environment:${var.environment}*} by {cluster_name} > ${each.value.kafka_under_replicated_critical}" : each.value.kafka_under_replicated_query

  monitor_thresholds {
    critical = each.value.kafka_under_replicated_critical
  }

  include_tags = true

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:kafka",
    "component_name:${each.value.component_name}",
    "component_type:kafka",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_kafka_offline_partitions" {
  for_each           = { for x in var.kafka_service_name : x.component_name => x }
  name               = "spni-${var.environment}-kafka-monitor-offlinePartitions-${each.value.component_name}"
  type               = "metric alert"
  priority           = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900

  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Kafka offline partitions detected for cluster {{cluster_name}}. Current count: {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Kafka offline partitions detected for cluster {{cluster_name}}. Current count: {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  query = each.value.kafka_offline_partitions_query == "" ? "avg(${each.value.query_time_window}):avg:aws.kafka.offline_partitions_count{component_name:${each.value.component_name} AND environment:${var.environment}*} by {cluster_name} > ${each.value.kafka_offline_partitions_critical}" : each.value.kafka_offline_partitions_query

  monitor_thresholds {
    critical = each.value.kafka_offline_partitions_critical
  }

  include_tags = true

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:kafka",
    "component_name:${each.value.component_name}",
    "component_type:kafka",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_kafka_active_controller_count" {
  for_each           = { for x in var.kafka_service_name : x.component_name => x }
  name               = "spni-${var.environment}-kafka-monitor-activeControllerCount-${each.value.component_name}"
  type               = "metric alert"
  priority           = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900

  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Kafka active controller count for cluster {{cluster_name}} is {{value}}. Expected: 1

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Kafka active controller count for cluster {{cluster_name}} is {{value}}. Expected: 1

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  query = each.value.kafka_controller_count_query == "" ? "avg(${each.value.query_time_window}):avg:aws.kafka.active_controller_count{component_name:${each.value.component_name},environment:${var.environment}*} by {cluster_name} != 1" : each.value.kafka_controller_count_query

  #monitor_thresholds {
   # critical = each.value.kafka_controller_count_critical
    #warning  = each.value.kafka_controller_count_warning
  #}

  include_tags = true

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:kafka",
    "component_name:${each.value.component_name}",
    "component_type:kafka",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_kafka_disk_used_monitor" {
  for_each           = { for x in var.kafka_service_name : x.component_name => x }
  name               = "spni-${var.environment}-kafka-monitor-diskUsed-${each.value.component_name}"
  type               = "metric alert"
  priority           = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900

  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Kafka disk usage for cluster {{cluster_name}} is at {{value}}%.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Kafka disk usage for cluster {{cluster_name}} is at {{value}}%.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  query = each.value.kafka_disk_used_query == "" ? "avg(${each.value.query_time_window}):avg:aws.kafka.kafka_data_logs_disk_used{component_name:${each.value.component_name} AND environment:${var.environment}*} by {cluster_name} > ${each.value.kafka_disk_used_critical}" : each.value.kafka_disk_used_query

  monitor_thresholds {
    critical = each.value.kafka_disk_used_critical
  }

  include_tags = true

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:kafka",
    "component_name:${each.value.component_name}",
    "component_type:kafka",
    "roster:${each.value.roster}"
  ]
}


resource "datadog_monitor" "spni_kafka_consumer_lag_monitor" {
  for_each           = { for x in var.kafka_service_name : x.component_name => x }
  name               = "spni-${var.environment}-kafka-monitor-consumerLag-${each.value.component_name}"
  type               = "metric alert"
  priority           = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900

  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Kafka consumer lag for topic/partition {{topic}} is at {{value}}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Kafka consumer lag for topic/partition {{topic}} is at {{value}}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  query = each.value.kafka_consumer_lag_query == "" ? "avg(${each.value.query_time_window}):avg:aws.kafka.offset_lag{component_name:${each.value.component_name} AND environment:${var.environment}*} by {topic} > ${each.value.kafka_consumer_lag_critical}" : each.value.kafka_consumer_lag_query

  monitor_thresholds {
    critical = each.value.kafka_consumer_lag_critical
  }

  include_tags = true

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:kafka",
    "component_name:${each.value.component_name}",
    "component_type:kafka",
    "roster:${each.value.roster}"
  ]
}

resource "datadog_monitor" "spni_kafka_idle_percent_monitor" {
  for_each           = { for x in var.kafka_service_name : x.component_name => x }
  name               = "spni-${var.environment}-kafka-monitor-idlePercent-${each.value.component_name}"
  type               = "metric alert"
  priority           = each.value.priority
  on_missing_data    = "show_no_data"
  notify_audit       =  false
  evaluation_delay = 900

  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Kafka request handler idle percent for cluster {{cluster_name}} is {{value}}%.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  escalation_message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Kafka request handler idle percent for cluster {{cluster_name}} is {{value}}%.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  query = each.value.kafka_idle_percent_query == "" ? "avg(${each.value.query_time_window}):avg:aws.kafka.request_handler_avg_idle_percent{component_name:${each.value.component_name} AND environment:${var.environment}*} by {cluster_name} < ${each.value.kafka_idle_percent_critical}" : each.value.kafka_idle_percent_query

  monitor_thresholds {
    critical = each.value.kafka_idle_percent_critical
  }

  include_tags = true

  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:kafka",
    "component_name:${each.value.component_name}",
    "component_type:kafka",
    "roster:${each.value.roster}"
  ]
}


