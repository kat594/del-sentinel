terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.42.0"
    }
  }
}

provider "tfe" {
  # Ensure your Terraform Cloud/Enterprise token is set as an environment variable: TFE_TOKEN
}

module "sentinel_policies" {
  source = "./modules/sentinel_policies"

  tfe_org                = var.tfe_org
  policy_set_name        = var.policy_set_name
  policy_set_description = var.policy_set_description
  agent_enabled          = var.agent_enabled
  policy_tool_version    = var.policy_tool_version
  vcs_repo_identifier    = var.vcs_repo_identifier
  vcs_repo_branch        = var.vcs_repo_branch
  vcs_repo_ingress_submodules = var.vcs_repo_ingress_submodules
  vcs_repo_oauth_token_id = var.vcs_repo_oauth_token_id

  workspaces          = var.workspaces
  sentinel_policies   = var.sentinel_policies
  policy_set_parameters = var.policy_set_parameters
}
