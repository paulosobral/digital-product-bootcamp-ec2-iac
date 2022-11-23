module "cloudwatch_agent" {
  source = "git::https://github.com/cloudposse/terraform-aws-cloudwatch-agent?ref=0.2.0"

  name      = "cloudwatch_agent"
  namespace = "blockchain"
  stage     = "dev"

  metrics_config = "standard" # Accepts only standard or advanced.
}