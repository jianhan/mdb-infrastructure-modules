# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE AN S3 BUCKET AND DYNAMODB TABLE TO USE AS A TERRAFORM BACKEND
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# ----------------------------------------------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.12"
}

# ------------------------------------------------------------------------------
# CONFIGURE OUR AWS CONNECTION
# ------------------------------------------------------------------------------
provider "aws" {
  region = "ap-southeast-2"
}

# ------------------------------------------------------------------------------
# CONFIGURE LOCAL VARIABLES
# ------------------------------------------------------------------------------
locals {
  service_tier = "lambda"
  owner        = "Jian Han"
  provider     = "terraform"
}

# ------------------------------------------------------------------------------
# CONFIGURE TAGS
# ------------------------------------------------------------------------------
locals {
  # Common tags to be assigned to all resources
  common_tags = {
    ServiceTier = local.service_tier
    Owner       = local.owner
    Provider    = local.provider
  }
}

# ------------------------------------------------------------------------------
# CREATE S3 BUCKET
# ------------------------------------------------------------------------------
resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.bucket_prefix}-bucket"
  versioning {
    enabled = true
  }
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      # This block turns server-side encryption on by default for all data written to
      # this S3 bucket. This ensures that your state files, and any secrets they may contain, are always encrypted on disk when stored in S3.
      # apply_server_side_encryption_by_default
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "GET"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 6000
  }

  # tags
  tags = merge(
  {
    Resource = "s3"
  },
  local.common_tags)
}
