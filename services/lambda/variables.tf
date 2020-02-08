variable "filename" {
  type = string
  description = "Lambda zip file name"
}

variable "env_prefix" {
  type = string
  description = "Environment prefix"
}

variable "function_name" {
  type = string
  description = "function name"
}

variable "handler" {
  type = string
  description = "Lambda handler"
}

variable "runtime" {
  type = string
  description = "Lambda run time"
}

variable "environment_variables" {
  type = "map"
}

variable "timeout" {
  type = number
  default = 300
}

variable "memory_size" {
  type = number
  default = 256
}
