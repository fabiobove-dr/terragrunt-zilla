output "master_admin_user_id" {
  value = keycloak_user.master_admin_user
  sensitive =  true
}

output "my_app_admin_user_id" {
  value = keycloak_user.admin_user.id
  sensitive =  true

}

output "my_app_realm_id" {
  value = keycloak_realm.realm.id
  sensitive =  true
}