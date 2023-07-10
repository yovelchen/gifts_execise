variable "project_name" {
    type        = string
    description = "Project Name"
    default     = "terraform-yovel" 
}

variable "resource_group_name" {
    type        = string
    description = "Resource Group Name"
    default     = "rg-" 
}

variable "virtual_network_name" {
    type        = string
    description = "Virtual Network Name"
    default     = "vnet-" 
}

variable "sub_net_name" {
    type        = string
    description = "Sub Net Name"
    default     = "snet-" 
}

variable "data_base_name" {
    type        = string
    description = "Data Base Name"
    default     = "-db" 
}

variable "web_name" {
    type        = string
    description = "Web Name"
    default     = "-web" 
}

variable "db_name" {
    type        = string
    description = "db Name"
    default     = "-db" 
}

variable "network_security_name" {
    type        = string
    description = "Network Security Name"
    default     = "nsg-" 
}