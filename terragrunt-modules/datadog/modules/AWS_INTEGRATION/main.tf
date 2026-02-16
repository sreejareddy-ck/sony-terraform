resource "aws_cloudformation_stack" "datadog" {
  name          = "datadog-${var.region}-${var.account}"
  template_body = file("datadog.yaml")

  parameters = {
    APIKey = var.datadog_api_key
    APPKey = var.datadog_app_key
    DatadogSite = var.datadog_site
    DisableMetricCollection = "false"
    CloudSecurityPostureManagement = "false"
  }
  disable_rollback = true
  capabilities = ["CAPABILITY_NAMED_IAM"]
}


# resource "aws_cloudformation_stack" "datadogstream" {
#   name          = "datadogstream-${var.region}-${var.account}"
#   template_body = file("datadogstream.yaml")
#   parameters = {
#     ApiKey = var.datadog_api_key
#     DdSite = var.datadog_site
#     Regions = var.region
#   }
#   disable_rollback = false
#   capabilities = ["CAPABILITY_NAMED_IAM"]

# }

