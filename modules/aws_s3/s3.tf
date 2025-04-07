
##################
# Bucket Files DevOps
#####
resource "aws_s3_bucket" "s3_files_devops" {
  bucket        = "demo.${var.environment}.devops"
  force_destroy = true

  tags = {
    Name        = "${var.project}-devops"
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }
  lifecycle {
    ignore_changes = all
  }
}