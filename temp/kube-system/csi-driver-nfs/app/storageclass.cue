package kube

storageClass: "nfs-hoard": {
	apiVersion: "storage.k8s.io/v1"
	kind:       "StorageClass"
	metadata: name: "nfs-hoard"
	provisioner: "nfs.csi.k8s.io"
	parameters: {
		server: "${STORAGE_ADDR}"
		share:  "/mnt/user/hoard"
	}
	reclaimPolicy:     "Delete"
	volumeBindingMode: "Immediate"
	mountOptions: [
		"nfsvers=4.2",
		"nconnect=16",
		"hard",
		"noatime",
	]
}
