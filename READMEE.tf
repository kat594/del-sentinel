02/09/2025 Only working below
**************THIS IS WORKING******************************02/09/202555/06/34pm*****************<SOF>

provider "tfe" {
  token = "your_tfe_token"
}

# Declare variables for the number of policies and organization
variable "organization" {
  description = "TFE Organization Name"
  type        = string
  default     = "my-org-name"
}

# Use fileset to dynamically load all .sentinel files in the 'policies' folder
locals {
  policy_files = fileset("./policies", "*.sentinel")
}

# Onboard multiple Sentinel policies
resource "tfe_policy" "sentinel_policy" {
  for_each      = toset(local.policy_files)  # Loop through the policy files
  name          = each.key                  # Name based on the file name
  description   = "This policy always passes"
  organization  = var.organization
  kind          = "sentinel"
  enforce_mode  = "hard-mandatory"
  policy        = file("./policies/${each.key}")  # Load each policy file dynamically
}
--
**************THIS IS WORKING******************************02/09/202555/06/34pm*****************<EOF>

**************THIS IS WORKING******************************02/09/202555/06/34pm*****************<SOF>
provider "tfe" {
  token = var.tfe_token  # Use a secure variable for authentication
}

# Declare variables
variable "organization" {
  description = "TFE Organization Name"
  type        = string
  default     = "my-org-name"
}

variable "tfe_token" {
  description = "Terraform Enterprise Token"
  type        = string
  sensitive   = true
}

variable "workspace_ids" {
  description = "List of workspace IDs to associate with the policy set"
  type        = list(string)
  default     = []
}

# Load all Sentinel policy files dynamically
locals {
  policy_files = fileset("./policies", "*.sentinel")
}

# Create multiple Sentinel policies
resource "tfe_policy" "sentinel_policy" {
  for_each     = toset(local.policy_files)  
  name         = trimsuffix(each.key, ".sentinel")  # Remove file extension from policy name
  description  = "Sentinel policy for Terraform governance"
  organization = var.organization
  kind         = "sentinel"
  enforce_mode = "hard-mandatory"
  policy       = file("./policies/${each.key}")  
}

# Create a Policy Set and associate all policies
resource "tfe_policy_set" "sentinel_policy_set" {
  name         = "my-policy-set"
  description  = "Policy Set for governance"
  organization = var.organization
  kind         = "sentinel"
  workspace_ids = var.workspace_ids
  policy_ids    = [for p in tfe_policy.sentinel_policy : p.id]  # Associate all policies
}

**************THIS IS WORKING******************************02/09/202555/06/34pm*****************<EOF>
