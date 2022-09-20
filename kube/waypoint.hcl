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

project = "kube-flask-example"

runner {
  profile = "kubernetes-KUBE-RUNNER"
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
    use "kubernetes" {
      probe_path = "/"
      service_port = 8080
      static_environment = {
        PLATFORM = "kubernetes"
      }
    }
  }

  release {
    use "kubernetes" {
      load_balancer = true
      port          = 8080
    }
  }
}

