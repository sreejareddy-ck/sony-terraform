variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = ""
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "account" {
  description = "AWS Account ID"
  type        = string
  default     = "767397670444"
}

variable "datadog_api_key" {
  description = "Datadog API Key"
  type        = string
  default     = ""
}

variable "datadog_app_key" {
  description = "Datadog APP Key"
  type        = string
  default     = ""
}

variable "ec2_service_name" {
  description = "List of EC2 services and thresholds"
  type = list(object({
    service_name             = string
    component_name           = string
    priority                 = number
    query_time_window         = string
    message                   = string
    cpu_threshold_critical   = number
    memory_threshold_critical = number
    disk_threshold_critical   = number
    runbook                  = string
    notification_channel     = string
    roster                   = string
    query                    = string
  }))
}

