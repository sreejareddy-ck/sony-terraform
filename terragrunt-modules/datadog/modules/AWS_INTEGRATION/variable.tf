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

variable "environment" {
  type        = string
  description = "Environment for deployment."
  default     = ""
}

variable "datadog_api_key" {
    description = "Datadog API key"
    type        = string
    sensitive   = true
}

variable "datadog_app_key" {
    description = "Datadog APP key"
    type        = string
    sensitive   = true
}

variable "datadog_site"{
    description = "Datadog site"
    type        = string
    default     = "datadoghq.com"
}




