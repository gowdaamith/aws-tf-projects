locals {
  common_tags = {
    project  = var.project_name
    environment= var.environment
    managedby = "terraform"
  }
  public_subnet_tag = {
    tier = "public"
  }
  private_subnet_tag = {
    tier = "private"
  }

}


