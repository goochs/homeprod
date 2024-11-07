package kube

helmRelease: plex: spec: {
	_appTemplate: true
	values: {
		defaultPodOptions: {
			nodeSelector: "intel.feature.node.kubernetes.io/gpu": "true"
			securityContext: {
				runAsNonRoot:        true
				runAsUser:           568
				runAsGroup:          568
				fsGroup:             568
				fsGroupChangePolicy: "OnRootMismatch"
				supplementalGroups: [
					44,
					109,
				]
				seccompProfile: type: "RuntimeDefault"
			}
		}
		controllers: plex: {
			type: "statefulset"
			statefulset: volumeClaimTemplates: [{
				name:         "config"
				accessMode:   "ReadWriteOnce"
				size:         "50Gi"
				storageClass: "longhorn"
				globalMounts: [{path: "/config"}]
			}]
			annotations: "reloader.stakater.com/auto": "true"
			containers: app: {
				image: {
					repository: "ghcr.io/onedr0p/plex"
					tag:        "1.41.1.9057-af5eaea7a@sha256:2793002837580e0004ba436ae8aa291573d4631d3571ac6d02960d7fbc7fa94d"
				}
				resources: {
					requests: cpu: "100m"
					limits: {
						memory:               "10Gi"
						"gpu.intel.com/i915": 1
					}
				}
				securityContext: {
					allowPrivilegeEscalation: false
					readOnlyRootFilesystem:   true
					capabilities: drop: ["ALL"]
				}
				env: TZ: "${TIMEZONE}"
				probes: {
					liveness: {
						enabled: true
						custom:  true
						spec: {
							httpGet: {
								path: "/identity"
								port: 32400
							}
							initialDelaySeconds: 0
							periodSeconds:       10
							timeoutSeconds:      1
							failureThreshold:    3
						}
					}
					readiness: {
						enabled: true
						custom:  true
						spec: {
							httpGet: {
								path: "/identity"
								port: 32400
							}
							initialDelaySeconds: 0
							periodSeconds:       10
							timeoutSeconds:      1
							failureThreshold:    3
						}
					}
					startup: {
						enabled: true
						spec: {
							failureThreshold: 30
							periodSeconds:    10
						}
					}
				}
			}
		}
		service: app: {
			controller:            "plex"
			type:                  "LoadBalancer"
			externalTrafficPolicy: "Cluster"
			annotations: "io.cilium/lb-ipam-ips": "10.20.30.45"
			ports: http: port: 32400
		}
		ingress: app: {
			className: "external"
			hosts: [{
				host: "plex.${SECRET_DOMAIN}"
				paths: [{
					path: "/"
					service: {
						identifier: "app"
						port:       "http"
					}
				}]
			}]
		}
		persistence: {
			hoard: {
				type:   "nfs"
				server: "${STORAGE_ADDR}"
				path:   "/mnt/storage/hoard"
				globalMounts: [{path: "/hoard"}]
			}
			transcode: {
				type: "emptyDir"
				globalMounts: [{path: "/transcode"}]
			}
		}
	}
}
