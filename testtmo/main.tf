# #TFE Organization
resource "tfe_organization" "test" {
  name  = "my-org-name"
  email = "admin@company.com"
}

# Sentinel Policies
resource "tfe_policy" "policies" {
  for_each     = var.sentinel_policies
  name         = each.value.name
  description  = each.value.description
  organization = tfe_organization.test.name
  kind         = "sentinel"
  policy       = file(each.value.policy_file)
  enforce_mode = each.value.enforce_mode
}

# Policy Set
resource "tfe_policy_set" "policy_set" {
  name                = var.policy_set_name
  description         = var.policy_set_description
  organization        = tfe_organization.test.name
  kind                = "sentinel"
  agent_enabled       = var.agent_enabled
  policy_tool_version = var.policy_tool_version
  workspace_ids       = [for workspace in var.workspaces : workspace.id] # Dynamically attach workspaces

  vcs_repo {
    identifier         = var.vcs_repo_identifier
    branch             = var.vcs_repo_branch
    ingress_submodules = var.vcs_repo_ingress_submodules
    oauth_token_id     = var.vcs_repo_oauth_token_id
  }
  
  # Attach created policies dynamically
  policy_ids = [for p in tfe_policy.policies : p.id]
}

# Policy Set Parameters
resource "tfe_policy_set_parameter" "parameters" {
  for_each      = var.policy_set_parameters
  key           = each.key
  value         = each.value
  policy_set_id = tfe_policy_set.policy_set.id
}

# Input Variables
variable "sentinel_policies" {
  description = "List of Sentinel policies to onboard"
  type        = map(object({
    name         = string
    description  = string
    policy_file  = string
    enforce_mode = string
  }))
}

variable "policy_set_name" {
  description = "Name of the policy set"
  type        = string
}

variable "policy_set_description" {
  description = "Description of the policy set"
  type        = string
}

variable "policy_tool_version" {
  description = "Sentinel policy tool version"
  type        = string
  default     = "0.24.1"
}

variable "agent_enabled" {
  description = "Enable the policy set agent"
  type        = bool
  default     = true
}

variable "vcs_repo_identifier" {
  description = "Identifier for the VCS repository"
  type        = string
}

variable "vcs_repo_branch" {
  description = "Branch name for the VCS repository"
  type        = string
}

variable "vcs_repo_ingress_submodules" {
  description = "Whether to allow submodules in the VCS repository"
  type        = bool
  default     = false
}

variable "vcs_repo_oauth_token_id" {
  description = "OAuth token ID for accessing the VCS repository"
  type        = string
}

variable "workspaces" {
  description = "List of workspace IDs to attach to the policy set"
  type        = list(object({
    id = string
  }))
}

variable "policy_set_parameters" {
  description = "Parameters to attach to the policy set"
  type        = map(string)
}
