package kube

ingress: "flux-webhook": {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: name: "flux-webhook"
	spec: {
		ingressClassName: "external"
		rules: [{
			host: "flux-webhook.${SECRET_DOMAIN}"
			http: paths: [{
				path:     "/hook/"
				pathType: "Prefix"
				backend: service: {
					name: "webhook-receiver"
					port: number: 80
				}
			}]
		}]
	}
}
