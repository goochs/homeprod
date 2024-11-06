package kube

persistentVolume: "hoard-nfs": {
	apiVersion: "v1"
	kind:       "PersistentVolume"
	metadata: name: "hoard-nfs"
	spec: {
		capacity: storage: "22T"
		accessModes: ["ReadWriteMany"]
		persistentVolumeReclaimPolicy: "Delete"
		mountOptions: [
			"nfsvers=4.2",
			"nconnect=16",
			"hard",
			"noatime",
		]
		csi: {
			driver:       "nfs.csi.k8s.io"
			readOnly:     false
			volumeHandle: "media-nfs-storage-hoard"
			volumeAttributes: {
				server: "${STORAGE_ADDR}"
				share:  "/mnt/storage/hoard"
			}
		}
	}
}
persistentVolumeClaim: "hoard-nfs": {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
	metadata: {
		name:      "hoard-nfs"
		namespace: "media"
	}
	spec: {
		accessModes: ["ReadWriteMany"]
		volumeName:       "hoard-nfs"
		storageClassName: ""
		resources: requests: storage: "21T"
	}
}
