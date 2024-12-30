# outputs.tf
output "master_admin_user_id" {
  value = keycloak_user.master_admin_user.id
}

output "my_app_admin_user_id" {
  value = keycloak_user.admin_user.id
}
