variable "environment" {
  type        = string
  description = "Environment for deployment."
  default     = ""
}

variable "region" {
    description = "AWS region to deploy resources"
    type        = string
    default     = "ap-south-1"
} 
variable "account" {
    description = "AWS account ID"
    type        = string
    default     = "767397670444"
}

variable "datadog_api_key" {
  default = "xxxxxxx"
}

variable "datadog_app_key" {
  default = "xxxxxxx"
}

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
  default     = "test-cluster"
}


variable "cluster_service_name" {
  description = ""
  type = list(object({
    service_name        = string
    component_name      = string
    priority            = number
    query_time_window    = string
    message              = string
    runbook              = string
    cluster_cpu_utilization_threshold_critical = string   #Critical threshold for the Cluster CPU Utilization monitor
    cluster_memory_reservation_threshold_critical = string #Critical threshold for the Cluster Memory Reservation monitor
    runbook = string
    notification_channel = string
    roster = string
    query = string
  }))
}

#
# Datadog global variables
#

variable "evaluation_delay" {
  description = "Delay in seconds for the metric evaluation"
  default     = 900
}

variable "new_group_delay" {
  description = "Delay in seconds before monitor new resource"
  default     = 300
}

variable "timeout_h" {
  description = "Default auto-resolving state (in hours)"
  default     = 0
}

variable "prefix_slug" {
  description = "Prefix string to prepend between brackets on every monitors names"
  default     = "ECS"
}

variable "notify_no_data" {
  description = "Will raise no data alert if set to true"
  default     = true
}



#
# Cluster CPU Utilization
#
# variable "cluster_cpu_utilization_time_aggregator" {
#   description = "Monitor aggregator for Cluster CPU Utilization [available values: min, max or avg]"
#   type        = string
#   default     = "min"
# }

# variable "cluster_cpu_utilization_timeframe" {
#   description = "Timeframe for the Cluster CPU Utilization monitor"
#   type        = string
#   default     = "last_5m"
# }

variable "cluster_cpu_utilization_threshold_critical" {
  description = "Critical threshold for the Cluster CPU Utilization monitor"
  type        = string
  default     = 90
}

#
# Cluster Memory Reservation
#
# variable "cluster_memory_reservation_time_aggregator" {
#   description = "Monitor aggregator for Cluster Memory Reservation [available values: min, max or avg]"
#   type        = string
#   default     = "min"
# }

# variable "cluster_memory_reservation_timeframe" {
#   description = "Timeframe for the Cluster Memory Reservation monitor"
#   type        = string
#   default     = "last_5m"
# }

variable "cluster_memory_reservation_threshold_critical" {
  description = "Critical threshold for the Cluster Memory Reservation monitor"
  type        = string
  default     = 90
}

variable "cluster_memory_reservation_threshold_warning" {
  description = "Warning threshold for the Cluster Memory Reservation monitor"
  type        = string
  default     = 85
}
