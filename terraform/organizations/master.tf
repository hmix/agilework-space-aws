# Provide a config.env file with corresponding env vars, e.g.
#
# TERRAFORM_STATE_BUCKET=agileworkspace_terraform_state
# PROFILE_PREFIX=agileworkspace_
# AWS_REGION=eu-central-1

# Genereal settings
provider "aws" {
  region									= "eu-central-1"
  profile                 = "agileworkspaceterraform"
	shared_credentials_file = "~/.aws/credentials"
}

# Organization example
# resource "aws_organizations_organization" "agileworkspace" {
#   aws_service_access_principals = [
#     "cloudtrail.amazonaws.com"
#   ]
#
#   feature_set = "ALL"
# }

data "aws_organizations_organization" "agileworkspace" {}

output "id" {
  value = data.aws_organizations_organization.agileworkspace.id
}

output "feature_set" {
  value = data.aws_organizations_organization.agileworkspace.feature_set
}

output "master_account_id" {
  value = data.aws_organizations_organization.agileworkspace.master_account_id
}

output "master_account_email" {
  value = data.aws_organizations_organization.agileworkspace.master_account_email
}

output "non_master_account_ids" {
  value = data.aws_organizations_organization.agileworkspace.non_master_accounts[*].id
}

output "non_master_account_emails" {
  value = data.aws_organizations_organization.agileworkspace.non_master_accounts[*].email
}

output "non_master_account_names" {
  value = data.aws_organizations_organization.agileworkspace.non_master_accounts[*].name
}

output "aws_service_access_principals" {
  value = data.aws_organizations_organization.agileworkspace.aws_service_access_principals
}

output "enabled_policy_types" {
  value = data.aws_organizations_organization.agileworkspace.enabled_policy_types
}

# Service Control Policies
resource "aws_organizations_policy" "deny_leaving_organization" {
	name = "deny_leaving_organization"

	content = <<CONTENT
{
		"Version": "2012-10-17",
		"Statement": [
				{
						"Sid": "DenyLeavingOrganization",
						"Effect": "Deny",
						"Action": [
								"organizations:LeaveOrganization"
						],
						"Resource": [
								"*"
						]
				}
		]
}
CONTENT
}

resource "aws_organizations_policy" "deny_deactivating_cloudtrail" {
	name = "deny_deactivating_cloudtrail"

	content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": "cloudtrail:StopLogging",
      "Resource": "*"
    }
  ]
}
CONTENT
}

resource "aws_organizations_policy" "deny_deactivating_vpc_flowlogs" {
	name = "deny_deactivating_vpc_flowlogs"

	content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": [
        "ec2:DeleteFlowLogs",
        "logs:DeleteLogGroup",
        "logs:DeleteLogStream"
      ],
      "Resource": "*"
    }
  ]
 }
CONTENT
}
