## 1. Create S3 Bucket
##    Create Bucket Name
resource "aws_s3_bucket" "bucketlist" {
  bucket = "bucket-o-brasileiras"
}

## 2. Configure Bucket Ownership to "BucketOwnerPreferred"
##    to enable ACLs
resource "aws_s3_bucket_ownership_controls" "s3controls" {
  bucket = aws_s3_bucket.bucketlist.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

## 3. Bucket Versioning is Disabled
resource "aws_s3_bucket_versioning" "versioning"{
  bucket = aws_s3_bucket.bucketlist.id
  versioning_configuration {
    status = "Disabled"
  }
}

## 4. Turn off Public Access Blocks for Bucket
##    Set Boolean values to false 
resource "aws_s3_bucket_public_access_block" "PABs" {
  bucket = aws_s3_bucket.bucketlist.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

## 5. Configure Bucket ACL to "Public-Read"
##    Needs Bucket Ownership and Bucket Public
##       Access Block Settings
##       For Bucket ACL to take effect
resource "aws_s3_bucket_acl" "S3acls" {
  depends_on = [
    aws_s3_bucket_ownership_controls.s3controls,
    aws_s3_bucket_public_access_block.PABs,
  ]

  bucket = aws_s3_bucket.bucketlist.id
  acl    = "public-read"
}

## 6. Add Objects to Bucket
##    For each loops through 
##    a variable of files / objects to upload
##    AND INCLUDING THE Folder subdirectory
resource "aws_s3_object" "objects" {
  for_each = var.objects
  bucket = aws_s3_bucket.bucketlist.id
  key    = each.key
  source = "./${each.key}"
  content_type = each.value
  acl = "public-read"
}

## 7. Enable Bucket Static Web Hosting
##    Needs the Bucket ACL settings to
##    make it "Public-Read" 
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.bucketlist.id

  index_document {
    suffix = "index.html"
  }

  depends_on =  [ aws_s3_bucket_acl.S3acls ]
}