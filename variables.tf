variable "name" {
  description = "The name of the NAT Gateway. Must be between 1 and 80 characters."
  type        = string

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 80
    error_message = "NAT Gateway name must be between 1 and 80 characters."
  }
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the NAT Gateway."
  type        = string
}

variable "location" {
  description = "The Azure region where the NAT Gateway should exist."
  type        = string
}

variable "sku_name" {
  description = "The SKU which should be used for this NAT Gateway. Accepted value is Standard."
  type        = string
  default     = "Standard"

  validation {
    condition     = var.sku_name == "Standard"
    error_message = "SKU name must be 'Standard'."
  }
}

variable "idle_timeout_in_minutes" {
  description = "The idle timeout which should be used in minutes. Value must be between 4 and 120."
  type        = number
  default     = 4

  validation {
    condition     = var.idle_timeout_in_minutes >= 4 && var.idle_timeout_in_minutes <= 120
    error_message = "Idle timeout must be between 4 and 120 minutes."
  }
}

variable "zones" {
  description = "A list of availability zones in which the NAT Gateway should be located."
  type        = list(string)
  default     = ["1"]
}

variable "public_ip_address_ids" {
  description = "A list of Public IP IDs to associate with this NAT Gateway."
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "A list of Subnet IDs to associate with this NAT Gateway."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
