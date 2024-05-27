module "three_tier_app" {
  source              = "./modulethreetierapp/"
  resource_group_name = "mcitthreetiermodule"
  location            = "West Europe"
  admin_username      = var.administrator_login
  admin_password      = var.administrator_login_password
  db_admin_username   = var.db_admin_username
  db_admin_password   = var.db_admin_password
}

output "module_web_vm_public_ip" {
  value = module.three_tier_app.web_vm_public_ip
}
