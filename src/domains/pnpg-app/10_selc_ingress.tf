locals {
  cors = {
    origins = join(",", concat(
      [
        "https://${var.api_gateway_url}",
        "https://${local.cdn_fqdn_url}",
      ],
      var.env_short != "p" ? [
        "https://localhost:3000",
        "http://localhost:3000",
        "https://localhost:3001",
        "http://localhost:3001",
        "https://${var.spid_testenv_url}"
      ] : []
    )),
    headers = join(",", [
      // default headers
      "DNT",
      "X-CustomHeader",
      "Keep-Alive",
      "User-Agent",
      "X-Requested-With",
      "If-Modified-Since",
      "Cache-Control",
      "Content-Type",
      "Authorization",
      // application headers
      "x-selc-institutionid"
    ])
  }
}

