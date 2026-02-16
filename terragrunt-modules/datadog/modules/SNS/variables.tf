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


variable "sns_monitors" {
  description = ""
  type = list(object({
    service_name        = string
    component_name      = string
    priority            = number
    message             = string
    query_time_window    = string
    sns_failure_rate_threshold_critical = number
    sns_failed_notification_count_threshold_critical = number
    sns_Number_of_Messages_Published_threshold_critical = number
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



variable "timeout_h" {
  description = "Default auto-resolving state (in hours)"
  default     = 0
}

variable "prefix_slug" {
  description = "Prefix string to prepend between brackets on every monitors names"
  default     = "SNS"
}

variable "notify_no_data" {
  description = "Will raise no data alert if set to true"
  default     = true
}
