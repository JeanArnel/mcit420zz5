locals {
  modified_clusters = [
    for cluster in var.classworkclusters :
    substr(cluster, 0, length(cluster) - 7)
  ]
}
output "modified_cluster_output"{
value =[for x in local.modified_clusters:x]
}
resource "azurerm_kubernetes_cluster_node_pool" "kube1nodepool" {
 for_each               = local.modified_clusters
 name                   = each.key
 kubernetes_cluster_id  = each.value.id
 vm_size                = "Standard_DS2_v2"
 node_count             = 1

  tags = {
    Environment = "Production"
  }
}

