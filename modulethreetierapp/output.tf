output "module_web_vm_public_ip" {
  description = "The public IP address of the web VM"
  value       = azurerm_linux_virtual_machine.web_vm.public_ip_address
}
