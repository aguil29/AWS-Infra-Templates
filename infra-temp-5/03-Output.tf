output "Object_contents"{
    value = {
        for key, value in aws_s3_object.objects: key => value.id
    }
}

output "Object_content_types"{
      value = {
    for key, value in aws_s3_object.objects: key => value.content_type
  }
}

output "Bucket_Domain"{
    value = aws_s3_bucket.bucketlist.bucket_domain_name
}