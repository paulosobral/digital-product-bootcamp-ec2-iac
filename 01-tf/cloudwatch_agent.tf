module "cloudwatch_agent" {
  source = "git::https://github.com/cloudposse/terraform-aws-cloudwatch-agent?ref=master"

  name      = "cloudwatch_agent"
  namespace = "blockchain"
  stage     = "dev"

  metrics_config = "standard" # Accepts only standard or advanced.
}