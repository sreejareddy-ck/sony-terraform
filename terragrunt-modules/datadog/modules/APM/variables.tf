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


variable "APM_service_name" {
  description = ""
  type = list(object({
    service_name         = string
    apm_latency_type    = string
    priority            = number
    message              = string
    runbook              = string
    query_time_window    = string
    apm_latency_metric   = string
    apm_error_rate_type  = string
    apm_error_rate_metric = string
    #apm_apdex_type      = string
    #apm_apdex_metric     = string
    notification_channel = string
    latency_query        = string
    error_query          = string
    roster = string
  }))
}

