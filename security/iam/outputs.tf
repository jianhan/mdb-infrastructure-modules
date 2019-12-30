output "lambda_arn" {
  value       = aws_iam_role.lambda.arn
  description = "ARN of iam role for lambda"
}

output "lambda_name" {
  value       = aws_iam_role.lambda.name
  description = "Name of iam role for lambda"
}

output "lambda_logging_arn" {
  value = aws_iam_policy.lambda_logging.arn
  description = "ARN of iam lambda logging"
}
