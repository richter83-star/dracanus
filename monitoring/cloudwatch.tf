resource "aws_cloudwatch_log_group" "dracanus_app" {
  name              = "/dracanus/app"
  retention_in_days = 30
}
