module "s3_bucket" {
  source      = "../../../modules/storage/s3/bucket"
  bucket_name = "wnt-example-bucket-dev4"
}
