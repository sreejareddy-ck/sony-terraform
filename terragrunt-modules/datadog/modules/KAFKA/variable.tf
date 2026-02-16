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


variable "kafka_service_name" {
  description = ""
  type = list(object({  
      service_name                  = string
      component_name                = string
      priority                      = number
      query_time_window             = string
      message                       = string
      runbook                       = string
      notification_channel          = string
      kafka_under_replicated_critical  = string
      kafka_under_replicated_query    = string
      kafka_offline_partitions_critical   = string
      kafka_offline_partitions_query      = string
      kafka_controller_count_query          = string
      kafka_disk_used_query           = string 
      kafka_disk_used_critical       = string
      kafka_consumer_lag_query         = string
      kafka_consumer_lag_critical    = string
      kafka_idle_percent_query       = string
      kafka_idle_percent_critical    = string
      roster                        = string
    }))
}