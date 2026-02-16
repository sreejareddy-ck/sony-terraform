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

resource "datadog_monitor" "spni_container_cpu_usage_monitor" {
  for_each = { for x in var.container_service_name : x.service_name => x }
  name  = "spni-${var.environment}-container-monitor-cpu-usage-${each.value.service_name}"
  priority = each.value.priority
  type  = "metric alert"
  no_data_timeframe =   10
  notify_no_data =   true
  query = each.value.query == "" ? "avg(${each.value.query_time_window}):avg:container.cpu.usage{kube_namespace:* AND kube_cluster_name:* AND kube_deployment:${each.value.service_name}* AND environment:${var.environment} } / avg:container.cpu.limit{kube_namespace:* AND kube_cluster_name:* AND kube_deployment:${each.value.service_name}* AND environment:${var.environment}} * 100 > ${each.value.container_cpu_metric_critical}": each.value.query
  message            = <<EOM
${each.value.message} for service: ${each.value.service_name} — cpu utilisation is {{value}} kube deployment is  {{kube_deployment.name}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  escalation_message = <<EOM
${each.value.message} for service: ${each.value.service_name} — cpu utilisation is {{value}} kube deployment is  {{kube_deployment.name}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:${each.value.roster}"
  ] 
    monitor_thresholds {
      critical = each.value.container_cpu_metric_critical  // This means the alert will trigger when the condition is met for 1 consecutive evaluation
    }
}

resource "datadog_monitor" "spni_container_memory_usage_monitor" {
  for_each = { for x in var.container_service_name : x.service_name => x }
  name  = "spni-${var.environment}-container-monitor-memory-usage-${each.value.service_name}"
  priority = each.value.priority
  type  = "metric alert"
  no_data_timeframe =   10
  notify_no_data =   true
  query =  each.value.query == "" ? "min(${each.value.query_time_window}):avg:container.memory.usage{kube_namespace:* AND kube_cluster_name:* AND kube_deployment:${each.value.service_name}* AND environment:${var.environment}} / avg:container.memory.limit{kube_namespace:* AND kube_cluster_name:* AND kube_deployment:${each.value.service_name}* AND environment:${var.environment}} * 100 > ${each.value.container_memory_metric_critical}" : each.value.query
  message = <<EOM
${each.value.message} for service: ${each.value.service_name} — memory utilisation is {{value}} kube deployment is  {{kube_deployment.name}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  escalation_message = <<EOM
${each.value.message} for service: ${each.value.service_name} — memory utilisation is {{value}} kube deployment is  {{kube_deployment.name}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:${each.value.roster}"
  ] 
    monitor_thresholds {
      critical = each.value.container_memory_metric_critical  // This means the alert will trigger when the condition is met for 1 consecutive evaluation
    }
}

resource "datadog_monitor" "spni_container_restarts_monitor" {
  for_each = { for x in var.container_service_name : x.service_name => x }
  name  = "spni-${var.environment}-container-monitor-restarts-${each.value.service_name}"
  priority = each.value.priority
  type  = "metric alert"
  query = each.value.query == "" ? "sum(last_1h):avg:kubernetes.containers.restarts{cluster_name:* AND  kube_container_name:${each.value.service_name}* AND environment:${var.environment}} by {kube_container_name} > ${each.value.container_restart_metric_critical}" : each.value.query
  message            = <<EOM
${each.value.message} for service: ${each.value.service_name} — Restart for service {{kube_deployment.name}} with {{value}} pods restarting

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  escalation_message = <<EOM
${each.value.message} for service: ${each.value.service_name} — Restart for service {{kube_deployment.name}} with {{value}} pods restarting

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:${each.value.roster}"
  ] 
    monitor_thresholds {
      critical =  each.value.container_restart_metric_critical // This means the alert will trigger when the condition is met for 1 consecutive evaluation
    }
}

resource "datadog_monitor" "spni_container_crashloopbackoff_monitor" {
  for_each = { for x in var.container_service_name : x.service_name => x }
  name  = "spni-${var.environment}-container-monitor-crashloopbackoff-${each.value.service_name}"
  priority = each.value.priority
  type  = "metric alert"
  query = each.value.query == "" ? "avg(${each.value.query_time_window}):sum:kubernetes.containers.state.waiting{kube_namespace:* AND reason:crashloopbackoff AND kube_cluster_name:* AND kube_deployment:${each.value.service_name}* AND environment:${var.environment}} by {kube_deployment} > ${each.value.container_crashloopbackoff_metric_critical}": each.value.query
  message            = <<EOM
${each.value.message} for service: ${each.value.service_name} — Crash loop backoff for service {{kube_deployment.name}} with {{value}} pods crashing

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  escalation_message = <<EOM
${each.value.message} for service: ${each.value.service_name} — Crash loop backoff for service {{kube_deployment.name}} with {{value}} pods crashing

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:${each.value.roster}"
  ] 
    monitor_thresholds {
      critical =  each.value.container_crashloopbackoff_metric_critical
    }
}

