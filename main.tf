resource "random_pet" "example" {
}

resource "azurerm_resource_group" "example" {
  name     = format("rg-%s", random_pet.example.id)
  location = var.location
}

resource "azurerm_virtual_network" "example" {
  name                = format("vnet-%s", random_pet.example.id)
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "example" {
  name                 = format("subnet-%s", random_pet.example.id)
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.0.0/24"]
}

module "pe" {
  source              = "./pe"
  resource_group_name = azurerm_resource_group.example.name
  name                = format("%s", random_pet.example.id)
  subnet_id           = azurerm_subnet.example.id
  create_dns_zone     = true
}
