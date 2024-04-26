module "s3_bucket" {
  source      = "../../../modules/storage/s3"
  bucket_name = "wnt-example-bucket-dev2"
}
