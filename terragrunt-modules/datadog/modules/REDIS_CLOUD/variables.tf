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


variable "redis_cloud_monitors" {
  description = ""
  type = list(object({
    service_name        = string
    component_name      = string
    priority            = number
    message             = string
    query_time_window    = string
    rdsc_bdb_avg_latency_threshold_critical = string
    rdsc_redis_used_memory_threshold_critical = string
    rdsc_bdb_shard_cpu_use_threshold_critical = string
    #rdsc_bdb_conns_threshold_critical = string
    rdsc_bdb_ingress_bytes_threshold_critical = string
    rdsc_bdb_egress_bytes_threshold_critical = string
    rdsc_node_ingress_bytes_max_threshold_critical = string
    rdsc_node_egress_bytes_max_threshold_critical = string
    rdsc_node_cpu_idle_threshold_critical = string
    rdsc_proxy_cpu_threshold_critical = string
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
  default     = "REDIS_CLOUD"
}

variable "notify_no_data" {
  description = "Will raise no data alert if set to true"
  default     = true
}



