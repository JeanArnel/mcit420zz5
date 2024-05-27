
module "three_tier_app" {
  source              = "./modules/three-tier-app"
  resource_group_name = "mcitthreetiermodule"
  location            = "West Europe"
  admin_username      = administrator_login
  admin_password      = administrator_login_password
  db_admin_username   = db_admin_username
  db_admin_password   = db_admin_password
}

output "web_vm_public_ip" {
  value = module.three_tier_app.web_vm_public_ip
}
