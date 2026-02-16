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


variable "mongodb_service_name" {
  description = ""
  type = list(object({  
      service_name                  = string
      component_name                = string
      clustername                   = string
      priority                      = number
      query_time_window             = string
      message                       = string
      runbook                       = string
      notification_channel          = string
      mongodb_connections_critical  = string
      mongodb_disk_read_latency_critical    = string
      mongodb_disk_write_latency_critical   = string
      mongodb_replication_lag_critical      = string
      mongodb_memory_used_critical          = string
      mongodb_cpu_user_critical             = string
      mongodb_disk_iops_reads_critical      =  string
      mongodb_disk_iops_writes_critical     = string 
      mongodb_connections_query     = string 
      mongodb_memory_used_query     = string
      mongodb_cpu_user_query        = string
      roster                        = string
    }))
}