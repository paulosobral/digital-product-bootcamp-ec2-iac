resource "aws_cloudwatch_log_group" "amazon_cloudwatch_agent" {
  name              = "amazon_cloudwatch_agent"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_stream" "amazon_cloudwatch_agent" {
  name           = var.cloudwatch_log_stream_agent_name
  log_group_name = aws_cloudwatch_log_group.amazon_cloudwatch_agent.name
}

resource "aws_cloudwatch_log_group" "docker_compose" {
  name              = "docker_compose"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_stream" "docker_compose" {
  name           = var.cloudwatch_log_stream_docker_name
  log_group_name = aws_cloudwatch_log_group.docker_compose.name
}