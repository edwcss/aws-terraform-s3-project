provider "aws" {
  region = var.aws_region
}

# 1. Main S3 Bucket
resource "aws_s3_bucket" "my_test_bucket" {
  bucket = var.bucket_name

  tags = {
    Environment = "Dev"
    Project     = "Static-Website"
    ManagedBy   = "Terraform"
  }
}

# 2. Website & File Configuration
resource "aws_s3_bucket_website_configuration" "res_site" {
  bucket = aws_s3_bucket.my_test_bucket.id
  index_document { suffix = "index.html" }
}

resource "aws_s3_object" "upload_index" {
  bucket       = aws_s3_bucket.my_test_bucket.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
}

# 3. Security & Access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.my_test_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket = aws_s3_bucket.my_test_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "PublicReadGetObject"
      Effect    = "Allow"
      Principal = "*"
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.my_test_bucket.arn}/*"
    }]
  })
  depends_on = [aws_s3_bucket_public_access_block.public_access]
}

# 4. Advanced Data Management (Versioning, Encryption, Lifecycle)
resource "aws_s3_bucket_versioning" "v1" {
  bucket = aws_s3_bucket.my_test_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "e1" {
  bucket = aws_s3_bucket.my_test_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "l1" {
  bucket = aws_s3_bucket.my_test_bucket.id
  rule {
    id     = "archive-old-versions"
    status = "Enabled"
    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }
}
