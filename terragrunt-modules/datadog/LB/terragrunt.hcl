terraform {
    source = "../modules/LB"
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
LB_service_name = [
                        {
                        "service_name" : "gv2", 
                        "component_name":  "gv2-beaconapi",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 10,
                        "lb_4xx_metric_critical"      = 10,
                        "lb_target_5xx_metric_critical"       = 10,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "roster" : "@slack-godavari-beacon-api-tech-alerts",
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",
                        "query" : ""
                        },
                        { 
                        "service_name" : "usm", 
                        "component_name":  "usm",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 10,
                        "lb_4xx_metric_critical"      = 10,
                        "lb_target_5xx_metric_critical"       = 10,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "roster" : "@slack-usm_tech_alerts",
                        "notification_channel" : "@slack-usm_tech_alerts  @webhook-DD-Squadcast-Integration",
                        "query" : ""
                        },
                        { 
                        "service_name" : "td", 
                        "component_name":  "td",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 10,
                        "lb_4xx_metric_critical"      = 10,
                        "lb_target_5xx_metric_critical"       = 10,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "roster"  : "@slack-targeted-delivery-api-alerts",
                        "notification_channel" : "@slack-targeted-delivery-api-alerts  @webhook-DD-Squadcast-Integration",
                        "query" : ""
                        },
                          { 
                        "service_name" : "tlb", 
                        "component_name":  "tlb"
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 10
                        "lb_4xx_metric_critical"      = 10
                        "lb_target_5xx_metric_critical"       = 10
                        "lb_healthy_hosts_count_critical"       = 50 
                        "roster"  : "@slack-tlb-alerts"
                        "notification_channel" : "@slack-tlb-alerts @webhook-DD-Squadcast-Integration"
                        "query" : ""
                        },
                        { 
                        "service_name" : "mweb", 
                        "component_name":  "mweb",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 10,
                        "lb_4xx_metric_critical"      = 10,
                        "lb_target_5xx_metric_critical"       = 10,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "roster"  : "@slack-spni_mweb_tech_alerts",
                        "notification_channel" : "@slack-spni_mweb_tech_alerts @webhook-DD-Squadcast-Integration",
                        "query" : ""
                        },
                        { 
                        "service_name" : "agl", 
                        "component_name":  "agl-core-cont-watch",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 5,
                        "lb_4xx_metric_critical"      = 10,
                        "lb_target_5xx_metric_critical"       = 5,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "notification_channel" : "@slack-agl-alerts @webhook-DD-Squadcast-Integration",
                        "roster"  : "@slack-agl-alerts", 
                        "query" : ""
                        },
                        { 
                        "service_name" : "agl", 
                        "component_name":  "agl-core-appconfig",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 5,
                        "lb_4xx_metric_critical"      = 10,
                        "lb_target_5xx_metric_critical"       = 5,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "notification_channel" : "@slack-agl-alerts @webhook-DD-Squadcast-Integration",
                        "roster"  : "@slack-agl-alerts",
                        "query" : ""
                        },
                        { 
                        "service_name" : "agl", 
                        "component_name":  "agl-core-default",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 5,
                        "lb_4xx_metric_critical"      = 10,
                        "lb_target_5xx_metric_critical"       = 5,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "notification_channel" : "@slack-agl-alerts @webhook-DD-Squadcast-Integration",
                        "roster"  : "@slack-agl-alerts",
                        "query" : ""
                        },
                        { 
                        "service_name" : "agl", 
                        "component_name":  "agl-core-listing",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 5,
                        "lb_4xx_metric_critical"      = 10,
                        "lb_target_5xx_metric_critical"       = 5,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "notification_channel" : "@slack-agl-alerts  @webhook-DD-Squadcast-Integration",
                        "roster"  :  "@slack-agl-alerts",
                        "query" : ""
                        },
                        { 
                        "service_name" : "agl", 
                        "component_name":  "agl-core-playback",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 5,
                        "lb_4xx_metric_critical"      = 10,
                        "lb_target_5xx_metric_critical"       = 5,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "notification_channel" : "@slack-agl-alerts @webhook-DD-Squadcast-Integration",
                        "roster"  : "@slack-agl-alerts",
                        "query" : ""
                        },
                        { 
                        "service_name" : "agl", 
                        "component_name":  "agl-core-umsps",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 5,
                        "lb_4xx_metric_critical"      = 10,
                        "lb_target_5xx_metric_critical"       = 5,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "notification_channel" : "@slack-agl-alerts @webhook-DD-Squadcast-Integration",
                        "roster"  : "@slack-agl-alerts",
                        "query" : ""
                        },
                        { 
                        "service_name" : "blitz", 
                        "component_name":  "blitz-core-services",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 1,
                        "lb_4xx_metric_critical"      = 20,  
                        "lb_target_5xx_metric_critical"       = 10,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "notification_channel" : "@slack-blitz-prod-alerts @webhook-DD-Squadcast-Integration",  
                        "roster"  : "@slack-blitz-prod-alerts",
                        "query" : ""
                        },
                        { 
                        "service_name" : "b2b", 
                        "component_name":  "b2b-common-prod",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 1,
                        "lb_4xx_metric_critical"      = 20,  
                        "lb_target_5xx_metric_critical"       = 10,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration",  
                        "roster"  : "@slack-spni_prod_b2b_alerts",
                        "query" : ""
                        },
                        { 
                        "service_name" : "b2b", 
                        "component_name":  "b2b-jio-prod",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 1,
                        "lb_4xx_metric_critical"      = 20,  
                        "lb_target_5xx_metric_critical"       = 10,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration",  
                        "roster"  : "@slack-spni_prod_b2b_alerts",
                        "query" : ""
                        },
                        { 
                        "service_name" : "b2b", 
                        "component_name":  "b2b-catalog-prod",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 1,
                        "lb_4xx_metric_critical"      = 20,  
                        "lb_target_5xx_metric_critical"       = 10,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration",  
                        "roster"  : "@slack-spni_prod_b2b_alerts",
                        "query" : ""
                        },
                        { 
                        "service_name" : "b2b", 
                        "component_name":  "b2b-subscription-prod",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 50,
                        "lb_4xx_metric_critical"      = 20,  
                        "lb_target_5xx_metric_critical"       = 15,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration",  
                        "roster"  : "@slack-spni_prod_b2b_alerts",
                        "query" : ""
                        },
                        { 
                        "service_name" : "b2b", 
                        "component_name":  "b2b-ingestion-prod",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 1,
                        "lb_4xx_metric_critical"      = 20,  
                        "lb_target_5xx_metric_critical"       = 10,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "notification_channel" : "@slack-spni_prod_b2b_alerts @webhook-DD-Squadcast-Integration",  
                        "roster"  : "@slack-spni_prod_b2b_alerts",
                        "query" : ""
                        },
                        { 
                        "service_name" : "es", 
                        "component_name":  "es",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 10,
                        "lb_4xx_metric_critical"      = 10,  
                        "lb_target_5xx_metric_critical"       = 10,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "notification_channel" : "@slack-spni_prod_es_alerts @webhook-DD-Squadcast-Integration",  
                        "roster"  : "@slack-spni_prod_es_alerts",
                        "query" : ""
                        },
                        { 
                        "service_name" : "web", 
                        "component_name":  "web",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 10,
                        "lb_4xx_metric_critical"      = 10,  
                        "lb_target_5xx_metric_critical"       = 10,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "notification_channel" : "@slack-spni_web_tech_alerts @webhook-DD-Squadcast-Integration",  
                        "roster"  : "@slack-spni_web_tech_alerts",
                        "query" : ""
                        },
                        { 
                        "service_name" : "alb-lcu-ui", 
                        "component_name":  "alb-lcu-ui",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 10,
                        "lb_4xx_metric_critical"      = 10,  
                        "lb_target_5xx_metric_critical"       = 10,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "notification_channel" : "@slack-spni_prod_scaler_alerts @webhook-DD-Squadcast-Integration",  
                        "roster"  : "@slack-spni_prod_scaler_alerts",
                        "query" : ""
                        },
                        { 
                        "service_name" : "scaler-ui", 
                        "component_name":  "scaler-ui",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 10,
                        "lb_4xx_metric_critical"      = 10,  
                        "lb_target_5xx_metric_critical"       = 10,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "notification_channel" : "@slack-spni_prod_scaler_alerts @webhook-DD-Squadcast-Integration",  
                        "roster"  : "@slack-spni_prod_scaler_alerts",
                        "query" : ""
                        },
                        { 
                        "service_name" : "sf-live", 
                        "component_name":  "sf-live",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 10,
                        "lb_4xx_metric_critical"      = 10,  
                        "lb_target_5xx_metric_critical"       = 10,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "notification_channel" : "@slack-spni_prod_sf_live_alerts @webhook-DD-Squadcast-Integration",  
                        "roster"  : "@slack-spni_prod_sf_live_alerts",
                        "query" : ""
                        },
                         { 
                        "service_name" : "godavari", 
                        "component_name":  "godavari-beaconapi",
                        "priority" : 1,
                        "message" : "LB Alert triggered",
                        "runbook" : "",
                        "query_time_window": "last_5m",
                        "lb_5xx_metric_critical"       = 10,
                        "lb_4xx_metric_critical"      = 10,  
                        "lb_target_5xx_metric_critical"       = 10,
                        "lb_healthy_hosts_count_critical"       = 50,
                        "notification_channel" : "@slack-godavari-beacon-api-tech-alerts @webhook-DD-Squadcast-Integration",  
                        "roster"  : "@slack-godavari-beacon-api-tech-alerts",
                        "query" : ""
                        }


]
}