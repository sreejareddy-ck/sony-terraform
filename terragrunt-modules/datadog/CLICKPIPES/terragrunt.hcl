terraform {
    source = "../modules/CLICKPIPES"
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
Clickpipes_service_name = [
        {
            "service_name": "otp-pipe-bkp",
            "component_name": "gv2",
            "priority": 1,
            "message": "Clickpipes Alert triggered",
            "runbook": "",
            "query_time_window": {
                "spni_clickpipes_error_total": "last_30m",
                "spni_clickpipes_latency": "last_30m",
                "spni_clickpipes_SentBytes": "last_30m"
            },
            "critical_total_error_threshold": "10",
            "critical_latency_threshold": "100",
            "critical_sentbytes_threshold": "0",
            "ingestion_operator" : "==",
            "roster": "@slack-godavari-beacon-api-tech-alerts",
            "notification_channel": "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
            "query": ""
        },
        {
            "service_name": "gam",
            "component_name": "gv2",
            "priority": 1,
            "message": "Clickpipes Alert triggered",
            "runbook": "",
            "query_time_window": {
                "spni_clickpipes_error_total": "last_10m",
                "spni_clickpipes_latency": "last_7m",
                "spni_clickpipes_SentBytes": "last_7m"
            },
            "critical_total_error_threshold": "10",
            "critical_latency_threshold": "100",
            "critical_sentbytes_threshold": "0",
            "ingestion_operator": "==",
            "roster": "@slack-godavari-beacon-api-tech-alerts",
            "notification_channel": "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
            "query": ""
        },
        {
            "service_name": "godavari-clickstream-ondemand-stream",
            "component_name": "gv2",
            "priority": 1,
            "message": "Clickpipes Alert triggered",
            "runbook": "",
            "query_time_window": {
                "spni_clickpipes_error_total": "last_5m",
                "spni_clickpipes_latency": "last_5m",
                "spni_clickpipes_SentBytes": "last_5m"
            },
            "critical_total_error_threshold": "50",
            "critical_latency_threshold": "3000",
            "critical_sentbytes_threshold": "0.001",
            "ingestion_operator": ">",
            "roster": "@slack-godavari-beacon-api-tech-alerts",
            "notification_channel": "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
            "query": ""
        },
        {
            "service_name": "godavari-clickstream-provision-stream",
            "component_name": "gv2",
            "priority": 1,
            "message": "Clickpipes Alert triggered",
            "runbook": "",
            "query_time_window": {
                "spni_clickpipes_error_total": "last_1m",
                "spni_clickpipes_latency": "last_1m",
                "spni_clickpipes_SentBytes": "last_1m"
            },
            "critical_total_error_threshold": "50",
            "critical_latency_threshold": "7000",
            "critical_sentbytes_threshold": "0",
            "ingestion_operator": "==",
            "roster": "@slack-godavari-beacon-api-tech-alerts",
            "notification_channel": "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
            "query": ""
        },
        {
            "service_name": "godavari-clickstream-provision-stream-1",
            "component_name": "gv2",
            "priority": 1,
            "message": "Clickpipes Alert triggered",
            "runbook": "",
            "query_time_window": {
                "spni_clickpipes_error_total": "last_15m",
                "spni_clickpipes_latency": "last_15m",
                "spni_clickpipes_SentBytes": "last_15m"
            },
            "critical_total_error_threshold": "50",
            "critical_latency_threshold": "7000",
            "critical_sentbytes_threshold": "0",
            "ingestion_operator": "==",
            "roster": "@slack-godavari-beacon-api-tech-alerts",
            "notification_channel": "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
            "query": ""
        },
        {
            "service_name": "godavari-clickstream-provision-stream-2",
            "component_name": "gv2",            
            "priority": 1,
            "message": "Clickpipes Alert triggered",
            "runbook": "",
            "query_time_window": {
                "spni_clickpipes_error_total": "last_1m",
                "spni_clickpipes_latency": "last_1m",
                "spni_clickpipes_SentBytes": "last_1m"
            },
            "critical_total_error_threshold": "50",
            "critical_latency_threshold": "7000",
            "critical_sentbytes_threshold": "0",
            "ingestion_operator": "==",
            "roster": "@slack-godavari-beacon-api-tech-alerts",
            "notification_channel": "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
            "query": ""
        },
        {
            "service_name": "sms-pipe-2",
            "component_name": "gv2",
            "priority": 1,
            "message": "Clickpipes Alert triggered",
            "runbook": "",
            "query_time_window": {
                "spni_clickpipes_error_total": "last_30m",
                "spni_clickpipes_latency": "last_30m",
                "spni_clickpipes_SentBytes": "last_30m"
            },
            "critical_total_error_threshold": "10",
            "critical_latency_threshold": "100",
            "critical_sentbytes_threshold": "0",
            "ingestion_operator": "==",
            "roster": "@slack-godavari-beacon-api-tech-alerts",
            "notification_channel": "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
            "query": ""
        },
         {
            "service_name": "godavari-beacondata-prod-s3-clickpipe",
            "component_name": "godavari",
            "priority": 1,
            "message": "Clickpipes Alert triggered",
            "runbook": "",
            "query_time_window": {
                "spni_clickpipes_error_total": "last_2m",
                "spni_clickpipes_latency": "last_2m",
                "spni_clickpipes_SentBytes": "last_30m"
            },
            "critical_total_error_threshold": "10",
            "critical_latency_threshold": "80000",
            "critical_sentbytes_threshold": "0",
            "ingestion_operator": "==",
            "roster": "@slack-godavari_clickpipe_alerts",
            "notification_channel": "@slack-godavari_clickpipe_alerts @webhook-DD-Squadcast-Integration",
            "query": ""
        }
    ]
    }