module "mcaf-account-baseline" {
  source  = "schubergphilis/mcaf-account-baseline/aws"
  version = "7.1.0"

  # setting not supported in aws eusc
  aws_ebs_snapshot_block_public_access_state = null
  enable_additional_eu_regions               = false
  extra_regions_to_baseline                  = []
}
