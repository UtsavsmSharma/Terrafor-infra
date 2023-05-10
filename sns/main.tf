# provider "aws" {
#   region = "us-east-1"
# }
resource "aws_sns_topic" "user_updates" {
  name = "my-topic-1"
  
}
resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = "arn:aws:sns:us-east-1:136886591371:my-topic-1"
  protocol  = "email"
  endpoint  = "utsavsharma1313@gmail.com"
}