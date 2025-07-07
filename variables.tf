variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "h09"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "subscription_id" {
  description = "Azure subscription"
  type        = string
}