variable "rg_backend_name" {
    type = string
    description = "Name of the resource group for the backend"
}

variable "rg_backend_location" {
    type = string
    description = "location of the resource group for the backend"
}

variable "sa_backend_name" {
    type = string
    description = "name of the storage account for the backend"
}

variable "sc_backend_name" {
    type = string
    description = "name of the storage container for the backen"
}

variable "sa_backend_accesskey_name" {
    type = string
    description = "Name of the storage account access key for the backend"
  
}

variable "kv_backend_name" {
    type = string 
    description = "Name of the key vault for the backend"
  
}