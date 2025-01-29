variable "tfe_org" {
  type        = string
  description = "Terraform Enterprise Organization Name"
}

variable "policy_set_name" {
  type        = string
  description = "Name of the policy set"
}

variable "policy_set_description" {
  type        = string
  description = "Description of the policy set"
}

variable "agent_enabled" {
  type        = bool
  description = "Enable policy agent"
}

variable "policy_tool_version" {
  type        = string
  description = "Sentinel policy tool version"
}

variable "vcs_repo_identifier" {
  type        = string
  description = "VCS repository identifier"
}

variable "vcs_repo_branch" {
  type        = string
  description = "Branch to use for policies"
}

variable "vcs_repo_ingress_submodules" {
  type        = bool
  description = "Allow ingress of submodules"
}

variable "vcs_repo_oauth_token_id" {
  type        = string
  description = "OAuth token ID for VCS"
}

variable "workspaces" {
  type = list(object({
    id   = string
    name = string
  }))
  description = "List of workspaces to attach the policy set"
}

variable "sentinel_policies" {
  type = map(object({
    name         = string
    description  = string
    policy_file  = string
    enforce_mode = string
  }))
  description = "Map of Sentinel policies to create"
}

variable "policy_set_parameters" {
  type        = map(string)
  description = "Policy set parameters"
}
