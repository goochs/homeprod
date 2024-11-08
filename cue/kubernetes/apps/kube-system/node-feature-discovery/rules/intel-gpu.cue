package kube

#untemplated & {
	apiVersion: "nfd.k8s-sigs.io/v1alpha1"
	kind:       "NodeFeatureRule"
	metadata: name: "intel-gpu-device"
	spec: rules: [{
		name: "intel.gpu"
		labels: "intel.feature.node.kubernetes.io/gpu": "true"
		matchFeatures: [{
			feature: "pci.device"
			matchExpressions: {
				class: {
					op: "In"
					value: [
						"0300",
						"0380",
						"a7a0",
					]
				}
				vendor: {
					op: "In"
					value: ["8086"]
				}
			}
		}]
	}]
}
