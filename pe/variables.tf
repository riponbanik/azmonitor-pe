variable "name" {
  type        = string
  description = "The name of the ampls service"
  default     = "default"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group to deploy resources"
}

variable "location" {
  type        = string
  description = "location"
  default     = "australiaeast"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the storage account and solutions."
  default     = {}
}

variable "ingestion_access_mode" {
  type        = string
  description = "The default access mode for ingestion associated private endpoints in scope."
  default     = "Open"
  validation {
    condition     = contains(["Open", "PrivateOnly"], var.ingestion_access_mode)
    error_message = "Valid values are: 'Open', 'PrivateOnly'."
  }
}

variable "query_access_mode" {
  type        = string
  description = "The default access mode for query associated private endpoints in scope."
  default     = "Open"
  validation {
    condition     = contains(["Open", "PrivateOnly"], var.query_access_mode)
    error_message = "Valid values are: 'Open', 'PrivateOnly'."
  }
}


variable "create_dns_zone" {
  type        = bool
  description = "Create DNS Zones"
  default     = false
}

variable "private_dns_zone_ids" {
  type        = list(string)
  description = "Private DNS Zone IDs (privatelink.monitor.azure.com, privatelink.oms.opinsights.azure.com, privatelink.ods.opinsights.azure.com, privatelink.agentsvc.azure-automation.net, privatelink.blob.core.windows.net)"
  default     = []
}

variable "service_ids" {
  type        = list(string)
  description = "Id of AMPLS Services e.g. Application Insights, Log Analtyics Workspace"
  default     = []
}

variable "subnet_id" {
  type        = string
  description = "Virtual Network Subnet ID"
}
