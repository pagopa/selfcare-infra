resource "kubernetes_manifest" "coredns_custom" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "ConfigMap"
    "metadata" = {
      "name"      = "coredns-custom"
      "namespace" = "kube-system"
      "labels" = {
        "addonmanager.kubernetes.io/mode" = "EnsureExists"
        "k8s-app"                         = "kube-dns"
        "kubernetes.io/cluster-service"   = "true"
      }
    }
    "data" = {
      "smtps-pec-aruba-it.server"      = <<EOT
smtps.pec.aruba.it:53 {
  forward . 8.8.8.8
}
EOT
      "asbr-pagopa-arubapec-it.server" = <<EOT
asbr-pagopa.arubapec.it:53 {
  forward . 8.8.8.8
}
EOT
      "eidas-agid-gov-it.server"       = <<EOT
eidas.agid.gov.it:53 {
  forward . 8.8.8.8
}
EOT
    }
  }
}