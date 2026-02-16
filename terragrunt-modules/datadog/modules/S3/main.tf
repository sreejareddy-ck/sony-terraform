terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

provider "datadog" {
  api_key = "${var.datadog_api_key}"
  app_key = "${var.datadog_app_key}"
}


# Resource block for S3_5XX_Errors
resource "datadog_monitor" "aws_s3_high_5xx_errors" {
  
  for_each           = { for x in var.s3_service_name : x.component_name => x }
  name               =  "spni-${var.environment}-s3-high-5xx-${each.value.component_name}"
  type               =  "query alert"
  priority           =  each.value.priority
  query              =  each.value.s3_5xx_query == "" ? "sum(${each.value.query_time_window}):(sum:aws.s3.all_requests{component_name:${each.value.component_name} AND environment:${var.environment}*} by {aws_account,region,bucketname}.as_count() - sum:aws.s3.5xx_errors{component_name:${each.value.component_name} AND environment:${var.environment}*} by {aws_account,region,bucketname}.as_count()) / sum:aws.s3.all_requests{component_name:${each.value.component_name} AND environment:${var.environment}*} by {aws_account,region,bucketname}.as_count() < ${each.value.s3_5xx_critical_threshold}" : each.value.s3_5xx_query
   message         =  <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — More than 5% of S3 requests have resulted in 5xx errors for bucket {{bucketname.name}} in Region {{region.name}} in AWS Account {{aws_account.name}} during the selected time range.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

    evaluation_delay    = 900
    new_group_delay     = 60
    on_missing_data    = "show_no_data"
    require_full_window = false
    monitor_thresholds {
    critical = each.value.s3_5xx_critical_threshold
  }
     include_tags    = true

     tags = [
      "env:${var.environment}",
      "service:${each.value.service_name}",
      "metric-type:operator",
      "resource_type:s3",
      "component_name:${each.value.component_name}",
      "component_type:s3",
      "roster:${each.value.roster}"
  ]
}

#Resource creation for unusal highness in s3 bucket size
resource "datadog_monitor" "AWS_Unusual_Increase_in_S3_Bucket_size_of_bucketnamename_in_acco" {
  
  for_each           = { for x in var.s3_service_name : x.component_name => x }
  name               =  "spni-${var.environment}-s3-unusal-increase-bucket-size-${each.value.component_name}"
  type               =  "query alert"
  priority           =  each.value.priority
  query              = each.value.s3_bucket_increase_query == "" ? "avg(last_1w):anomalies(avg:aws.s3.bucket_size_bytes{component_name:${each.value.component_name} AND environment:${var.environment}*} by {bucketname,account}.as_count(), 'agile', 5, direction='above', interval=3600, alert_window='last_1d', count_default_zero='true', seasonality='daily', timezone='utc') >= ${each.value.s3_unusal_increase_bucket_size}" : each.value.s3_bucket_increase_query
  message = <<EOM
${each.value.message} for component: ${each.value.component_name} of service: ${each.value.service_name} — Unusual increase detected in the size of S3 bucket {{bucketname.name}} in AWS Account {{aws_account.name}}.

Operator Runbook: ${each.value.runbook}

Notification: ${each.value.notification_channel}
EOM

  evaluation_delay = 900
  new_group_delay = 60
  on_missing_data    = "show_no_data"
  require_full_window = false
  monitor_thresholds {
    critical = each.value.s3_unusal_increase_bucket_size
    critical_recovery = 0
  }
  monitor_threshold_windows {
    recovery_window = "last_15m"
    trigger_window = "last_1d"
  }
  include_tags    = true

     tags = [
      "env:${var.environment}",
      "service:${each.value.service_name}",
      "metric-type:operator",
      "resource_type:s3",
      "component_name:${each.value.component_name}",
      "component_type:s3",
      "roster:${each.value.roster}"
  ]
}
