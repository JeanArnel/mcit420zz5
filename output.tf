output "company_name_output"{
    value=var.company_name
}
output "years_of_establishment_output"{
    value = var.years_of_establishment
}

output "ifelsecheck_output"{
    value = var.ifelsecheck
}
output "print"{
    value = local.servicename
}
output "secondprint"{
    value = local.forum
}

output "lengthsa"{
    value=local.lengthsa
}
output "lengthforum"{
    value=local.lengthforum
}

output "countNumber"{
    value=var.countNumber
}
output "wintersportslist"{
    value=[for sport in local.winterlistOfSports:sport]
}
/*
for 1st element in -->inside the list variable winterlistOfSports--->"icehockey"1st element
for 2nd element in -->inside the list variable winterlistOfSports--->"snowboarding" 2nd element
for 3rd element in -->inside the list variable winterlistOfSports--->"iceskating" 3rd element
*/
output "summersportslist"{
    value=[for summersport in var.summersports:summersport ]
}
output "sumofthreenumbers"{
    value=sum([for numberoutput in local.total_output: tonumber(numberoutput)])
}
//========================================Kubernetes cluster creation start========================================
/*output "id" {
  value = [
    for cluster in azurerm_kubernetes_cluster.batchabcd: cluster.id
  ]
}

output "kube_config" {
  sensitive = true
  value = [ 
    for cluster in azurerm_kubernetes_cluster.batchabcd: cluster.kube_config_raw
  ]
}

output "client_key" {
  sensitive = true
  value = [
    for cluster in azurerm_kubernetes_cluster.batchabcd: cluster.kube_config.0.client_key
  ]
}

output "client_certificate" {
  sensitive = true
  value = [
    for cluster in azurerm_kubernetes_cluster.batchabcd: cluster.kube_config.0.client_certificate
  ]
}

output "cluster_ca_certificate" {
  sensitive = true
  value = [
    for cluster in azurerm_kubernetes_cluster.batchabcd: cluster.kube_config.0.cluster_ca_certificate
  ]
}

output "host" {
  sensitive = true
  value = [
    for cluster in azurerm_kubernetes_cluster.batchabcd: cluster.kube_config.0.host
  ]
}
*/
//========================================Kubernetes cluster Output end========================================

output "exampleoutput" {
  value =    { for character in local.characters: # Convert character list to a set
      character => local.enemies_destroyed
  }

}

output "character_enemy_output" {
  value = local.character_enemy_map
}
output "character_mapping"{
value={for index,character in local.characters: # Convert character list to a set
      character => local.enemies_destroyed[index]
}
}

output "flattened_list_result" {
  value = local.flattened_list
}

output "flattened_map_result" {
  value = local.flattened_map
}

output "simple_flattened_list_result" {
  value = local.simple_local_flattened_list
}
output "simple_nested_list_result_output" {
  value = var.simple_nested_list
}
