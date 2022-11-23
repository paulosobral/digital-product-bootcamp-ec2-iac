module "cloudwatch_agent" {
  source = "git::https://github.com/paulosobral/terraform-aws-cloudwatch-agent?ref=develop"

  name      = "cloudwatch_agent"
  namespace = "blockchain"
  stage     = "dev"

  metrics_config = "standard" # Accepts only standard or advanced.
}