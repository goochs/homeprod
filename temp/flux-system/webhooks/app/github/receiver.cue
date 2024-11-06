package kube

receiver: "github-receiver": {
	apiVersion: "notification.toolkit.fluxcd.io/v1"
	kind:       "Receiver"
	metadata: name: "github-receiver"
	spec: {
		type: "github"
		events: [
			"ping",
			"push",
		]
		secretRef: name: "github-webhook-token-secret"
		resources: [{
			apiVersion: "source.toolkit.fluxcd.io/v1"
			kind:       "GitRepository"
			name:       "home-kubernetes"
			namespace:  "flux-system"
		}, {
			apiVersion: "kustomize.toolkit.fluxcd.io/v1"
			kind:       "Kustomization"
			name:       "cluster"
			namespace:  "flux-system"
		}, {
			apiVersion: "kustomize.toolkit.fluxcd.io/v1"
			kind:       "Kustomization"
			name:       "cluster-apps"
			namespace:  "flux-system"
		}]
	}
}
