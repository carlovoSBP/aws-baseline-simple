variable "monthly_budget_limit" {
  type        = string
  description = "The monthly budget limit for AWS costs"
}

variable "notification_email" {
  type        = string
  description = "The email address to receive budget notifications"
}