resource "datadog_monitor" "spni_container_oom_monitor" {
  for_each = { for x in var.container_service_name : x.service_name => x }
  name  = "spni-${var.environment}-container-monitor-oom-${each.value.service_name}"
  priority = each.value.priority
  type  = "metric alert"
  query = each.value.query == "" ? "avg(${each.value.query_time_window}):sum:kubernetes.containers.state.terminated{kube_namespace:* AND reason:oomkilled AND kube_cluster_name:* AND kube_deployment:${each.value.service_name}* AND environment:${var.environment}} by {kube_deployment,kube_cluster_name} > ${each.value.container_oom_metric_critical}" : each.value.query
  message            = <<EOM
${each.value.message} for service: ${each.value.service_name} — Container experienced an Out Of Memory (OOM) kill. Value: {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  escalation_message = <<EOM
${each.value.message} for service: ${each.value.service_name} — Container experienced an Out Of Memory (OOM) kill. Value: {{value}}

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM
  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:${each.value.roster}"
  ]
    monitor_thresholds {
      critical =  each.value.container_oom_metric_critical // This means the alert will trigger when the condition is met for 1 consecutive evaluation
    }
}

resource "datadog_monitor" "spni_container_maxhpa_monitor" {
  for_each = { for x in var.container_service_name : x.service_name => x }
  name  = "spni-${var.environment}-container-monitor-maxhpa-${each.value.service_name}"
  type  = "metric alert"
  priority = each.value.priority
  query = each.value.query == "" ? "avg(${each.value.query_time_window}):max:kubernetes_state.hpa.current_replicas{kube_namespace:* AND horizontalpodautoscaler:${each.value.service_name}* AND env:${var.environment}} by {horizontalpodautoscaler} / max:kubernetes_state.hpa.max_replicas{kube_namespace:* AND horizontalpodautoscaler:${each.value.service_name}* AND env:${var.environment}} by {horizontalpodautoscaler} * 100 > ${each.value.container_maxhpa_metric_critical}" : each.value.query
  message            = <<EOM
EKS Alert triggered for HPA max replicas reached for service {{horizontalpodautoscaler.name}} with {{value}} pods crashing

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM
  escalation_message = <<EOM
EKS Alert triggered for HPA max replicas reached for service {{horizontalpodautoscaler.name}} with {{value}} pods crashing

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM
  tags = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:@slack-eks-cluster-infra-alerts"
  ] 
  monitor_thresholds {
    critical = each.value.container_maxhpa_metric_critical
  }
  notify_no_data = true
  no_data_timeframe = 10
}

resource "datadog_monitor" "spni_kube_node_status" {
    name = "spni-${var.environment}-kube-node-status"
    type = "metric alert"
    priority = 1
    query = "min(last_5m):sum:kubernetes_state.node.by_condition{status:false,condition:ready, cluster_name:eksprod*} by {kube_cluster_name} / sum:kubernetes_state.node.count{kube_cluster_name:eksprod*} by {kube_cluster_name} * 100 > 80"
    message = <<EOM
EKS Alert triggered for Kubernetes nodes issue detected in {{kube_cluster_name}} cluster with {{value}} nodes

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM
    escalation_message = <<EOM
EKS Alert triggered for Kubernetes nodes issue detected in {{kube_cluster_name}} cluster with {{value}} nodes

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM
    tags = [
    "env:${var.environment}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:@slack-eks-cluster-infra-alerts"
  ] 
    monitor_thresholds {
      critical =  80 // This means the alert will trigger when the condition is met for 1 consecutive evaluation
    }
}

