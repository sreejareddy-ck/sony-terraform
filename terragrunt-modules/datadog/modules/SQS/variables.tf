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


variable "sqs_service_name" {
  description = ""
  type = list(object({
    service_name         = string
    component_name        = string
    priority            = number
    message              = string
    runbook              = string
    query_time_window    = map(string)
    sqs_no_messages_visible_metric_critical       = string
    sqs_age_of_oldest_message_metric_critical    = string
    notification_channel              = string
    query = string
    roster = string
  }))
}