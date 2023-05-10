resource "aws_sqs_queue" "example" {
  name                      = "example-queue.fifo" # Note the .fifo suffix for FIFO queues
  delay_seconds             = 0
  max_message_size          = 262144 # 256 KiB
  message_retention_seconds = 86400 # 1 day
  receive_wait_time_seconds = 0
  visibility_timeout_seconds = 30
  fifo_queue                = true # Set this parameter to create a FIFO queue
}


resource "aws_sqs_queue_policy" "example" {
  queue_url = aws_sqs_queue.example.url
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "AllowSNSToSendMessagesToSQS"
        Effect = "Allow"
        Principal = "*"
        Action = "sqs:SendMessage"
        Resource = aws_sqs_queue.example.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = var.sns_topic_arn
          }
        }
      }
    ]
  })
}







