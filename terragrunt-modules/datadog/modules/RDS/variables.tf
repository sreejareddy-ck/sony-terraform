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


variable "rds_service_name" {
  description = ""
  type = list(object({
    service_name         = string
    component_name       = string
    priority            = number
    message              = string
    runbook              = string
    query_time_window    = string
    rds_cpu_metric_critical = string
    rds_dbconnections_metric_critical = string
    rds_freeable_memory_metrics_critical = string
    rds_free_storage_threshold           = string
    notification_channel              = string
    rds_cpu_query = string
    rds_memory_query = string
    rds_dbconnections_query = string
    roster = string
  }))
}