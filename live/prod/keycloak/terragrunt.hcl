terraform {
  source = "../../../modules/keycloak"
  extra_arguments "vars" {
    commands = get_terraform_commands_that_need_vars()
    arguments = [
      "-var-file=terraform.tfvars"
    ]
  }
}