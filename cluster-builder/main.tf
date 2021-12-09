data "nutanix_clusters" "clusters" {}

resource "nutanix_virtual_machine" "vm1" {

  cluster_uuid = data.nutanix_clusters.clusters.entities.0.metadata.uuid

  parent_reference = { 
    kind = "vm"
    uuid = "e4740374-ab12-4ba3-bf77-f3d0b4c3918f" # Redhat(7.9)
  }

  nic_list {
    subnet_uuid = "b4d9ea47-3b0a-4348-9f66-536ffacf60f4" # TAP_P_BE_DB_MGMT(2)
  }

  nic_list {
    subnet_uuid = "86da3c1c-9944-4048-82e7-6255f221e919" # TAP_P_BE_DB(53)
  }

  disk_list { # disk OS default
    disk_size_mib = 512000
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
