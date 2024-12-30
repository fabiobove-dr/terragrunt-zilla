# variables.tf
variable "keycloak_url" {
  description = "The URL of the Keycloak instance."
  type        = string
}

variable "keycloak_client_id" {
  description = "The client ID for authentication."
  type        = string
}

variable "keycloak_username" {
  description = "The username of the admin user."
  type        = string
}

variable "keycloak_password" {
  description = "The password of the admin user."
  type        = string
}

variable "keycloak_realm" {
  description = "The realm to manage."
  type        = string
}

variable "master_admin_username" {
  description = "The master admin username."
  type        = string
}

variable "master_admin_email" {
  description = "The email for the master admin."
  type        = string
}

variable "master_admin_password" {
  description = "The password for the master admin."
  type        = string
}

variable "my_app_realm" {
  description = "The name of the new Keycloak realm."
  type        = string
}

variable "my_app_realm_name" {
  description = "The display name of the my_app realm."
  type        = string
}

variable "my_app_smtp_no_reply_email" {
  description = "The no-reply email for the SMTP server."
  type        = string
}

variable "my_app_smtp_no_reply_email_name" {
  description = "The name of the no-reply email."
  type        = string
}

variable "smtp_host" {
  description = "The host for the SMTP server."
  type        = string
}

variable "smtp_usr" {
  description = "The username for the SMTP server."
  type        = string
}

variable "smtp_pwd" {
  description = "The password for the SMTP server."
  type        = string
}

variable "my_app_admin_first_name" {
  description = "The first name of the my_app admin."
  type        = string
}

variable "my_app_admin_last_name" {
  description = "The last name of the my_app admin."
  type        = string
}

variable "my_app_admin_email" {
  description = "The email of the my_app admin."
  type        = string
}

variable "my_app_admin_password" {
  description = "The password for the my_app admin."
  type        = string
}
