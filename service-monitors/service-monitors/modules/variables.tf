variable "service_name" {
  type        = string
  description = "Name of the service."
}

variable "component_name" {
  type        = string
  description = "Name of the component."
}

variable "roster" {
  type        = string
  description = "Squadcast roster for the team that manages this service."
}

variable "message" {
  type        = string
  description = "A message to include with notifications for this monitor."
}

variable "critical_threshold" {
  type        = number
  description = "The monitor CRITICAL threshold. Must be a number"
}

variable "critical_recovery" {
  type        = number
  description = "The monitor CRITICAL recovery threshold. Must be a number."
  default     = null
}

variable "warning_threshold" {
  type        = number
  description = "The monitor WARNING threshold. Must be a number"
  default     = null
}

variable "warning_recovery" {
  type        = number
  description = "The monitor WARNING recovery threshold. Must be a number."
  default     = null
}

variable "datadog_service_tag" {
  type        = string
  description = "Datadog service tag to view on APM."
}

variable "resource_type" {
  # Add a check for valid resource types
  type        = string
  description = "Resource type of component, refer https://sony-liv.atlassian.net/wiki/spaces/SS/pages/375750712/Service+Infra+Tagging+Conventions"

  validation {
    condition     = contains(["aurora", "elasticache", "ec2", "pod", "s3", "elb", "alb", "ebs", "sns", "sqs", "lambda", "asg", "tg", "step-function"], var.resource_type)
    error_message = "Invalid value for resource_type. Check this doc for details https://sony-liv.atlassian.net/wiki/spaces/SS/pages/375750712/Service+Infra+Tagging+Conventions"
  }
}

variable "slack_channel" {
  type        = string
  description = "Slack channel name in the format @slack-<channel-name> for sending alert messages."
}

variable "escalation_message" {
  type        = string
  description = "A message to include with a re-notification. Supports the @username notification allowed elsewhere."
  default     = "Monitor has not recovered yet."
}

variable "runbook" {
  type        = string
  description = "Link to Operator Runbook."
}

variable "squadcast_webhook" {
  type        = string
  description = "SquadCast Webhook."
  default     = "@webhook-Squadcast"
}
