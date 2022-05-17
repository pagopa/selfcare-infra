${CADDY_HOST}

@matcher {
	not {
		path /users
	}
}

reverse_proxy @matcher ${SPIDTESTENV_HOST}:8088 {
	header_up Host ${CADDY_HOST}
	header_up X-Forwarded-Host {host}
}