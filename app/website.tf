resource "aws_s3_bucket" "site" {
  bucket = "fraser-house-devops-${var.env_name}"
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.site.bucket
  key    = "index.html"
  content = templatefile("${path.module}/website.template.html", {
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

resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket = aws_s3_bucket.site.id
  policy = data.aws_iam_policy_document.allow_public_access.json
}
