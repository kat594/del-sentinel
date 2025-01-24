module "policy_onboarding" {
  source = "./modules/policy_onboarding"

  organization                  = var.organization
  organization_email            = var.organization_email
  policy_name                   = var.policy_name
  policy_description            = var.policy_description
  policy                        = var.policy
  enforce_mode                  = var.enforce_mode
  policy_set_name               = var.policy_set_name
  policy_set_description        = var.policy_set_description
  agent_enabled                 = var.agent_enabled
  policy_tool_version           = var.policy_tool_version
  policies_path                 = var.policies_path
  workspace_ids                 = var.workspace_ids
  vcs_repo_identifier           = var.vcs_repo_identifier
  vcs_repo_branch               = var.vcs_repo_branch
  vcs_repo_ingress_submodules   = var.vcs_repo_ingress_submodules
  oauth_token_id               = var.oauth_token_id
  policy_set_parameter_key      = var.policy_set_parameter_key
  policy_set_parameter_value    = var.policy_set_parameter_value
}




------------




variable "organization" {
  description = "The name of the TFE organization."
  type        = string
}

variable "organization_email" {
  description = "The email of the TFE organization admin."
  type        = string
}

variable "policy_name" {
  description = "The name of the Sentinel policy."
  type        = string
}

variable "policy_description" {
  description = "A description for the Sentinel policy."
  type        = string
}

variable "policy" {
  description = "The actual Sentinel policy code."
  type        = string
}

variable "enforce_mode" {
  description = "The enforce mode for the policy."
  type        = string
  default     = "hard-mandatory"
}

variable "policy_set_name" {
  description = "The name of the policy set."
  type        = string
}

variable "policy_set_description" {
  description = "A description for the policy set."
  type        = string
}

variable "agent_enabled" {
  description = "Flag to enable the agent."
  type        = bool
  default     = true
}

variable "policy_tool_version" {
  description = "The version of the policy tool."
  type        = string
  default     = "0.24.1"
}

variable "policies_path" {
  description = "Path to the policies in the repository."
  type        = string
}

variable "workspace_ids" {
  description = "A list of workspace IDs to associate the policy set with."
  type        = list(string)
}

variable "vcs_repo_identifier" {
  description = "The VCS repository identifier for the policy set."
  type        = string
}

variable "vcs_repo_branch" {
  description = "The branch of the VCS repository."
  type        = string
}

variable "vcs_repo_ingress_submodules" {
  description = "Flag to include submodules in the VCS repository."
  type        = bool
}

variable "oauth_token_id" {
  description = "The OAuth token ID for VCS integration."
  type        = string
}

variable "policy_set_parameter_key" {
  description = "The key for the policy set parameter."
  type        = string
}

variable "policy_set_parameter_value" {
  description = "The value for the policy set parameter."
  type        = string
}





------
terraform.tfvars

organization = "my-org-name"
organization_email = "admin@company.com"
policy_name = "my-policy-name"
policy_description = "This policy always passes"
policy = "main = rule { true }"
enforce_mode = "hard-mandatory"
policy_set_name = "my-policy-set-name"
policy_set_description = "A brand new policy set"
agent_enabled = true
policy_tool_version = "0.24.1"
policies_path = "policies/my-policy-set"
workspace_ids = ["workspace-id-1", "workspace-id-2"]
vcs_repo_identifier = "my-org-name/my-policy-set-repository"
vcs_repo_branch = "main"
vcs_repo_ingress_submodules = false
oauth_token_id = "oauth-token-id"
policy_set_parameter_key = "my_key_name"
policy_set_parameter_value = "my_value_name"


---