resource "datadog_monitor" "spni_kube_service_capacity" {
  for_each = { for x in var.container_service_name : x.service_name => x }
  name     = "spni-${var.environment}-kube-service-capacity-${each.value.service_name}"
  type     = "metric alert"
  priority = each.value.priority
  query    = "avg(${each.value.query_time_window}):avg:kubernetes_state.deployment.replicas_ready{kube_cluster_name:eksprod*, kube_namespace:*, kube_deployment:${each.value.service_name}*} by {kube_deployment} / avg:kubernetes_state.deployment.replicas_desired{kube_cluster_name:eksprod*, kube_namespace:*, kube_deployment:${each.value.service_name}*} by {kube_deployment} * 100 < ${each.value.container_capacity_critical}"
  message  = <<EOM
EKS Alert triggered for Kubernetes Service capacity issue in deployment ${each.value.service_name} within {{kube_cluster_name}} cluster — {{value}}% ready replicas

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM
  escalation_message = <<EOM
EKS Alert triggered for Kubernetes Service capacity issue in deployment ${each.value.service_name} within {{kube_cluster_name}} cluster — {{value}}% ready replicas

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM
  tags     = [
    "env:${var.environment}",
    "service:${each.value.service_name}",
    "kube_cluster_name:{{kube_cluster_name}}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:@slack-eks-cluster-infra-alerts"
  ] 
  monitor_thresholds {
    critical = each.value.container_capacity_critical
  }
}

resource "datadog_monitor" "spni_kube_node_disk_pressure" {
    name = "spni-${var.environment}-kube-node-disk-pressure"
    type = "metric alert"
    priority = 2
    query = "min(last_5m):sum:kubernetes_state.node.by_condition{status:true,condition:diskpressure, cluster_name:eksprod*} by {kube_cluster_name} / sum:kubernetes_state.node.count{kube_cluster_name:eksprod*} by {kube_cluster_name} * 100 > 80"
    message = <<EOM
EKS Alert triggered for Kubernetes Disk Pressure issue detected in {{kube_cluster_name}} cluster with {{value}} nodes

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
    escalation_message = <<EOM
EKS Alert triggered for Kubernetes Disk Pressure issue detected in {{kube_cluster_name}} cluster with {{value}} nodes

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
    tags = [
    "env:${var.environment}",
    "kube_cluster_name:{{kube_cluster_name}}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:@slack-eks-cluster-infra-alerts"
  ] 
    monitor_thresholds {
      critical =  80 // This means the alert will trigger when the condition is met for 1 consecutive evaluation
    }
}

resource "datadog_monitor" "spni_kube_node_memory_pressure" {
    name = "spni-${var.environment}-kube-node-memory-pressure"
    type = "metric alert"
    priority = 2
    query = "min(last_5m):sum:kubernetes_state.node.by_condition{status:true,condition:memorypressure, cluster_name:eksprod*} by {kube_cluster_name} / sum:kubernetes_state.node.count{kube_cluster_name:eksprod*} by {kube_cluster_name} * 100 > 80"
    message = <<EOM
EKS Alert triggered for Kubernetes Memory Pressure issue detected in {{kube_cluster_name}} cluster with {{value}} nodes

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
    escalation_message = <<EOM
EKS Alert triggered for Kubernetes Memory Pressure issue detected in {{kube_cluster_name}} cluster with {{value}} nodes

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
    tags = [
    "env:${var.environment}",
    "kube_cluster_name:{{kube_cluster_name}}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:@slack-eks-cluster-infra-alerts"
  ] 
    monitor_thresholds {
      critical =  80 // This means the alert will trigger when the condition is met for 1 consecutive evaluation
    }
}
resource "datadog_monitor" "spni_kube_node_pid_pressure" {
    name = "spni-${var.environment}-kube-node-pid-pressure"
    type = "metric alert"
    priority = 2
    query = "min(last_5m):sum:kubernetes_state.node.by_condition{status:true,condition:pidpressure, cluster_name:eksprod*} by {kube_cluster_name} / sum:kubernetes_state.node.count{kube_cluster_name:eksprod*} by {kube_cluster_name} * 100 > 80"
    message = <<EOM
EKS Alert triggered for Kubernetes PID Pressure issue detected in {{kube_cluster_name}} cluster with {{value}} nodes

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
    escalation_message = <<EOM
EKS Alert triggered for Kubernetes PID Pressure issue detected in {{kube_cluster_name}} cluster with {{value}} nodes

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
    tags =[
    "env:${var.environment}",
    "kube_cluster_name:{{kube_cluster_name}}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:@slack-eks-cluster-infra-alerts"
  ] 
    monitor_thresholds {
      critical =  80 // This means the alert will trigger when the condition is met for 1 consecutive evaluation
    }
}

