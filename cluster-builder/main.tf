data "nutanix_clusters" "clusters" {}

resource "nutanix_virtual_machine" "vm1" {

  cluster_uuid = data.nutanix_clusters.clusters.entities.0.metadata.uuid

  parent_reference = { 
    kind = "vm"
    uuid = "4f3c9b17-7e4b-468f-acfe-e976ff87714d" # CentOS-7-x86_64-Minimal-2003.iso (7.8.2003)(Ax)
  }

  nic_list {
    subnet_uuid = "9f117534-309f-447f-bd4a-4143bbb2d560" # TAP_DEV_MGMT
  }

  nic_list {
    subnet_uuid = "410d1deb-3d33-4066-ad0f-76af1c186821" # TAP_DEV
  }

  disk_list { # disk OS default
    disk_size_mib = 204800
  }

  disk_list { # disk IDE CDROM
    disk_size_mib = 1
  }

  num_sockets          = 2

  for_each = var.node_pool
  
    name                  = each.value.name
    num_vcpus_per_socket  = each.value.cpu
    memory_size_mib       = each.value.memory
    guest_customization_cloud_init_user_data = each.value.cloudinit
    disk_list { # disk data: need a second apply
      disk_size_mib = each.value.disk
    }
  
}