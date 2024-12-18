# s3_bucket.tf

resource "aws_s3_bucket" "wordpress_media" {
  bucket = "wordpress-media-bucket-${random_id.bucket_id.hex}"

  tags = {
    Name        = "WordPressMediaBucket"
    Environment = "Production"
  }
}

resource "aws_s3_bucket_acl" "wordpress_media_acl" {
  bucket = aws_s3_bucket.wordpress_media.id
  acl    = "private"
}


# Optionally, you can create a bucket policy to allow public access for WordPress media
resource "aws_s3_object" "wordpress_media_index" {
  bucket  = aws_s3_bucket.wordpress_media.id
  key     = "index.html"
  content = "<html><body><h1>WordPress Media Bucket</h1></body></html>"
}

resource "aws_s3_object_acl" "wordpress_media_index_acl" {
  bucket = aws_s3_bucket.wordpress_media.id
  key    = aws_s3_object.wordpress_media_index.key
  acl    = "private"
}
