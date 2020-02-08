# ------------------------------------------------------------------------------
# LOAD IAM MOUDLE
# ------------------------------------------------------------------------------
module "lambda_iam" {
    source = "../../security/iam"
    function_name = var.function_name
}

# ------------------------------------------------------------------------------
# LAMBDA FUNCTION RESOURCE
# ------------------------------------------------------------------------------
resource "aws_lambda_function" "lambda_function" {
  filename      = var.filename
  function_name = "${var.env_prefix}_${var.function_name}_function"
  role          = module.lambda_iam.lambda_arn
  handler       = var.handler
  source_code_hash = filebase64sha256(var.filename)
  runtime = var.runtime
  timeout = var.timeout
  memory_size = var.memory_size
  environment {
    variables = var.environment_variables
  }
}
