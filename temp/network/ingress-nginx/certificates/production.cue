package kube

certificate: "${SECRET_DOMAIN/./-}-production": {
	apiVersion: "cert-manager.io/v1"
	kind:       "Certificate"
	metadata: name: "${SECRET_DOMAIN/./-}-production"
	spec: {
		secretName: "${SECRET_DOMAIN/./-}-production-tls"
		issuerRef: {
			name: "letsencrypt-production"
			kind: "ClusterIssuer"
		}
		commonName: "${SECRET_DOMAIN}"
		dnsNames: [
			"${SECRET_DOMAIN}",
			"*.${SECRET_DOMAIN}",
		]
	}
}