//EKS Api Control plane Monitoring
resource "datadog_monitor" "spni_eks_api_control_plane_error"{
  name     = "spni-${var.environment}-EKS-Api-Control-Plane-Error"
  priority = 2
  type     = "metric alert"
  query    = "avg(last_15m):anomalies(avg:aws.eks.apiserverrequesttotal_4xx{*} by {clustername}, 'basic', 2, direction='above', interval=60, alert_window='last_15m', count_default_zero='true') >= 1"
  message  =  <<EOM
EKS Alert triggered for EKS Api Control Plane 4xx Error is {{value}}

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
  escalation_message = <<EOM
EKS Alert triggered for EKS Api Control Plane 4xx Error is {{value}}

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
  tags     = [
    "env:${var.environment}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:@slack-eks-cluster-infra-alerts"
  ] 
  notify_no_data = false
  evaluation_delay = 900
  no_data_timeframe = 10
  include_tags = true
    monitor_thresholds {
      critical = 1
      }
  }

resource "datadog_monitor" "spni_eks_api_control_plane_5xx"{
  name     = "spni-${var.environment}-EKS-Api-Control-Plane-5xx"
  priority = 2
  type     = "metric alert"
  query    = "avg(last_5m):default_zero(avg:aws.eks.apiserverrequesttotal_5xx{region:ap-south-1}) / default_zero(avg:aws.eks.apiserverrequesttotal{region:ap-south-1}) * 100 > 10"
  message  =  <<EOM
EKS Alert triggered for EKS Api Control Plane 5xx Error is {{value}}

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
  escalation_message = <<EOM
EKS Alert triggered for EKS Api Control Plane 5xx Error is {{value}}

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
  tags     = [
    "env:${var.environment}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:@slack-eks-cluster-infra-alerts"
  ]
  notify_no_data = false
  no_data_timeframe = 10
  evaluation_delay = 900
  include_tags = true
    monitor_thresholds {
      critical = 10
      }
  }


resource "datadog_monitor" "spni_eks_api_control_plane_latency_put_p99" {
  name     = "spni-${var.environment}-EKS-Api-Control-Plane-Latency-Put-P99"
  priority = 2
  type     = "metric alert"
  query    = "avg(last_5m):default_zero(avg:aws.eks.apiserverrequestdurationseconds_putp_9_9{region:ap-south-1}) > 1000"
  message  =  <<EOM
EKS Alert triggered for EKS Api Control Plane Latency Put P99 is {{value}}

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
  escalation_message = <<EOM
EKS Alert triggered for EKS Api Control Plane Latency Put P99 is {{value}}

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
  tags     = [
    "env:${var.environment}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:@slack-eks-cluster-infra-alerts"
  ]
  notify_no_data = false
  no_data_timeframe = 10
  evaluation_delay = 900
  include_tags = true
    monitor_thresholds {
      critical = 1000
      }
}

resource "datadog_monitor" "spni_eks_api_control_plane_latency_post_p99" {
  name     = "spni-${var.environment}-EKS-Api-Control-Plane-Latency-Post-P99"
  priority = 2
  type     = "metric alert"
  query    = "avg(last_5m):default_zero(avg:aws.eks.apiserverrequestdurationseconds_postp_9_9{region:ap-south-1}) > 1000"
  message  =  <<EOM
EKS Alert triggered for EKS Api Control Plane Latency Post P99 is {{value}}

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
  escalation_message = <<EOM
EKS Alert triggered for EKS Api Control Plane Latency Post P99 is {{value}}

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
  tags     = [
    "env:${var.environment}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:@slack-eks-cluster-infra-alerts"
  ]
  notify_no_data = false
  no_data_timeframe = 10
  evaluation_delay = 900
  include_tags = true
    monitor_thresholds {
      critical = 1000
      }
}


