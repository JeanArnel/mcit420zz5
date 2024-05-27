variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy the resources"
  type        = string
}

variable "admin_username" {
  description = "The admin username for the VMs"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the VMs"
  type        = string
}

variable "db_admin_username" {
  description = "The admin username for the database"
  type        = string
}

variable "db_admin_password" {
  description = "The admin password for the database"
  type        = string
}
