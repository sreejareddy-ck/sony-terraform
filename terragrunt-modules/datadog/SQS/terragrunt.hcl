terraform {
    source = "../modules/SQS"
}
# include {
#     path = find_in_parent_folders()
# }
locals {
    account = get_env("ACCOUNT_ID")
    datadog_module = get_env("DATADOG_MODULE")
}
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket = "spn-terraform-tfstate"
    key = "${path_relative_to_include()}/${local.account}/${local.datadog_module}/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
   } 
}

inputs ={
# region = "ap-south-1"
datadog_site = "datadoghq.com"
sqs_service_name = [
                        { 
                        "service_name" : "gv2",
                        "component_name" : "evergent-data-queue-job-trigger", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "sqs_no_messages_visible_metric_critical" : "20",
                        "sqs_age_of_oldest_message_metric_critical": "15",
                        "roster" : "@slack-godavari-beacon-api-tech-alerts",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
                        "query" : ""
                        },
                        { 
                        "service_name" : "gv2",
                        "component_name" : "evergent-registration-queue", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "15",
                        "roster" : "@slack-godavari-beacon-api-tech-alerts",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
                        "query" : ""
                        },
                        { 
                        "service_name" : "gv2",
                        "component_name" : "evergent-subscription-queue", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "sqs_no_messages_visible_metric_critical" : "500",
                        "sqs_age_of_oldest_message_metric_critical": "15",
                        "roster" : "@slack-godavari-beacon-api-tech-alerts",
                        "notification_channel" :"@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
                        "query" : ""
                        },
                        { 
                        "service_name" : "gv2",
                        "component_name" : "evergent-transaction-queue", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "sqs_no_messages_visible_metric_critical" : "200",
                        "sqs_age_of_oldest_message_metric_critical": "15",
                        "roster" : "@slack-godavari-beacon-api-tech-alerts",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
                        "query" : ""
                        },                    
                        { 
                        "service_name" : "gv2",
                        "component_name" : "schema-registry-lambda", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "sqs_no_messages_visible_metric_critical" : "20",
                        "sqs_age_of_oldest_message_metric_critical": "15",
                        "roster" : "@slack-godavari-beacon-api-tech-alerts",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
                        "query" : ""
                        },                 
                        { 
                        "service_name" : "gv2",
                        "component_name" : "job-trigger-lambda", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "sqs_no_messages_visible_metric_critical" : "20",
                        "sqs_age_of_oldest_message_metric_critical": "15",
                        "roster" : "@slack-godavari-beacon-api-tech-alerts",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },                     
                        { 
                        "service_name" : "gv2",
                        "component_name" : "evergent-rai-queue", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "15",
                        "roster" : "@slack-godavari-beacon-api-tech-alerts",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
                        "query" : ""
                        },                     
                        { 
                        "service_name" : "gv2",
                        "component_name" : "evergent-rai-dlq",
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "sqs_no_messages_visible_metric_critical" : "0",
                        "sqs_age_of_oldest_message_metric_critical": "15",
                        "roster" : "@slack-godavari-beacon-api-tech-alerts",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
                        "query" : ""
                        },                     
                        { 
                        "service_name" : "gv2",
                        "component_name" : "evergent-rt-registration-dlq", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "sqs_no_messages_visible_metric_critical" : "0",
                        "sqs_age_of_oldest_message_metric_critical": "15",
                        "roster" : "@slack-godavari-beacon-api-tech-alerts",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
                        "query" : ""
                        },                     
                        { 
                        "service_name" : "gv2",
                        "component_name" : "evergent-rt-subscription-dlq",
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "sqs_no_messages_visible_metric_critical" : "0",
                        "sqs_age_of_oldest_message_metric_critical": "15",
                        "roster" : "@slack-godavari-beacon-api-tech-alerts",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
                        "query" : ""
                        },                     
                        { 
                        "service_name" : "gv2",
                        "component_name" : "evergent-rt-transaction-dlq",
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "sqs_no_messages_visible_metric_critical" : "0",
                        "sqs_age_of_oldest_message_metric_critical": "15",
                        "roster" : "@slack-godavari-beacon-api-tech-alerts",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
                        "query" : ""
                        }, 
                         { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-avs-contentid-update-dlq", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },                 
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-dead-letter-queue", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },  
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-es1-notification", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },                     
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-es1-notification-dlq",
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts", 
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-expiration-dlq", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },                     
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-expiration-event-bridge-dlq", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },                     
                        {
                        "service_name" : "blitz",
                        "component_name" : "blitz-generatecreative-dlq",
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts", 
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },                     
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-inbound", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-inbound-sqs-dlq", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-ingestion-notification-dlq", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-publish-depublish-dlq", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-publish-json-dlq", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-right-expired-notification-service-lambda-dlq", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-right-expired-notification-service-lambda-event-bridge-dlq", 
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-s3toescontentupdate-dlq", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-scheduler", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                         { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-scheduler-dlq", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                       { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-sqs", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-webhook-blitz-sf-cancel-job-dlq", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-webhook-cuepoint-notification-dlq", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-webhook-preview-notification-dlq", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-webhook-transcoding-notification-dlq", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-webhook-validation-notification", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "blitz",
                        "component_name" : "blitz-auth-services-dlq", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-blitz-prod-alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "b2b",
                        "component_name" : "b2b-granular-config-sqs-prod", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-spni_prod_b2b_alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "b2b",
                        "component_name" : "b2b-push-notification-es-fifo", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-spni_prod_b2b_alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "60"
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "godavari",
                        "component_name" : "godavari-processing-queue", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-godavari_sqs_alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "30"
                        "notification_channel" : "@slack-godavari_sqs_alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                         { 
                        "service_name" : "godavari",
                        "component_name" : "godavari-processing-error-queue", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-godavari_sqs_alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "30"
                        "notification_channel" : "@slack-godavari_sqs_alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                         { 
                        "service_name" : "godavari",
                        "component_name" : "godavari-processing-error-s3-queue", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-godavari_sqs_alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "30"
                        "notification_channel" : "@slack-godavari_sqs_alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                         { 
                        "service_name" : "godavari",
                        "component_name" : "godavari-processing-short-error-queue", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-godavari_sqs_alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "30"
                        "notification_channel" : "@slack-godavari_sqs_alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                         { 
                        "service_name" : "godavari",
                        "component_name" : "godavari-processing-short-error-s3-queue", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-godavari_sqs_alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "30"
                        "notification_channel" : "@slack-godavari_sqs_alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "godavari",
                        "component_name" : "godavari-processing-short-error-val", 
                        "priority" : 1,
                        "message" : "SQS Alert triggered",
                        "runbook" : "",
                        "query_time_window" = {
                          no_messages_visible_monitor = "last_5m"
                          oldestmessage_monitor       = "last_5m"
                        },
                        "roster" :  "@slack-godavari_sqs_alerts",
                        "sqs_no_messages_visible_metric_critical" : "100",
                        "sqs_age_of_oldest_message_metric_critical": "30"
                        "notification_channel" : "@slack-godavari_sqs_alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        }
                        ]
                }