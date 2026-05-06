variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "clouddevops"
}

variable "key_name" {
  description = "AWS Key pair name"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}