variable "registry_username" {
  type = string
  default = ""
  env = ["REGISTRY_USERNAME"]
}

variable "registry_password" {
  type = string
  sensitive = true
  default = ""
  env = ["REGISTRY_PASSWORD"]
}

variable "registry_imagename" {
  type = string
  default = ""
  env = ["REGISTRY_IMAGENAME"]
}

project = "nomad-flask-example"

runner {
  profile = "nomad-NOMAD-RUNNER"
}

app "docker-flask" {
  build {
    use "docker-pull" {
      image = "${var.registry_username}/${var.registry_imagename}"
      tag   = "1"
      auth {
        username = var.registry_username
        password = var.registry_password
      }
    }
  }

  deploy {
    use "nomad" {
      service_port = 8080
      static_environment = {
        PLATFORM = "nomad"
      }
    }
  }
}