
variable "name" {
  type        = string
  description = "Name that will flow through the VNET resources"
}

variable "azure_region" {
  type        = string
  description = "Region"
}

variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "client_id" {
  type        = string
  description = "Azure Client ID"
}

variable "client_secret" {
  type        = string
  description = "Azure Client secret"
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}

