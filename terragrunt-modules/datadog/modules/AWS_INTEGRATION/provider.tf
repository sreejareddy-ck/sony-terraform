
terraform {
    required_version = ">= 1.5.7"
    required_providers {
        datadog = {
        source = "Datadog/datadog"
        version = ">= 3.0.0"
        }
        aws = {
        source  = "hashicorp/aws"
        version = "=5.57.0"

        }
    }
}



# provider "aws" {
#   region = var.region
#   profile = "767397670444_Sonyliv-SRE-RW"
# }

provider "aws" {
  region = var.region
  assume_role {
    role_arn     = "arn:aws:iam::${var.account}:role/tf_assume_role"
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}


