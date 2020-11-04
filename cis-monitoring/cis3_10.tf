module "cis_notification_route_table_changes" {
  source             = "../modules/monitoring/notifications"
  compartment_id     = data.terraform_remote_state.iam.outputs.network_compartment_id
  rule_display_name  = "${var.service_label}-notify-on-route-table-changes"    
  rule_description   = "Sends notification when route tables are created, updated, deleted or moved."
  rule_is_enabled    = true
  rule_condition     = <<EOT
  {"eventType":
    ["com.oraclecloud.virtualnetwork.createroutetable",
     "com.oraclecloud.virtualnetwork.deleteroutetable",
     "com.oraclecloud.virtualnetwork.updateroutetable",
     "com.oraclecloud.virtualnetwork.changeroutetablecompartment"]
  }
  EOT
  
  rule_actions_actions_action_type = "ONS"
  rule_actions_actions_is_enabled  = true
  rule_actions_actions_description = "Sends notification via ONS"

  topic_id = module.cis_topics.topic_id
}  