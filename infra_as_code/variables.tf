variable "my_ip" {
  description = "My IP Address that I will set while applying terraform"
  type        = string
  default     = "197.27.108.190"
}

variable "ssh_public_key" {
  description = "the value of my ssh public key stored in ~/.ssh/id_rsa.pub"
  type        = string
}
