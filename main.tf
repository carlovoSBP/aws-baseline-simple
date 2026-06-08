data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "mcaf-account-baseline" {
  source  = "schubergphilis/mcaf-account-baseline/aws"
  version = "7.1.0"

  # setting not supported in aws eusc
  aws_ebs_snapshot_block_public_access_state = null
  enable_additional_eu_regions               = false
  extra_regions_to_baseline                  = []
}

module "artifacts_bucket" {
  source  = "schubergphilis/mcaf-s3/aws"
  version = "3.0.0"

  name = format("artifacts-%s-%s", data.aws_caller_identity.current.account_id, data.aws_region.current.region)

  lifecycle_rule = [
    {
      id      = "cleanup"
      enabled = true

      abort_incomplete_multipart_upload = {
        days_after_initiation = 2
      }

      expiration = {
        expired_object_delete_marker = true
      }
    }
  ]
}

resource "aws_budgets_budget" "default" {
  budget_type  = "COST"
  limit_amount = var.monthly_budget_limit
  limit_unit   = "EUR"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = "100"
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.notification_email]
  }
}
