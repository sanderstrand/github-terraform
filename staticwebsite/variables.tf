variable "location" {
  type        = string
  description = "Location of the resource"
  default = "westeurope"
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group"
  default = "rg_web_98"
}

variable "sa_name" {
  type        = string
  description = "Name of the storage account"
  default = "saweb98"

}

variable "source_content" {
  type        = string
  description = "Source content for the index.html filee"
  default = "<h1>Web page created with terraform - CI/CD - 1600</h1>"
}

variable "index_document" {
  type        = string
  description = "Index.html"
  default = "index.html"
}