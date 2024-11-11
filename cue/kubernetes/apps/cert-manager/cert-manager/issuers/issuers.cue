package kube

#clusterIssuer & {
	apiVersion: "cert-manager.io/v1"
	kind:       "ClusterIssuer"
	metadata: name: "letsencrypt-production"
	spec: acme: {
		server: "https://acme-v02.api.letsencrypt.org/directory"
		email:  "${SECRET_ACME_EMAIL}"
		privateKeySecretRef: name: "letsencrypt-production"
		solvers: [{
			dns01: cloudflare: apiTokenSecretRef: {
				name: "cert-manager-secret"
				key:  "api-token"
			}
			selector: dnsZones: ["${SECRET_DOMAIN}"]
		}]
	}
}
