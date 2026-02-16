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


variable "container_service_name" {
  description = ""
  type = list(object({
    service_name         = string
    priority            = number
    query_time_window    = string
    message              = string
    runbook              = string
    roster               = string
    container_cpu_metric_critical       = string
    container_memory_metric_critical    = string
    container_restart_metric_critical   = string
    container_crashloopbackoff_metric_critical = string
    container_oom_metric_critical = string
    container_maxhpa_metric_critical = string
    container_capacity_critical = string
    notification_channel              = string
    query = string
  }))
}