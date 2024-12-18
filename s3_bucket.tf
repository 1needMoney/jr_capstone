# s3_bucket.tf

resource "aws_s3_bucket" "wordpress_media" {
  bucket = "wordpress-media-bucket-{{random_id.bucket_id.hex}}"
  acl    = "private"  # Keep the bucket private

  tags = {
    Name = "WordPressMediaBucket"
    Environment = "Production"
  }
}

# Optionally, you can create a bucket policy to allow public access for WordPress media
resource "aws_s3_bucket_object" "wordpress_media_index" {
  bucket = aws_s3_bucket.wordpress_media.bucket
  key    = "index.html"
  acl    = "private"
  content = "<html><body><h1>WordPress Media Bucket</h1></body></html>"
}
