package kube

persistentVolumeClaim: "prowlarr-config": {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
	metadata: name: "prowlarr-config"
	spec: {
		accessModes: ["ReadWriteOnce"]
		resources: requests: storage: "5Gi"
		storageClassName: "longhorn"
	}
}
