backend "file" {
	path = "/var/vault"
}

listener "tcp" {
	/*
	 * By default Vault listens on localhost only.
	 * Make sure to enable TLS support otherwise.
	 */
	tls_disable = 1
}