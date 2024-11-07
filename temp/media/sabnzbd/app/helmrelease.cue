package kube

helmRelease: sabnzbd: spec: {
	_appTemplate: true
	values: {
		controllers: sabnzbd: {
			annotations: "reloader.stakater.com/auto": "true"
			containers: app: {
				image: {
					repository: "ghcr.io/onedr0p/sabnzbd"
					tag:        "4.3.3@sha256:86c645db93affcbf01cc2bce2560082bfde791009e1506dba68269b9c50bc341"
				}
				env: {
					TZ:                              "${TIMEZONE}"
					SABNZBD__PORT:                   8080
					SABNZBD__HOST_WHITELIST_ENTRIES: "sabnzbd, sabnzbd.media, sabnzbd.media.svc, sabnzbd.media.svc.cluster, sabnzbd.media.svc.cluster.local, sabnzbd.${SECRET_DOMAIN}"
				}
				resources: {
					requests: cpu:  "50m"
					limits: memory: "8Gi"
				}
				securityContext: {
					allowPrivilegeEscalation: false
					readOnlyRootFilesystem:   true
					capabilities: drop: ["ALL"]
				}
				probes: {
					liveness: {
						enabled: true
						custom:  true
						spec: {
							httpGet: {
								path: "/api?mode=version"
								port: 8080
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
								path: "/api?mode=version"
								port: 8080
							}
							initialDelaySeconds: 0
							periodSeconds:       10
							timeoutSeconds:      1
							failureThreshold:    3
						}
					}
				}
			}
		}
		defaultPodOptions: securityContext: {
			runAsNonRoot:        true
			runAsUser:           568
			runAsGroup:          568
			fsGroup:             568
			fsGroupChangePolicy: "OnRootMismatch"
			seccompProfile: type: "RuntimeDefault"
		}
		service: app: {
			controller: "sabnzbd"
			ports: http: port: 8080
		}
		ingress: app: {
			className: "internal"
			hosts: [{
				host: "sabnzbd.${SECRET_DOMAIN}"
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
			config: existingClaim: "sabnzbd-config"
			hoard: {
				type:   "nfs"
				server: "${STORAGE_ADDR}"
				path:   "/mnt/storage/hoard"
				globalMounts: [{path: "/hoard"}]
			}
			tmp: type: "emptyDir"
		}
	}
}
