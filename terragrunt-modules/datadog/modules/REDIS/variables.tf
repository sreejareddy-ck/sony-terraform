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
  description = "Datadog API key"
  type        = string
  default     = "xxxxxxx"
}

variable "datadog_app_key" {
  description = "Datadog APP key"
  type        = string
  default     = "xxxxxxx"
}

variable "redis_service_name" {
  description = "List of Redis monitor configurations"
  type = list(object({
    service_name                                 = string
    component_name                               = string
    priority                                     = number
    message                                      = string
    query_time_window                            = string
    redis_avg_cpu_utilization_critical           = number
    redis_avg_engine_cpu_utilization_critical    = number
    redis_avg_get_type_latency_critical          = number
    redis_avg_memory_utilization_critical        = number
    redis_avg_set_type_latency_critical          = number
    redis_connection_count_critical              = number
    redis_swap_usage_critical                    = number
    redis_cache_hit_ratio_critical               = number
    runbook                                      = string
    notification_channel                         = string
    roster                                       = string
  }))
}


variable "evaluation_delay" {
  description = "Delay in seconds for the metric evaluation"
  type        = number
  default     = 900
}

variable "timeout_h" {
  description = "Default auto-resolving state (in hours)"
  type        = number
  default     = 0
}

variable "prefix_slug" {
  description = "Prefix string to prepend between brackets on every monitor's name"
  type        = string
  default     = "REDIS"
}

variable "notify_no_data" {
  description = "Will raise no data alert if set to true"
  type        = bool
  default     = true
}

