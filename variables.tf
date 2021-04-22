variable stack_count {
  type        = number
  default     = 1
  description = "Amount application stacks to create"
}

variable "zone" {
  default = "us-central1-c"
}

variable "region" {
  default = "us-central1"
}

variable project_id {
  type        = string
  default     = "rich-involution-303217"
  description = "Google Project ID"
}

variable "vm_instance_count" {
  type        = number
  default     = 1
  description = "Amount of VM's to create"
}
