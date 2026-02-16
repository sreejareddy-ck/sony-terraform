variable "datadog_api_key" {
  description = "Datadog API Key"
  type        = string
  sensitive   = true
}

variable "datadog_app_key" {
  description = "Datadog APP Key"
  type        = string
  sensitive   = true
}
variable "region" {
  description = "AWS region"
  type        = string
}

variable "account" {
  description = "AWS account ID"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}
 
variable "datadog_site" {
  description = "Datadog site (e.g., datadoghq.com)"
  type        = string
  default     = "datadoghq.com"
}

variable "opensearch_monitors" {
  description = "List of OpenSearch monitor configurations"
  type = list(object({
    service_name                  = string
    component_name                = string
    notification_channel           = string
    priority                    = number
    message                    = string
    query_time_window        = string
    roster                        = string
    runbook                       = string
    nodes_minimum_critical            = number
    cpuutilization_maximum_critical = number
    jvm_memory_pressure_maximum_critical = number
    cluster_statusred_maximum_critical  = number
    free_storage_space_minimum_critical    = number
    threadpool_search_rejected_critical = number
    threadpool_write_rejected_critical  = number
    iops_throttle_critical                        = number
    throughput_throttle_critical                  = number
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
  default     = "OpenSearch"
}

variable "notify_no_data" {
  description = "Will raise no data alert if set to true"
  type        = bool
  default     = true
}

