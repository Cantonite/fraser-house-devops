data "archive_file" "lambda_my_function" {
  type             = "zip"
  source_file      = "${path.module}/emoji-backend.py"
  output_file_mode = "0666"
  output_path      = "${path.module}/../.build/lambda_function_payload.zip"
}

resource "aws_lambda_function" "fraser_house_devops" {
  filename         = "${path.module}/../.build/lambda_function_payload.zip"
  function_name    = "fraser-house-devops-${var.env_name}"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "emoji-backend.handler"
  runtime          = "python3.9"
  source_code_hash = data.archive_file.lambda_my_function.output_base64sha256

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
