resource "kubernetes_namespace" "health" {
  metadata {
    name = "health"
  }
}

resource "kubernetes_deployment" "health" {
  metadata {
    name      = "health"
    namespace = kubernetes_namespace.health.metadata[0].name
    labels = {
      app = "health"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "health"
      }
    }

    template {
      metadata {
        labels = {
          app = "health"
        }
      }

      spec {
        container {
          image = "nginx:1.21.4"
          name  = "health"
          liveness_probe {
            http_get {
              path = "/index.html"
              port = 80
            }
            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "health" {
  metadata {
    name      = "health"
    namespace = kubernetes_namespace.health.metadata[0].name
    labels = {
      app = "health"
    }
  }
  spec {
    selector = {
      app = "health"
    }
    port {
      port        = var.default_service_port
      target_port = 80
    }
    type = "ClusterIP"
  }
}
