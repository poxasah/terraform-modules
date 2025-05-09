##################
# Bucket Files
#####
resource "aws_s3_bucket" "s3_files" {
  bucket        = "demo.${var.environment}"
  force_destroy = true

  tags = {
    Name        = "${var.project}"
    Project     = var.project
    Environment = var.environment
  }
  lifecycle {
    ignore_changes = all
  }
}