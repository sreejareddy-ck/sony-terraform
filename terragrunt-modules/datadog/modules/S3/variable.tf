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


variable "s3_service_name" {
  description = ""
  type = list(object({  
      service_name                  = string
      component_name                = string
      priority                      = number
      query_time_window             = string
      message                       = string
      runbook                       = string
      notification_channel          = string
      s3_5xx_critical_threshold     = string
      s3_unusal_increase_bucket_size = string
      s3_5xx_query                 = string
      s3_bucket_increase_query        = string
      roster                        = string
    }))
}