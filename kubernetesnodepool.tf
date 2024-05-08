
resource "azurerm_kubernetes_cluster_node_pool" "kube1nodepool" {
 for_each               = azurerm_kubernetes_cluster.batchabcd
 name                   = "${substr(each.key,0,-7)}"
 kubernetes_cluster_id  = each.value.id
 vm_size                = "Standard_DS2_v2"
 node_count             = 1

  tags = {
    Environment = "Production"
  }
}

