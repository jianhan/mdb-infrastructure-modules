output "lambda_function_arn" {
  value = aws_lambda_function.lambda_function.arn
  description = "ARN of iam role for lambda"
}

output "lambda_function_name" {
  value = aws_lambda_function.lambda_function.function_name
  description = "Lambda function name"
}

output "lambda_function_target_id" {
  value = aws_lambda_function.lambda_function.id
  description = "Lambda function target id"
}
