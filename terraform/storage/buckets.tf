# resource "aws_kms_key" "cmk-std-eu-central-1" {
# #	key_id 									= "alias/cmk-std-eu-central-1"
#   description             = "Standard CMK for eu-central-1"
# }

data "aws_kms_alias" "cmk-std-eu-central-1" {
	name = "alias/cmk-std-eu-central-1"
}

resource "aws_s3_bucket" "agilework_space-userdata" {
  bucket = "agilework_space-userdata"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        # kms_master_key_id = "${aws_kms_key.cmk-std-eu-central-1.arn}"
        kms_master_key_id = "${data.aws_kms_alias.cmk-std-eu-central-1.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

