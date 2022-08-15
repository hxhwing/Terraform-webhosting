output "ALB_URL" {
  value = aws_lb.ALB-tf.dns_name
}