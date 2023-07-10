#resource group
resource "azurerm_resource_group" "terraform_yovel_rg" {
  name     = "${var.resource_group_name}${var.project_name}"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet_yovel" {
  name                = "${var.virtual_network_name}${var.project_name}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.terraform_yovel_rg.location
  resource_group_name = azurerm_resource_group.terraform_yovel_rg.name
}

resource "azurerm_subnet" "subnet_web_yovel" {
  name                 = "${var.sub_net_name}${var.project_name}${var.web_name}"
  resource_group_name  = azurerm_resource_group.terraform_yovel_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_yovel.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet_db_yovel" {
  name                 = "${var.sub_net_name}${var.project_name}${var.data_base_name}"
  resource_group_name  = azurerm_resource_group.terraform_yovel_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_yovel.name
  address_prefixes     = ["10.0.2.0/24"]
}


#change to resource or learn more of modules
resource "azurerm_network_security_group" "nsg_web_yovel"{
  
  name                  = "${var.network_security_name}${var.project_name}${var.web_name}"
  location              = azurerm_resource_group.terraform_yovel_rg.location
  resource_group_name   = azurerm_resource_group.terraform_yovel_rg.name
  
  security_rule {
    name                       = "AllowAll"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    
  }
  security_rule {    
    name                       = "AllowSSH"
    priority                   = 105
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }
}   


resource "azurerm_network_security_group" "nsg_db_yovel"{
  
  name                  = "${var.network_security_name}${var.project_name}${var.db_name}"
  location              = azurerm_resource_group.terraform_yovel_rg.location
  resource_group_name   = azurerm_resource_group.terraform_yovel_rg.name
  
  security_rule {
    name                       = "AllowSSH"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    
  }
}

resource "azurerm_subnet_network_security_group_association" "asso_snet_nsg_web_yovel" {
  subnet_id                 = azurerm_subnet.subnet_web_yovel.id 
  network_security_group_id = azurerm_network_security_group.nsg_web_yovel.id
}

resource "azurerm_subnet_network_security_group_association" "asso_snet_nsg_db_yovel" {
  subnet_id                 = azurerm_subnet.subnet_db_yovel.id 
  network_security_group_id = azurerm_network_security_group.nsg_db_yovel.id
}
 