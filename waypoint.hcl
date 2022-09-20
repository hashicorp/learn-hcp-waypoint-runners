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

project = "docker-flask-example"

app "docker-flask" {
  build {
    use "docker" {
      context = "python-app"
      dockerfile = "python-app/Dockerfile"
    }
    registry {
      use "docker" {
        image = "${var.registry_username}/${var.registry_imagename}"
        tag = "1"
        local = false
        auth {
          username = var.registry_username
          password = var.registry_password
        }
      }
    }
  }
  deploy {
    use docker {}
  }
}
