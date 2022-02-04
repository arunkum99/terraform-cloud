variable "project_id" {
  type    = string
  default = "learning-245417"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "subnet" {
  description = "The subnet self link"
  default     = "custom-subnet"
}