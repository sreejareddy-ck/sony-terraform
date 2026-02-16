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


variable "spni_war_room_alert" {
  description = ""
  type = list(object({
    metric_name         = string
    metric_keyword      = string
    monitor_thresholds  = string
    group_by            = string
    priority            = number
    evaluation_delay    = number
    notify_nodata       = bool
    message              = string
    query_time_window    = string
    operator             = string
    notification_channel = string
    query               = string
  }))
}

