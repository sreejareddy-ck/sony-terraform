terraform {
  required_providers {
    datadog = {
      source  = "DataDog/datadog"
      version =  "~> 3.36"
    }
  }
}

provider "datadog" {
  api_key = var.api_key
  app_key = var.app_key
}

variable "api_key" {
  type        = string
  description = "Datadog API Key"

}
variable "app_key" {
  type        = string
  description = "Datadog App Key"
}
