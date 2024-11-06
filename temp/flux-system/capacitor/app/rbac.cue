package kube

clusterRole: capacitor: {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: name: "capacitor"
	rules: [{
		apiGroups: [
			"networking.k8s.io",
			"apps",
			"",
		]
		resources: [
			"pods",
			"pods/log",
			"ingresses",
			"deployments",
			"services",
			"secrets",
			"events",
			"configmaps",
		]
		verbs: [
			"get",
			"watch",
			"list",
		]
	}, {
		apiGroups: [
			"source.toolkit.fluxcd.io",
			"kustomize.toolkit.fluxcd.io",
			"helm.toolkit.fluxcd.io",
			"infra.contrib.fluxcd.io",
		]
		resources: [
			"gitrepositories",
			"ocirepositories",
			"buckets",
			"helmrepositories",
			"helmcharts",
			"kustomizations",
			"helmreleases",
			"terraforms",
		]
		verbs: [
			"get",
			"watch",
			"list",
			"patch",
		]
	}]
}
clusterRoleBinding: capacitor: {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: name: "capacitor"
	subjects: [{
		kind:      "ServiceAccount"
		name:      "capacitor"
		namespace: "flux-system"
	}]
	roleRef: {
		kind:     "ClusterRole"
		name:     "capacitor"
		apiGroup: "rbac.authorization.k8s.io"
	}
}
