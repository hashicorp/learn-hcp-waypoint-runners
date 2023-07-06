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

variable "aws_region" {
  type = string
  default = ""
  env = ["TF_VAR_region"]
}

project = "learn-hcp-runners"

app "dev" {
  build {
    use "docker" {}
    registry {
      use "docker" {
        image = "${var.registry_username}/${var.registry_imagename}"
        tag = "dev"
        local = false
        auth {
          username = var.registry_username
          password = var.registry_password
        }
      }
    }
  }

  deploy {
    use "docker" {
      service_port = 8080
      static_environment = {
        PLATFORM = "docker (dev)"
      }
    }
  }
}

app "ecs" {
  runner {
    profile = "ecs-ecs-runner"
  }

  build {
    use "docker" {}
    registry {
      use "docker" {
        image = "${var.registry_username}/${var.registry_imagename}"
        tag = "ecs"
        local = false
        auth {
          username = var.registry_username
          password = var.registry_password
        }
      }
    }
  }

  deploy {
    use "aws-ecs" {
      service_port = 8080
      static_environment = {
        PLATFORM = "aws-ecs (ecs)"
      }
      region = var.aws_region
      memory = 512
    }
  }
}
