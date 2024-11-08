package kube

#helmRelease & {
	_config: name: "grafana"
	spec: {
		chart: spec: {
			chart:   "grafana"
			version: "8.5.12"
			sourceRef: name: "grafana"
		}
		values: {
			deploymentStrategy: type: "Recreate"
			admin: existingSecret:    "grafana-admin-secret"
			env: {
				GF_EXPLORE_ENABLED: true
				GF_SERVER_ROOT_URL: "https://grafana.${SECRET_DOMAIN}"
			}
			"grafana.ini": analytics: {
				check_for_updates:        false
				check_for_plugin_updates: false
				reporting_enabled:        false
			}
			dashboardProviders: "dashboardproviders.yaml": {
				apiVersion: 1
				providers: [{
					name:            "default"
					orgId:           1
					folder:          ""
					type:            "file"
					disableDeletion: false
					editable:        true
					options: path: "/var/lib/grafana/dashboards/default"
				}, {
					name:            "flux"
					orgId:           1
					folder:          "Flux"
					type:            "file"
					disableDeletion: false
					editable:        true
					options: path: "/var/lib/grafana/dashboards/flux"
				}, {
					name:            "kubernetes"
					orgId:           1
					folder:          "Kubernetes"
					type:            "file"
					disableDeletion: false
					editable:        true
					options: path: "/var/lib/grafana/dashboards/kubernetes"
				}, {
					name:            "nginx"
					orgId:           1
					folder:          "Nginx"
					type:            "file"
					disableDeletion: false
					editable:        true
					options: path: "/var/lib/grafana/dashboards/nginx"
				}]
			}
			datasources: "datasources.yaml": {
				apiVersion: 1
				deleteDatasources: [{name: "Prometheus", orgId: 1}]
				datasources: [{
					name:   "Prometheus"
					type:   "prometheus"
					uid:    "prometheus"
					access: "proxy"
					url:    "http://kube-prometheus-stack-prometheus.monitoring.svc.cluster.local:9090"
					jsonData: prometheusType: "Prometheus"
					isDefault: true
				}]
			}
			dashboards: {
				default: {
					cloudflared: {
						gnetId:   17457 // https://grafana.com/grafana/dashboards/17457?tab=revisions
						revision: 6
						datasource: [{name: "DS_PROMETHEUS", value: "Prometheus"}]
					}
					"cert-manager": {
						url:        "https://raw.githubusercontent.com/monitoring-mixins/website/master/assets/cert-manager/dashboards/cert-manager.json"
						datasource: "Prometheus"
					}
					"node-exporter-full": {
						gnetId:     1860 // https://grafana.com/grafana/dashboards/1860?tab=revisions
						revision:   31
						datasource: "Prometheus"
					}
				}
				flux: {
					"flux-cluster": {
						url:        "https://raw.githubusercontent.com/fluxcd/flux2/main/manifests/monitoring/monitoring-config/dashboards/cluster.json"
						datasource: "Prometheus"
					}
					"flux-control-plane": {
						url:        "https://raw.githubusercontent.com/fluxcd/flux2/main/manifests/monitoring/monitoring-config/dashboards/control-plane.json"
						datasource: "Prometheus"
					}
				}
				kubernetes: {
					"kubernetes-api-server": {
						url:        "https://raw.githubusercontent.com/dotdc/grafana-dashboards-kubernetes/master/dashboards/k8s-system-api-server.json"
						datasource: "Prometheus"
					}
					"kubernetes-coredns": {
						url:        "https://raw.githubusercontent.com/dotdc/grafana-dashboards-kubernetes/master/dashboards/k8s-system-coredns.json"
						datasource: "Prometheus"
					}
					"kubernetes-global": {
						url:        "https://raw.githubusercontent.com/dotdc/grafana-dashboards-kubernetes/master/dashboards/k8s-views-global.json"
						datasource: "Prometheus"
					}
					"kubernetes-namespaces": {
						url:        "https://raw.githubusercontent.com/dotdc/grafana-dashboards-kubernetes/master/dashboards/k8s-views-namespaces.json"
						datasource: "Prometheus"
					}
					"kubernetes-nodes": {
						url:        "https://raw.githubusercontent.com/dotdc/grafana-dashboards-kubernetes/master/dashboards/k8s-views-nodes.json"
						datasource: "Prometheus"
					}
					"kubernetes-pods": {
						url:        "https://raw.githubusercontent.com/dotdc/grafana-dashboards-kubernetes/master/dashboards/k8s-views-pods.json"
						datasource: "Prometheus"
					}
				}
				nginx: {
					nginx: {
						url:        "https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/grafana/dashboards/nginx.json"
						datasource: "Prometheus"
					}
					"nginx-request-handling-performance": {
						url:        "https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/grafana/dashboards/request-handling-performance.json"
						datasource: "Prometheus"
					}
				}
			}
			sidecar: {
				dashboards: {
					enabled:          true
					searchNamespace:  "ALL"
					labelValue:       ""
					label:            "grafana_dashboard"
					folderAnnotation: "grafana_folder"
					provider: {
						disableDelete:             true
						foldersFromFilesStructure: true
					}
				}
				datasources: {
					enabled:         true
					searchNamespace: "ALL"
					labelValue:      ""
				}
			}
			serviceMonitor: enabled: true
			ingress: {
				enabled:          true
				ingressClassName: "internal"
				annotations: {
					"hajimari.io/enable": "true"
					"hajimari.io/icon":   "simple-icons:grafana"
				}
				hosts: ["grafana.${SECRET_DOMAIN}"]
			}
			persistence: {
				enabled:          true
				storageClassName: "longhorn"
			}
			testFramework: enabled: false
		}
	}
}
