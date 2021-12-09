variable "node_pool" {
  type = map(object({
    name = string,
    cloudinit = string,
    cpu = number,
    disk = number,
    memory = number
  }))
  default = {}
}