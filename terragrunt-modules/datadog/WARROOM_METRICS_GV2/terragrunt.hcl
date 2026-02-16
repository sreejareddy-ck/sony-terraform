terraform {
    source = "../modules/WARROOM_METRICS_GV2"
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
spni_war_room_alert = [
              { 
                        "metric_name" : "gv2.user_login_efficiency",
                        "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                        "priority" : 1,
                        "message" : "Login Efficiency",
                        "query_time_window" : "last_5m",
                        "monitor_thresholds" : "-20",
                        "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                        "operator" : "<",
                        "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.user_login_efficiency{country:india AND platform:web or platform:mobile or platform:native_tv or platform:smart_tv} by {platform}.as_count() < -20",                
                        "group_by": "platform",
                        "evaluation_delay": "180",
                        "notify_nodata": true             
                       },
                        { 
                        "metric_name" : "gv2.user_tv_activation",
                        "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                        "priority" : 1,
                        "message" : "TV Activation Rate",
                        "query_time_window" : "last_5m",
                        "monitor_thresholds" : "-20",
                        "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                        "operator" : "<",
                        "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.user_tv_activation{country:india AND platform:web or platform:mobile or platform:native_tv or platform:smart_tv} by {platform}.as_count() < -20",
                        "group_by": "platform",
                        "evaluation_delay": "180",
                        "notify_nodata": true             
                       },
                        { 
                        "metric_name" : "gv2.user_login_error",
                        "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                        "priority" : 1,
                        "message" : "Login Error",
                        "query_time_window" : "last_5m",
                        "monitor_thresholds" : "-20",
                        "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                        "operator" : "<",
                        "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.user_login_error{country:india AND platform:web or platform:mobile or platform:native_tv or platform:smart_tv} by {platform}.as_count() < -20",
                        "group_by": "platform",
                        "evaluation_delay": "180",
                        "notify_nodata": true             
                       },
                        { 
                        "metric_name" : "gv2.user_activation_code_TV",
                        "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                        "priority" : 1,
                        "message" : "Activation Code Loading rate",
                        "query_time_window" : "last_5m",
                        "monitor_thresholds" : "-20",
                        "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                        "operator" : "<",
                        "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.user_activation_code_TV{country:india AND platform:web or platform:mobile or platform:native_tv or platform:smart_tv} by {platform}.as_count() < -20",                
                        "group_by": "platform",
                        "evaluation_delay": "180",
                        "notify_nodata": true             
                       },
                         { 
                         "metric_name" : "gv2.payment_wall_user",
                         "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                         "priority" : 1,
                         "message" : "Paywall Discovery",
                         "query_time_window" : "last_5m",
                         "monitor_thresholds" : "-5",
                         "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                         "operator" : "<",
                         "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.payment_wall_user{country:india AND platform:web or platform:mobile or platform:native_tv or platform:smart_tv} by {platform}.as_count() < -5",
                         "group_by": "platform",
                         "evaluation_delay": "180",
                         "notify_nodata": true             
                        },
                         { 
                         "metric_name" : "gv2.planpage_performance_user",
                         "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                         "priority" : 1,
                         "message" : "Plan Page performance",
                         "query_time_window" : "last_5m",
                         "monitor_thresholds" : "-5",
                         "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                         "operator" : "<",
                         "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.planpage_performance_user{country:india AND platform:web or platform:mobile or platform:native_tv or platform:smart_tv} by {platform}.as_count() < -5",
                         "group_by": "platform",
                         "evaluation_delay": "180",
                         "notify_nodata": true             
                        },
                         { 
                         "metric_name" : "gv2.paymentpage_performance_user",
                         "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                         "priority" : 1,
                         "message" : "Payment Page Performance rate",
                         "query_time_window" : "last_5m",
                         "monitor_thresholds" : "-5",
                         "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                         "operator" : "<",
                         "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.paymentpage_performance_user{country:india AND platform:web or platform:mobile or platform:native_tv or platform:smart_tv} by {platform}.as_count() < -5",
                         "group_by": "platform",
                         "evaluation_delay": "180",
                         "notify_nodata": true             
                        },
                        { 
                        "metric_name" : "gv2.subscription_transaction_ratio",
                        "metric_keyword" : "country:india AND subscription_status", 
                        "priority" : 1,
                        "message" : "Subscription Transation Ratio",
                        "query_time_window" : "last_5m",
                        "monitor_thresholds" : "-5",
                        "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                        "operator" : "<",
                        "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.subscription_transaction_ratio{*}.as_count() < -5",
                        "group_by": "platform",
                        "evaluation_delay": "180",
                        "notify_nodata": true             
                       },
                       { 
                       "metric_name" : "gv2.ev_new_payment_sucess",
                       "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                       "priority" : 1,
                       "message" : "Subscription Transation Ratio",
                       "query_time_window" : "last_5m",
                       "monitor_thresholds" : "-5",
                       "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                       "operator" : "<",
                       "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.ev_new_payment_sucess{*} by {payment_method}.as_count() < -5",
                       "group_by": "platform",
                       "evaluation_delay": "180",
                       "notify_nodata": true             
                      },
                      { 
                       "metric_name" : "gv2.ev_renew_payment_sucess",
                       "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                       "priority" : 1,
                       "message" : "EV Renew Payment Success Rate",
                       "query_time_window" : "last_5m",
                       "monitor_thresholds" : "-5",
                       "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                       "operator" : "<",
                       "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.ev_renew_payment_sucess{*} by {payment_method}.as_count() < -5",
                       "group_by": "platform",
                       "evaluation_delay": "180",
                       "notify_nodata": true             
                      },
                        { 
                        "metric_name" : "gv2.create_otp",
                        "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                        "priority" : 1,
                        "message" : "OTP Success rate",
                        "query_time_window" : "last_5m",
                        "monitor_thresholds" : "60",
                        "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                        "operator" : "<",
                        "query" : "sum(last_5m):(sum:gv2.confirm_otp{*} by {platform}.as_count() / sum:gv2.create_otp{*} by {platform}.as_count()) * 100 < 60",
                        "group_by": "platform",
                        "evaluation_delay": "180",
                        "notify_nodata": true
                       },
                       { 
                        "metric_name" : "gv2.session_landpage",
                        "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                        "priority" : 1,
                        "message" : "App Open to Landing page",
                        "query_time_window" : "last_5m",
                        "monitor_thresholds" : "-20",
                        "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                        "operator" : "<",
                        "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.session_landpage{country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv} by {platform}.as_count() < -20"               
                        "group_by": "platform",
                        "evaluation_delay": "180",
                        "notify_nodata": true             
                       },
                        { 
                        "metric_name" : "gv2.session_homepage",
                        "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                        "priority" : 1,
                        "message" : "App Open to Home page",
                        "query_time_window" : "last_5m",
                        "monitor_thresholds" : "-20",
                        "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                        "operator" : "<",
                        "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.session_homepage{country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv} by {platform}.as_count() < -20",
                        "group_by": "platform",
                        "evaluation_delay": "180",
                        "notify_nodata": true             
                       },
                        { 
                        "metric_name" : "gv2.session_discovery",
                        "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                        "priority" : 1,
                        "message" : "App Open to Discovery page",
                        "query_time_window" : "last_5m",
                        "monitor_thresholds" : "-20",
                        "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                        "operator" : "<",
                        "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.session_discovery{country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv} by {platform}.as_count() < -20",
                        "group_by": "platform",
                        "evaluation_delay": "180",
                        "notify_nodata": true             
                       },
                        { 
                        "metric_name" : "gv2.session_impression",
                        "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                        "priority" : 1,
                        "message" : "Home Page to Impression(CTR)",
                        "query_time_window" : "last_5m",
                        "monitor_thresholds" : "-20",
                        "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                        "operator" : "<",
                        "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.session_impression{country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv} by {platform}.as_count() < -20",                
                        "group_by": "platform",
                        "evaluation_delay": "180",
                        "notify_nodata": true             
                       },
                         { 
                         "metric_name" : "gv2.session_asset_to_home",
                         "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                         "priority" : 1,
                         "message" : "Home Page to Asset Clicked",
                         "query_time_window" : "last_5m",
                         "monitor_thresholds" : "-20",
                         "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                         "operator" : "<",
                         "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.session_asset_to_home{country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv} by {platform}.as_count() < -20",                
                        "group_by": "platform",
                         "evaluation_delay": "180",
                         "notify_nodata": true             
                        },
                         { 
                         "metric_name" : "gv2.session_asset_detail",
                         "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                         "priority" : 1,
                         "message" : "Asset Clicked to Detail Page",
                         "query_time_window" : "last_5m",
                         "monitor_thresholds" : "-20",
                         "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                         "operator" : "<",
                         "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.session_asset_detail{country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv} by {platform}.as_count() < -20",                
                         "group_by": "platform",
                         "evaluation_delay": "180",
                         "notify_nodata": true             
                        },
                         { 
                         "metric_name" : "gv2.session_screen_asset",
                         "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                         "priority" : 1,
                         "message" : "Detail Page to Asset Clicked",
                         "query_time_window" : "last_5m",
                         "monitor_thresholds" : "-20",
                         "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                         "operator" : "<",
                         "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.session_screen_asset{country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv} by {platform}.as_count() < -20",                
                         "group_by": "platform",
                         "evaluation_delay": "180",
                         "notify_nodata": true             
                        },
                        { 
                        "metric_name" : "gv2.session_app_open_vv",
                        "metric_keyword" : "country:india AND subscription_status", 
                        "priority" : 1,
                        "message" : "App Open to Video View",
                        "query_time_window" : "last_5m",
                        "monitor_thresholds" : "-20",
                        "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                        "operator" : "<",
                        "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.session_app_open_vv{country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv} by {platform}.as_count() < -20",                
                        "group_by": "platform",
                        "evaluation_delay": "180",
                        "notify_nodata": true             
                       },
                       { 
                       "metric_name" : "gv2.search_impression_session",
                       "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                       "priority" : 1,
                       "message" : "Search to Impression",
                       "query_time_window" : "last_5m",
                       "monitor_thresholds" : "-20",
                       "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                       "operator" : "<",
                       "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.search_impression_session{country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv} by {platform}.as_count() < -20",                
                       "group_by": "platform",
                       "evaluation_delay": "180",
                       "notify_nodata": true             
                      },
                      { 
                       "metric_name" : "gv2.gob_asset_clicked_users",
                       "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                       "priority" : 1,
                       "message" : "Details Page Impression to GOB Asset Click",
                       "query_time_window" : "last_5m",
                       "monitor_thresholds" : "-20",
                       "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                       "operator" : "<",
                       "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.gob_asset_clicked_users{country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv} by {platform}.as_count() < -20",                
                       "group_by": "platform",
                       "evaluation_delay": "180",
                       "notify_nodata": true             
                      },
                        { 
                        "metric_name" : "gv2.nongob_asset_clicked_users",
                        "metric_keyword" : "country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv", 
                        "priority" : 1,
                        "message" : "Details Page Impression to Non GOB Asset Click",
                        "query_time_window" : "last_5m",
                        "monitor_thresholds" : "-20",
                        "notification_channel" : "@slack-godavari-v2-warroom-alerts,@saloni.jain@setindia.com",
                        "operator" : "<",
                        "query" : "pct_change(sum(last_10m),last_5m):avg:gv2.nongob_asset_clicked_users{country:india AND subscription_status:overall AND platform:mobile or platform:web or platform:smart_tv or platform:native_tv} by {platform}.as_count() < -20",                
                        "group_by": "platform",
                        "evaluation_delay": "180",
                        "notify_nodata": true
                       }
            ]
}