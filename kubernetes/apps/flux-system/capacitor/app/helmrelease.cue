package kube

#helmRelease & {
	_config: {
		name: "capacitor"
		appTemplate: port: 9000
	}
	spec: values: {
		controllers: capacitor: containers: app: {
			image: {
				repository: "ghcr.io/gimlet-io/capacitor"
				tag:        "v0.4.8@sha256:c999a42cccc523b91086547f890466d09be4755bf05a52763b0d14594bf60782"
			}
			resources: {
				requests: {
					cpu:    "50m"
					memory: "200Mi"
				}
				limits: memory: "1Gi"
			}
		}
		serviceAccount: {
			create: true
			name:   "capacitor"
		}
	}
}
