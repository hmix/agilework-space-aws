data "aws_kms_alias" "cmk-std-eu-central-1" {
	name = "alias/cmk-std-eu-central-1"
}

resource "aws_s3_bucket" "agilework-space-userdata" {
  bucket = "agilework-space-userdata"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${data.aws_kms_alias.cmk-std-eu-central-1.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

# TODO:
# - Add bucket policy restricting access
# - Add role for bucket policy
# - Add IAM user hmi
# - Add role to user
resource "aws_s3_bucket" "hmi-userdata" {
  bucket = "hmi-userdata"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${data.aws_kms_alias.cmk-std-eu-central-1.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

