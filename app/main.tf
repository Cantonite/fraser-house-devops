variable "emoji" {}
variable "env_name" {}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}


data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}


resource "aws_iam_role" "iam_for_lambda" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "archive_file" "lambda_my_function" {
  type             = "zip"
  source_file      = "${path.module}/handler.py"
  output_file_mode = "0666"
  output_path      = "${path.module}/../.build/lambda_function_payload.zip"
}

resource "aws_lambda_function" "fraser_house_devops" {
  filename         = "${path.module}/../.build/lambda_function_payload.zip"
  function_name    = "fraser-house-devops-${var.env_name}"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "handler.handler"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256("${path.module}/../.build/lambda_function_payload.zip")

  environment {
    variables = {
      EMOJI = var.emoji
    }
  }
}

resource "aws_lambda_function_url" "fraser_house_devops" {
  function_name      = aws_lambda_function.fraser_house_devops.function_name
  authorization_type = "NONE"
}

resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket = aws_s3_bucket.site.id
  policy = data.aws_iam_policy_document.allow_public_access.json
}

data "aws_iam_policy_document" "allow_public_access" {
  statement {
    sid       = "PublicReadGetObject"
    effect    = "Allow"
    resources = ["${aws_s3_bucket.site.arn}/*"]
    actions   = ["s3:GetObject"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket" "site" {
  bucket = "fraser-house-devops-${var.env_name}"
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.site.bucket
  key    = "index.html"
  content = templatefile("${path.module}/index.template.html", {
    emoji_url : aws_lambda_function_url.fraser_house_devops.function_url
  })
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.bucket

  index_document {
    suffix = "index.html"
  }
}

output "website_url" {
  value = aws_s3_bucket_website_configuration.site.website_endpoint
}
