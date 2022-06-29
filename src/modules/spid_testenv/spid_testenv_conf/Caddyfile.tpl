${CONTAINER_HOSTNAME}

@matcher {
	not {
		path /users
	}
}

reverse_proxy @matcher localhost:8088 {
	header_up Host ${CONTAINER_HOSTNAME}
	header_up X-Forwarded-Host {host}
}