resource "datadog_monitor" "spni_eks_api_control_plane_latency_get_p99" {
  name     = "spni-${var.environment}-EKS-Api-Control-Plane-Latency-Get-P99"
  priority = 2
  type     = "metric alert"
  query    = "avg(last_5m):default_zero(avg:aws.eks.apiserverrequestdurationseconds_getp_9_9{region:ap-south-1}) > 1000"
  message  =  <<EOM
EKS Alert triggered for EKS Api Control Plane Latency Get P99 is {{value}}

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
  escalation_message = <<EOM
EKS Alert triggered for EKS Api Control Plane Latency Get P99 is {{value}}

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
  tags     = [
    "env:${var.environment}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:@slack-eks-cluster-infra-alerts"
  ]
  notify_no_data = false
  no_data_timeframe = 10
  evaluation_delay = 900
  include_tags = true
    monitor_thresholds {
      critical = 1000
      }
}

resource "datadog_monitor" "spni_eks_api_control_plane_latency_delete_p99" {
  name     = "spni-${var.environment}-EKS-Api-Control-Plane-Latency-Delete-P99"
  priority = 2
  type     = "metric alert"
  query    = "avg(last_5m):default_zero(avg:aws.eks.apiserverrequestdurationseconds_listp_9_9{region:ap-south-1}) > 1000"
  message  =  <<EOM
EKS Alert triggered for EKS Api Control Plane Latency Delete P99 is {{value}}

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
  escalation_message = <<EOM
EKS Alert triggered for EKS Api Control Plane Latency Delete P99 is {{value}}

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
  tags     = [
    "env:${var.environment}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:@slack-eks-cluster-infra-alerts"
  ]
  notify_no_data = false
  no_data_timeframe = 10
  evaluation_delay = 900
  include_tags = true
    monitor_thresholds {
      critical = 1000
      }
}


resource "datadog_monitor" "spni_eks_api_control_plane_latency_list_p99" {
  name     = "spni-${var.environment}-EKS-Api-Control-Plane-Latency-List-P99"
  priority = 2
  type     = "metric alert"
  query    = "avg(last_5m):default_zero(avg:aws.eks.apiserverrequestdurationseconds_listp_9_9{region:ap-south-1}) > 1000"
  message  =  <<EOM
EKS Alert triggered for EKS Api Control Plane Latency List P99 is {{value}}

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
  escalation_message = <<EOM
EKS Alert triggered for EKS Api Control Plane Latency List P99 is {{value}}

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
  tags     = [
    "env:${var.environment}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:@slack-eks-cluster-infra-alerts"
  ]
  notify_no_data = false
  no_data_timeframe = 10
  evaluation_delay = 900
  include_tags = true
    monitor_thresholds {
      critical = 1000
      }
}



resource "datadog_monitor" "spni_node_CPU_usage" {
  name     = "spni-${var.environment}-eks-node-CPU-usage"
  priority = 2
  type     = "metric alert"
  query    = "avg(last_5m):100 - avg:system.cpu.idle{eks_cluster-name:eks-prod} by {eks_nodegroup-name} > 80"
  message  =  <<EOM
EKS Alert triggered for Node CPU usage of {{eks_nodegroup-name.name}} is {{value}}

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
  escalation_message = <<EOM
EKS Alert triggered for Node CPU usage of {{eks_nodegroup-name.name}} is {{value}}

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
  tags     = [
    "env:${var.environment}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:@slack-eks-cluster-infra-alerts"
  ]
  notify_no_data = false
  no_data_timeframe = 10
  include_tags = true
    monitor_thresholds {
      critical = 80
      }
}

resource "datadog_monitor" "spni_node_memory_usage" {
  name     = "spni-${var.environment}-eks-node-memory-usage"
  priority = 2
  type     = "metric alert"
  query    = "avg(last_5m):1 - avg:system.mem.pct_usable{eks_cluster-name:eks-prod} by {eks_nodegroup-name} > 80"
  message  =  <<EOM
EKS Alert triggered for Node Memory usage for {{eks_nodegroup-name.name}} is {{value}}

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
  escalation_message = <<EOM
EKS Alert triggered for Node Memory usage of {{eks_nodegroup-name.name}} is {{value}}

Operator Runbook: ""

Notification: "@slack-eks-cluster-infra-alerts @webhook-DD-Squadcast-Integration"
EOM 
  tags     = [
    "env:${var.environment}",
    "metric-type:operator",
    "resource_type:eks",
    "roster:@slack-eks-cluster-infra-alerts"
  ]
  notify_no_data = false
  no_data_timeframe = 10
  include_tags = true
    monitor_thresholds {
      critical = 80
      }
}

