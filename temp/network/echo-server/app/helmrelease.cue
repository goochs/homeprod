package kube

helmRelease: "echo-server": spec: {
	_appTemplate: true
	values: {
		controllers: "echo-server": {
			strategy: "RollingUpdate"
			containers: app: {
				image: {
					repository: "ghcr.io/mendhak/http-https-echo"
					tag:        35
				}
				env: {
					HTTP_PORT:           8080
					LOG_WITHOUT_NEWLINE: true
					LOG_IGNORE_PATH:     "/healthz"
					PROMETHEUS_ENABLED:  true
				}
				probes: {
					liveness: {
						enabled: true
						custom:  true
						spec: {
							httpGet: {
								path: "/healthz"
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
								path: "/healthz"
								port: 8080
							}
							initialDelaySeconds: 0
							periodSeconds:       10
							timeoutSeconds:      1
							failureThreshold:    3
						}
					}
				}
				securityContext: {
					allowPrivilegeEscalation: false
					readOnlyRootFilesystem:   true
					capabilities: drop: ["ALL"]
				}
				resources: {
					requests: cpu:  "10m"
					limits: memory: "64Mi"
				}
			}
		}
		defaultPodOptions: securityContext: {
			runAsNonRoot: true
			runAsUser:    65534
			runAsGroup:   65534
			seccompProfile: type: "RuntimeDefault"
		}
		service: app: {
			controller: "echo-server"
			ports: http: port: 8080
		}
		serviceMonitor: app: {
			serviceName: "echo-server"
			endpoints: [{
				port:          "http"
				scheme:        "http"
				path:          "/metrics"
				interval:      "1m"
				scrapeTimeout: "10s"
			}]
		}
		ingress: app: {
			className: "external"
			hosts: [{
				host: "{{ .Release.Name }}.${SECRET_DOMAIN}"
				paths: [{
					path: "/"
					service: {
						identifier: "app"
						port:       "http"
					}
				}]
			}]
		}
	}
}