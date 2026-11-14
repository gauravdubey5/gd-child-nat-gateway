variable "name" {
  type    = string
  default = "ngw-example-basic"
}

variable "resource_group_name" {
  type    = string
  default = "rg-example-basic"
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "example"
  }
}
