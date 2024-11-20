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
				GF_DATE_FORMATS_USE_BROWSER_LOCALE:  true
				GF_EXPLORE_ENABLED:                  true
				GF_SECURITY_ANGULAR_SUPPORT_ENABLED: true

				GF_SERVER_ROOT_URL: "https://grafana.goochs.us"
			}
			"grafana.ini": {
				analytics: {
					check_for_updates:        false
					check_for_plugin_updates: false
					reporting_enabled:        false
				}
				news: news_feed_enabled: false
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
				}]
			}
			datasources: "datasources.yaml": {
				apiVersion: 1
				deleteDatasources: [{name: "Prometheus", orgId: 1}, {name: "Alertmanager", orgId: 1}]
				datasources: [{
					name:   "Prometheus"
					type:   "prometheus"
					uid:    "prometheus"
					access: "proxy"
					url:    "http://kube-prometheus-stack-prometheus.observability.svc.cluster.local:9090"
					jsonData: timeInterval: "1m"
					isDefault: true
				},
					{
						name:   "Alertmanager"
						type:   "alertmanager"
						uid:    "alertmanager"
						access: "proxy"
						url:    "http://alertmanager-operated.observability.svc.cluster.local:9093"
						jsonData: implementation: "prometheus"
					},
				]
			}
			dashboards: default: {
				"cert-manager": {
					url:        "https://raw.githubusercontent.com/monitoring-mixins/website/master/assets/cert-manager/dashboards/cert-manager.json"
					datasource: "Prometheus"
				}
				"external-secrets": {
					url:        "https://raw.githubusercontent.com/external-secrets/external-secrets/main/docs/snippets/dashboard.json"
					datasource: "Prometheus"
				}
				"flux-cluster": {
					url:        "https://raw.githubusercontent.com/fluxcd/flux2-monitoring-example/main/monitoring/configs/dashboards/cluster.json"
					datasource: "Prometheus"
				}
				"flux-control-plane": {
					url:        "https://raw.githubusercontent.com/fluxcd/flux2-monitoring-example/main/monitoring/configs/dashboards/control-plane.json"
					datasource: "Prometheus"
				}
				"kubernetes-api-server": {
					gnetId:     15761
					revision:   18
					datasource: "Prometheus"
				}
				"kubernetes-coredns": {
					gnetId:     15762
					revision:   18
					datasource: "Prometheus"
				}
				"kubernetes-global": {
					gnetId:     15757
					revision:   42
					datasource: "Prometheus"
				}
				"kubernetes-namespaces": {
					gnetId:     15758
					revision:   40
					datasource: "Prometheus"
				}
				"kubernetes-nodes": {
					gnetId:     15759
					revision:   32
					datasource: "Prometheus"
				}
				"kubernetes-pods": {
					gnetId:     15760
					revision:   32
					datasource: "Prometheus"
				}
				"kubernetes-volumes": {
					gnetId:     11454
					revision:   14
					datasource: "Prometheus"
				}
				nginx: {
					url:        "https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/grafana/dashboards/nginx.json"
					datasource: "Prometheus"
				}
				"nginx-request-handling-performance": {
					url:        "https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/grafana/dashboards/request-handling-performance.json"
					datasource: "Prometheus"
				}
				"node-exporter-full": {
					gnetId:     1860
					revision:   37
					datasource: "Prometheus"
				}
				"node-feature-discovery": {
					url:        "https://raw.githubusercontent.com/kubernetes-sigs/node-feature-discovery/master/examples/grafana-dashboard.json"
					datasource: "Prometheus"
				}
				prometheus: {
					gnetId:     19105
					revision:   5
					datasource: "Prometheus"
				}
			}
			sidecar: {
				dashboards: {
					enabled:          true
					searchNamespace:  "ALL"
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
				hosts: ["grafana.goochs.us"]
			}
			persistence: enabled:   false
			testFramework: enabled: false
		}
	}
}