package kube

certificate: "${SECRET_DOMAIN/./-}-staging": {
	apiVersion: "cert-manager.io/v1"
	kind:       "Certificate"
	metadata: name: "${SECRET_DOMAIN/./-}-staging"
	spec: {
		secretName: "${SECRET_DOMAIN/./-}-staging-tls"
		issuerRef: {
			name: "letsencrypt-staging"
			kind: "ClusterIssuer"
		}
		commonName: "${SECRET_DOMAIN}"
		dnsNames: [
			"${SECRET_DOMAIN}",
			"*.${SECRET_DOMAIN}",
		]
	}
}
