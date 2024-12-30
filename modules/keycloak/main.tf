terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "~> 3.0"
    }
  }
}

provider "keycloak" {
  url      = var.keycloak_url
  client_id = var.keycloak_client_id
  username  = var.keycloak_username
  password  = var.keycloak_password
  realm     = var.keycloak_realm
}

# Create a permanent admin in the master realm
resource "keycloak_user" "master_admin_user" {
  realm_id   = "master"
  username   = var.master_admin_username
  first_name = "Master"
  last_name  = "Admin"
  email      = var.master_admin_email
  enabled    = true
  email_verified = true

  initial_password {
    value     = var.master_admin_password
    temporary = false
  }

  attributes = {
    department = "IT Administration"
    role       = "Super Admin"
  }
}

# Fetch the "admin" role from the master realm
data "keycloak_role" "master_admin_role" {
  realm_id = "master"
  name     = "admin"
}

# Assign the "admin" role to the master admin user
resource "keycloak_user_roles" "master_admin_user_roles" {
  realm_id = "master"
  user_id  = keycloak_user.master_admin_user.id
  role_ids = [data.keycloak_role.master_admin_role.id]
}

# Create a new realm for my_app
resource "keycloak_realm" "realm" {
  realm                            = var.my_app_realm
  display_name                     = var.my_app_realm_name
  enabled                          = true
  access_code_lifespan             = "30m"
  sso_session_idle_timeout         = "30m"
  sso_session_max_lifespan         = "10h"
  offline_session_idle_timeout     = "720h"
  offline_session_max_lifespan_enabled = false
  registration_allowed             = true
  registration_email_as_username   = true
  reset_password_allowed           = true
  verify_email                     = true
  login_with_email_allowed         = true

  internationalization {
    supported_locales = ["it"]
    default_locale     = "it"
  }

  password_policy = "upperCase(1) and length(8) and notUsername(undefined)"

  smtp_server {
    from                = var.my_app_smtp_no_reply_email
    host                = var.smtp_host
    from_display_name   = var.my_app_smtp_no_reply_email_name
    ssl                 = true
    starttls            = false
    auth {
      username = var.smtp_usr
      password = var.smtp_pwd
    }
  }
}

# Create a new user for the my_app realm
resource "keycloak_user" "admin_user" {
  realm_id   = keycloak_realm.realm.id
  username   = "my_app_admin"
  first_name = var.my_app_admin_first_name
  last_name  = var.my_app_admin_last_name
  email      = var.my_app_admin_email
  enabled    = true
  email_verified = true

  initial_password {
    value     = var.my_app_admin_password
    temporary = false
  }
}

# Use a data source to get the existing realm-management client
data "keycloak_openid_client" "realm_management" {
  realm_id  = keycloak_realm.realm.id
  client_id = "realm-management"
}

# Use data sources to get the existing roles
data "keycloak_role" "manage_users" {
  realm_id  = keycloak_realm.realm.id
  client_id = data.keycloak_openid_client.realm_management.id
  name      = "manage-users"
}

data "keycloak_role" "manage_realm" {
  realm_id  = keycloak_realm.realm.id
  client_id = data.keycloak_openid_client.realm_management.id
  name      = "manage-realm"
}

# Assign the existing roles to the my_app_admin user
resource "keycloak_user_roles" "my_app_admin_user_realm_roles" {
  realm_id = keycloak_realm.realm.id
  user_id  = keycloak_user.admin_user.id
  role_ids = [
    data.keycloak_role.manage_users.id,
    data.keycloak_role.manage_realm.id,
  ]
}
