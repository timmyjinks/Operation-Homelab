terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.6.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "tc" {
  name = "timmijinks/tysonchat:latest"
}

resource "docker_container" "skibidi" {
  image = docker_image.tc.image_id
  name  = "skibidi"
  ports {
    internal = 8080
    external = 8090
  }
}

resource "docker_container" "skibid" {
  image = docker_image.tc.image_id
  name  = "skibid"
  ports {
    internal = 8080
    external = 8091
  }
}

resource "docker_container" "skibi" {
  image = docker_image.tc.image_id
  name  = "skibi"
  ports {
    internal = 8080
    external = 8092
  }
}
