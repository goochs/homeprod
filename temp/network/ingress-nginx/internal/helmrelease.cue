package kube

import yaml656e63 "encoding/yaml"

helmRelease: "ingress-nginx-internal": spec: {
	chart: spec: {
		chart:   "ingress-nginx"
		version: "4.11.3"
		sourceRef: name: "ingress-nginx"
	}
	values: {
		fullnameOverride: "ingress-nginx-internal"
		controller: {
			replicaCount: 1
			service: {
				annotations: "io.cilium/lb-ipam-ips": "10.20.30.41"
				externalTrafficPolicy: "Cluster"
			}
			ingressClassResource: {
				name:            "internal"
				default:         true
				controllerValue: "k8s.io/internal"
			}
			admissionWebhooks: objectSelector: matchExpressions: [{
				key:      "ingress-class"
				operator: "In"
				values: ["internal"]
			}]
			config: {
				"client-body-buffer-size": "100M"
				"client-body-timeout":     120
				"client-header-timeout":   120
				"enable-brotli":           "true"
				"enable-real-ip":          "true"
				"hsts-max-age":            31449600
				"keep-alive-requests":     10000
				"keep-alive":              120
				"log-format-escape-json":  "true"
				"log-format-upstream":     yaml656e63.Marshal(_cue_log_format_upstream)
				let _cue_log_format_upstream = {
					time: "$time_iso8601", remote_addr: "$proxy_protocol_addr", x_forwarded_for: "$proxy_add_x_forwarded_for", request_id: "$req_id", remote_user: "$remote_user", bytes_sent: "$bytes_sent", request_time: "$request_time", status: "$status", vhost: "$host", request_proto: "$server_protocol", path: "$uri", request_query: "$args", request_length: "$request_length", duration: "$request_time", method: "$request_method", http_referrer: "$http_referer", http_user_agent: "$http_user_agent"
				}
				"proxy-body-size":   0
				"proxy-buffer-size": "16k"
				"ssl-protocols":     "TLSv1.3 TLSv1.2"
			}
			metrics: {
				enabled: true
				serviceMonitor: {
					enabled: true
					namespaceSelector: any: true
				}
			}
			extraArgs: "default-ssl-certificate": "network/${SECRET_DOMAIN/./-}-production-tls"
			topologySpreadConstraints: [{
				maxSkew:           1
				topologyKey:       "kubernetes.io/hostname"
				whenUnsatisfiable: "DoNotSchedule"
				labelSelector: matchLabels: {
					"app.kubernetes.io/name":      "ingress-nginx"
					"app.kubernetes.io/instance":  "ingress-nginx-internal"
					"app.kubernetes.io/component": "controller"
				}
			}]
			resources: {
				requests: cpu:  "100m"
				limits: memory: "500Mi"
			}
		}
		defaultBackend: enabled: false
	}
}
