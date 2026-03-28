{
  "annotations": {
    "list": [
      {
        "builtIn": 1,
        "datasource": {
          "type": "grafana",
          "uid": "-- Grafana --"
        },
        "enable": true,
        "hide": true,
        "iconColor": "rgba(0, 211, 255, 1)",
        "name": "Annotations & Alerts",
        "type": "dashboard"
      }
    ]
  },
  "editable": true,
  "fiscalYearStartMonth": 0,
  "graphTooltip": 0,
  "id": null,
  "links": [],
  "panels": [
    {
      "collapsed": false,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 0
      },
      "id": 3,
      "panels": [],
      "title": "Panoramica",
      "type": "row"
    },
    {
      "datasource": {
        "type": "grafana-azure-monitor-datasource",
        "uid": "${datasource_uid}"
      },
      "fieldConfig": {
        "defaults": {
          "mappings": [],
          "thresholds": {
            "mode": "percentage",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "orange",
                "value": 70
              },
              {
                "color": "red",
                "value": 85
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 1
      },
      "id": 12,
      "options": {
        "minVizHeight": 75,
        "minVizWidth": 75,
        "orientation": "auto",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "showThresholdLabels": false,
        "showThresholdMarkers": true,
        "sizing": "auto"
      },
      "pluginVersion": "12.2.0",
      "targets": [
        {
          "azureMonitor": {
            "aggregation": "Total",
            "allowedTimeGrainsMs": [
              60000,
              300000,
              900000,
              1800000,
              3600000,
              21600000,
              43200000,
              86400000
            ],
            "customNamespace": "Microsoft.EventHub/Namespaces",
            "dimensionFilters": [],
            "metricName": "ServerErrors",
            "metricNamespace": "microsoft.eventhub/namespaces",
            "region": "westeurope",
            "resources": [
              {
                "metricNamespace": "Microsoft.EventHub/namespaces",
                "region": "westeurope",
                "resourceGroup": "${prefix}-event-rg",
                "resourceName": "${prefix}-eventhub-ns",
                "subscription": "${subscription_id}"
              }
            ],
            "timeGrain": "auto"
          },
          "queryType": "Azure Monitor",
          "refId": "A",
          "subscription": "${subscription_id}",
          "datasource": {
            "type": "grafana-azure-monitor-datasource",
            "uid": "${datasource_uid}"
          }
        }
      ],
      "title": "Presenza errori dei servizi",
      "type": "gauge"
    },
    {
      "datasource": {
        "type": "grafana-azure-monitor-datasource",
        "uid": "${datasource_uid}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 25,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "showValues": false,
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "normal"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 1
      },
      "id": 2,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "hidden",
          "placement": "right",
          "showLegend": false
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "single",
          "sort": "none"
        }
      },
      "pluginVersion": "12.2.0",
      "targets": [
        {
          "azureMonitor": {
            "aggregation": "Average",
            "allowedTimeGrainsMs": [
              60000,
              300000,
              900000,
              1800000,
              3600000,
              21600000,
              43200000,
              86400000
            ],
            "dimensionFilters": [
              {
                "dimension": "EntityName",
                "filters": [],
                "operator": "eq"
              }
            ],
            "metricName": "IncomingMessages",
            "metricNamespace": "microsoft.eventhub/namespaces",
            "region": "westeurope",
            "resources": [
              {
                "metricNamespace": "Microsoft.EventHub/namespaces",
                "region": "westeurope",
                "resourceGroup": "${prefix}-event-rg",
                "resourceName": "${prefix}-eventhub-ns",
                "subscription": "${subscription_id}"
              }
            ],
            "timeGrain": "PT30M"
          },
          "queryType": "Azure Monitor",
          "refId": "A",
          "subscription": "${subscription_id}",
          "datasource": {
            "type": "grafana-azure-monitor-datasource",
            "uid": "${datasource_uid}"
          }
        }
      ],
      "title": "Andamento messaggi su coda",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "grafana-azure-monitor-datasource",
        "uid": "${datasource_uid}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "continuous-GrYlRd"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 20,
            "gradientMode": "scheme",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "smooth",
            "lineWidth": 3,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "showValues": false,
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 6,
        "y": 9
      },
      "id": 11,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "hidden",
          "placement": "right",
          "showLegend": false
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "single",
          "sort": "none"
        }
      },
      "pluginVersion": "12.2.0",
      "targets": [
        {
          "azureMonitor": {
            "aggregation": "Average",
            "allowedTimeGrainsMs": [
              60000,
              300000,
              900000,
              1800000,
              3600000,
              21600000,
              43200000,
              86400000
            ],
            "customNamespace": "Microsoft.EventHub/Namespaces",
            "dimensionFilters": [
              {
                "dimension": "EntityName",
                "filters": [
                  "-NamespaceOnlyMetric-"
                ],
                "operator": "ne"
              }
            ],
            "metricName": "IncomingRequests",
            "metricNamespace": "microsoft.eventhub/namespaces",
            "region": "westeurope",
            "resources": [
              {
                "metricNamespace": "Microsoft.EventHub/namespaces",
                "region": "westeurope",
                "resourceGroup": "${prefix}-event-rg",
                "resourceName": "${prefix}-eventhub-ns",
                "subscription": "${subscription_id}"
              }
            ],
            "timeGrain": "PT1H"
          },
          "queryType": "Azure Monitor",
          "refId": "A",
          "subscription": "${subscription_id}",
          "datasource": {
            "type": "grafana-azure-monitor-datasource",
            "uid": "${datasource_uid}"
          }
        }
      ],
      "title": "Volume chiamate su coda",
      "type": "timeseries"
    },
    {
      "collapsed": false,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 17
      },
      "id": 13,
      "panels": [],
      "title": "Cruscotto Tech",
      "type": "row"
    },
    {
      "datasource": {
        "type": "grafana-azure-monitor-datasource",
        "uid": "${datasource_uid}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 0,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "showValues": false,
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 18
      },
      "id": 20,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "single",
          "sort": "none"
        }
      },
      "pluginVersion": "12.2.0",
      "targets": [
        {
          "azureLogAnalytics": {
            "dashboardTime": true,
            "mode": "raw",
            "query": "// Failed requests per hour \r\n// Count of requests to which Application Gateway responded with an error. \r\n// To create an alert for this query, click '+ New alert rule'\r\nAzureDiagnostics\r\n| where ResourceType == \"APPLICATIONGATEWAYS\"\r\n    and OperationName == \"ApplicationGatewayAccess\"\r\n    and (httpStatus_d < 300 or httpStatus_d == 404)\r\n| summarize n_success = toreal(count()) by bin(TimeGenerated, 5m)\r\n| join kind=inner (\r\n    AzureDiagnostics\r\n    | where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\"\r\n    | summarize n_total = toreal(count()) by bin(TimeGenerated, 5m))\r\n    on TimeGenerated\r\n| project TimeGenerated, availability=(n_success / n_total) * 100, watermark=99.9\r\n| render timechart\r\n\r\n",
            "resources": [
              "/subscriptions/${subscription_id}/resourceGroups/${prefix}-vnet-rg/providers/Microsoft.Network/applicationGateways/${prefix}-app-gw"
            ],
            "resultFormat": "logs",
            "timeColumn": "TimeGenerated"
          },
          "azureMonitor": {
            "allowedTimeGrainsMs": [],
            "timeGrain": "auto"
          },
          "queryType": "Azure Log Analytics",
          "refId": "A",
          "datasource": {
            "type": "grafana-azure-monitor-datasource",
            "uid": "${datasource_uid}"
          }
        }
      ],
      "title": "Disponibilit\u00e0 Sistema",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "grafana-azure-monitor-datasource",
        "uid": "${datasource_uid}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "continuous-GrYlRd"
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 18
      },
      "id": 15,
      "options": {
        "displayMode": "lcd",
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": false
        },
        "maxVizHeight": 300,
        "minVizHeight": 16,
        "minVizWidth": 8,
        "namePlacement": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "showUnfilled": true,
        "sizing": "auto",
        "valueMode": "color"
      },
      "pluginVersion": "12.2.0",
      "targets": [
        {
          "azureMonitor": {
            "aggregation": "Total",
            "allowedTimeGrainsMs": [
              60000,
              300000,
              900000,
              1800000,
              3600000,
              21600000,
              43200000,
              86400000
            ],
            "customNamespace": "Microsoft.Network/applicationgateways",
            "dimensionFilters": [],
            "metricName": "TotalRequests",
            "metricNamespace": "microsoft.network/applicationgateways",
            "region": "westeurope",
            "resources": [
              {
                "metricNamespace": "Microsoft.Network/applicationGateways",
                "region": "westeurope",
                "resourceGroup": "${prefix}-vnet-rg",
                "resourceName": "${prefix}-app-gw",
                "subscription": "${subscription_id}"
              }
            ],
            "timeGrain": "PT1H"
          },
          "queryType": "Azure Monitor",
          "refId": "A",
          "subscription": "${subscription_id}",
          "datasource": {
            "type": "grafana-azure-monitor-datasource",
            "uid": "${datasource_uid}"
          }
        },
        {
          "azureMonitor": {
            "aggregation": "Total",
            "allowedTimeGrainsMs": [
              60000,
              300000,
              900000,
              1800000,
              3600000,
              21600000,
              43200000,
              86400000
            ],
            "dimensionFilters": [],
            "metricName": "FailedRequests",
            "metricNamespace": "microsoft.network/applicationgateways",
            "region": "westeurope",
            "resources": [
              {
                "metricNamespace": "Microsoft.Network/applicationGateways",
                "region": "westeurope",
                "resourceGroup": "${prefix}-vnet-rg",
                "resourceName": "${prefix}-app-gw",
                "subscription": "${subscription_id}"
              }
            ],
            "timeGrain": "PT1H"
          },
          "datasource": {
            "type": "grafana-azure-monitor-datasource",
            "uid": "${datasource_uid}"
          },
          "hide": false,
          "queryType": "Azure Monitor",
          "refId": "B",
          "subscription": "${subscription_id}"
        }
      ],
      "title": "Volume di Traffico e Analisi degli Errori",
      "type": "bargauge"
    },
    {
      "datasource": {
        "type": "grafana-azure-monitor-datasource",
        "uid": "${datasource_uid}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 25,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "showValues": false,
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "normal"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 26
      },
      "id": 17,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "hidden",
          "placement": "right",
          "showLegend": false
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "single",
          "sort": "none"
        }
      },
      "pluginVersion": "12.2.0",
      "targets": [
        {
          "azureLogAnalytics": {
            "dashboardTime": true,
            "mode": "raw",
            "query": "AzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\"\n    and OperationName == \"ApplicationGatewayAccess\"\n    and (httpStatus_d < 300 or httpStatus_d == 404)\n    and requestUri_s != \"dummy\"\n    and requestUri_s != \"/spid/v1/metadata\"\n| summarize percentiles(timeTaken_d, 99) by bin(TimeGenerated, 5m), watermark=1\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")\n\n",
            "resources": [
              "/subscriptions/${subscription_id}/resourceGroups/${prefix}-vnet-rg/providers/Microsoft.Network/applicationGateways/${prefix}-app-gw"
            ],
            "resultFormat": "logs",
            "timeColumn": "TimeGenerated"
          },
          "azureMonitor": {
            "allowedTimeGrainsMs": [],
            "timeGrain": "auto"
          },
          "queryType": "Azure Log Analytics",
          "refId": "A",
          "datasource": {
            "type": "grafana-azure-monitor-datasource",
            "uid": "${datasource_uid}"
          }
        }
      ],
      "title": "Tempo medio di risposta %",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "grafana-azure-monitor-datasource",
        "uid": "${datasource_uid}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 0,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "showValues": false,
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 26
      },
      "id": 16,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "single",
          "sort": "none"
        }
      },
      "pluginVersion": "12.2.0",
      "targets": [
        {
          "azureLogAnalytics": {
            "dashboardTime": true,
            "mode": "raw",
            "query": "// Failed requests per hour \n// Count of requests to which Application Gateway responded with an error. \n// To create an alert for this query, click '+ New alert rule'\nlet api_httpStatus = datatable (name: int) [\n    200, 201, 202, 204, 300, 301, 302, 303, 304, 307,\n    401, 403, 404, 409\n];\nlet success=AzureDiagnostics\n    | where ResourceProvider == \"MICROSOFT.NETWORK\" and Category == \"ApplicationGatewayAccessLog\"\n    | where (requestUri_s != \"dummy\" and requestUri_s != \"/spid/v1/metadata\")\n    | where httpStatus_d in (api_httpStatus)\n    | summarize count() by HTTPStatus=\" Success\", bin(TimeGenerated, 5m);\nlet fail=AzureDiagnostics\n    | where ResourceProvider == \"MICROSOFT.NETWORK\" and Category == \"ApplicationGatewayAccessLog\"\n    | where (requestUri_s != \"dummy\" and requestUri_s != \"/spid/v1/metadata\")\n    | where httpStatus_d !in (api_httpStatus)\n    | extend HTTPStatus = case(\n                              httpStatus_d between (200 .. 299),\n                              \"2XX\",\n                              httpStatus_d between (300 .. 399),\n                              \"3XX\",\n                              httpStatus_d between (400 .. 499),\n                              \"4XX\",\n                              \"5XX\"\n                          )\n    | summarize count() by HTTPStatus, bin(TimeGenerated, 5m);\nunion success, fail\n| render areachart\n\n",
            "resources": [
              "/subscriptions/${subscription_id}/resourceGroups/${prefix}-vnet-rg/providers/Microsoft.Network/applicationGateways/${prefix}-app-gw"
            ],
            "resultFormat": "logs",
            "timeColumn": "TimeGenerated"
          },
          "azureMonitor": {
            "allowedTimeGrainsMs": [],
            "timeGrain": "auto"
          },
          "queryType": "Azure Log Analytics",
          "refId": "A",
          "datasource": {
            "type": "grafana-azure-monitor-datasource",
            "uid": "${datasource_uid}"
          }
        }
      ],
      "title": "Risposte di successo del Sistema",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "grafana-azure-monitor-datasource",
        "uid": "${datasource_uid}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "continuous-GrYlRd"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 20,
            "gradientMode": "scheme",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "smooth",
            "lineWidth": 3,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "showValues": false,
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 34
      },
      "id": 19,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "hidden",
          "placement": "right",
          "showLegend": false
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "single",
          "sort": "none"
        }
      },
      "pluginVersion": "12.2.0",
      "targets": [
        {
          "azureMonitor": {
            "aggregation": "Total",
            "allowedTimeGrainsMs": [
              60000,
              300000,
              900000,
              1800000,
              3600000,
              21600000,
              43200000,
              86400000
            ],
            "customNamespace": "microsoft.documentdb/databaseaccounts",
            "dimensionFilters": [
              {
                "dimension": "Status",
                "filters": [
                  "Fail"
                ],
                "operator": "eq"
              }
            ],
            "metricName": "MongoRequests",
            "metricNamespace": "microsoft.documentdb/databaseaccounts",
            "region": "westeurope",
            "resources": [
              {
                "metricNamespace": "Microsoft.DocumentDB/databaseAccounts",
                "region": "westeurope",
                "resourceGroup": "${prefix}-cosmosdb-mongodb-rg",
                "resourceName": "${prefix}-cosmosdb-mongodb-account",
                "subscription": "${subscription_id}"
              }
            ],
            "timeGrain": "auto"
          },
          "queryType": "Azure Monitor",
          "refId": "A",
          "subscription": "${subscription_id}",
          "datasource": {
            "type": "grafana-azure-monitor-datasource",
            "uid": "${datasource_uid}"
          }
        }
      ],
      "title": "DB Cosmos Mongo Risposte fallite dal client",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "grafana-azure-monitor-datasource",
        "uid": "${datasource_uid}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 0,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "showValues": false,
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 34
      },
      "id": 18,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "hidden",
          "placement": "right",
          "showLegend": false
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "single",
          "sort": "none"
        }
      },
      "pluginVersion": "12.2.0",
      "targets": [
        {
          "azureMonitor": {
            "aggregation": "Count",
            "allowedTimeGrainsMs": [
              60000,
              300000,
              900000,
              1800000,
              3600000,
              21600000,
              43200000,
              86400000
            ],
            "customNamespace": "Microsoft.DocumentDB/DatabaseAccounts",
            "dimensionFilters": [],
            "metricName": "MongoRequests",
            "metricNamespace": "microsoft.documentdb/databaseaccounts",
            "region": "westeurope",
            "resources": [
              {
                "metricNamespace": "Microsoft.DocumentDB/databaseAccounts",
                "region": "westeurope",
                "resourceGroup": "${prefix}-cosmosdb-mongodb-rg",
                "resourceName": "${prefix}-cosmosdb-mongodb-account",
                "subscription": "${subscription_id}"
              }
            ],
            "timeGrain": "auto"
          },
          "queryType": "Azure Monitor",
          "refId": "A",
          "subscription": "${subscription_id}",
          "datasource": {
            "type": "grafana-azure-monitor-datasource",
            "uid": "${datasource_uid}"
          }
        }
      ],
      "title": "DB Cosmos Mongo Richieste Client",
      "type": "timeseries"
    },
    {
      "collapsed": false,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 42
      },
      "id": 7,
      "panels": [],
      "title": "Service Management - Tech",
      "type": "row"
    },
    {
      "datasource": {
        "type": "grafana-azure-monitor-datasource",
        "uid": "${datasource_uid}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 0,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "smooth",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "showValues": false,
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 43
      },
      "id": 9,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "single",
          "sort": "none"
        }
      },
      "pluginVersion": "12.2.0",
      "targets": [
        {
          "azureLogAnalytics": {
            "dashboardTime": true,
            "mode": "raw",
            "query": "",
            "resultFormat": "logs"
          },
          "azureMonitor": {
            "aggregation": "Total",
            "allowedTimeGrainsMs": [
              60000,
              300000,
              900000,
              1800000,
              3600000,
              21600000,
              43200000,
              86400000
            ],
            "customNamespace": "Azure.ApplicationInsights",
            "dimensionFilters": [],
            "metricName": "Onboardings Successes",
            "metricNamespace": "microsoft.insights/components",
            "region": "westeurope",
            "resources": [
              {
                "metricNamespace": "Microsoft.Insights/components",
                "region": "westeurope",
                "resourceGroup": "${prefix}-monitor-rg",
                "resourceName": "${prefix}-appinsights",
                "subscription": "${subscription_id}"
              }
            ],
            "timeGrain": "PT30M"
          },
          "azureTraces": {
            "resultFormat": "table",
            "traceTypes": [
              "availabilityResults",
              "dependencies",
              "customEvents",
              "exceptions",
              "pageViews",
              "requests",
              "traces"
            ]
          },
          "hide": false,
          "queryType": "Azure Monitor",
          "refId": "A",
          "subscription": "${subscription_id}",
          "subscriptions": [
            "${subscription_id}"
          ],
          "datasource": {
            "type": "grafana-azure-monitor-datasource",
            "uid": "${datasource_uid}"
          }
        },
        {
          "azureMonitor": {
            "aggregation": "Total",
            "allowedTimeGrainsMs": [
              60000,
              300000,
              900000,
              1800000,
              3600000,
              21600000,
              43200000,
              86400000
            ],
            "customNamespace": "Azure.ApplicationInsights",
            "dimensionFilters": [],
            "metricName": "Onboardings Failures",
            "metricNamespace": "microsoft.insights/components",
            "region": "westeurope",
            "resources": [
              {
                "metricNamespace": "Microsoft.Insights/components",
                "region": "westeurope",
                "resourceGroup": "${prefix}-monitor-rg",
                "resourceName": "${prefix}-appinsights",
                "subscription": "${subscription_id}"
              }
            ],
            "timeGrain": "PT30M"
          },
          "datasource": {
            "type": "grafana-azure-monitor-datasource",
            "uid": "${datasource_uid}"
          },
          "hide": false,
          "queryType": "Azure Monitor",
          "refId": "B",
          "subscription": "${subscription_id}"
        }
      ],
      "title": "Panoramica eventi inviati/falliti sc-Contracts",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "grafana-azure-monitor-datasource",
        "uid": "${datasource_uid}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "custom": {
            "align": "auto",
            "cellOptions": {
              "type": "auto"
            },
            "footer": {
              "reducers": []
            },
            "hideFrom": {
              "viz": false
            },
            "inspect": false
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 43
      },
      "id": 10,
      "options": {
        "cellHeight": "sm",
        "showHeader": true
      },
      "pluginVersion": "12.2.0",
      "targets": [
        {
          "azureLogAnalytics": {
            "dashboardTime": false,
            "mode": "raw",
            "query": "customEvents\r\n| where name == 'ONBOARDING-FN' and customMeasurements has \"EventsOnboardingInstitution_success\"\r\n| extend Ente = customDimensions.description\r\n| extend internalIstitutionID = customDimensions.internalIstitutionID\r\n| extend origin = customDimensions.origin\r\n| extend Prodotto = customDimensions.product\r\n| extend state = customDimensions.state\r\n| extend Coda = customDimensions.topic\r\n| extend taxcode = customDimensions.taxCode\r\n| project\r\n    timestamp,\r\n    origin,\r\n    Prodotto,\r\n    Ente,\r\n    internalIstitutionID,\r\n    state,\r\n    Coda,\r\n    taxcode,\r\n    customDimensions\r\n| order by timestamp desc",
            "resources": [
              "/subscriptions/${subscription_id}/resourceGroups/${prefix}-monitor-rg/providers/Microsoft.Insights/components/${prefix}-appinsights"
            ],
            "resultFormat": "logs",
            "timeColumn": "timestamp"
          },
          "azureMonitor": {
            "allowedTimeGrainsMs": [],
            "dimensionFilters": [],
            "metricNamespace": "microsoft.insights/components",
            "region": "westeurope",
            "resources": [
              {
                "metricNamespace": "Microsoft.Insights/components",
                "region": "westeurope",
                "resourceGroup": "${prefix}-monitor-rg",
                "resourceName": "${prefix}-appinsights",
                "subscription": "${subscription_id}"
              }
            ],
            "timeGrain": "auto"
          },
          "queryType": "Azure Log Analytics",
          "refId": "A",
          "subscription": "${subscription_id}",
          "datasource": {
            "type": "grafana-azure-monitor-datasource",
            "uid": "${datasource_uid}"
          }
        }
      ],
      "title": "sc-Contracts dettaglio eventi ",
      "type": "table"
    },
    {
      "datasource": {
        "type": "grafana-azure-monitor-datasource",
        "uid": "${datasource_uid}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 0,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "smooth",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "showValues": false,
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 51
      },
      "id": 6,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "single",
          "sort": "none"
        }
      },
      "pluginVersion": "12.2.0",
      "targets": [
        {
          "azureMonitor": {
            "aggregation": "Total",
            "allowedTimeGrainsMs": [
              60000,
              300000,
              900000,
              1800000,
              3600000,
              21600000,
              43200000,
              86400000
            ],
            "customNamespace": "Azure.ApplicationInsights",
            "dimensionFilters": [],
            "metricName": "EventsUserInstitution_success",
            "metricNamespace": "microsoft.insights/components",
            "region": "westeurope",
            "resources": [
              {
                "metricNamespace": "Microsoft.Insights/components",
                "region": "westeurope",
                "resourceGroup": "${prefix}-monitor-rg",
                "resourceName": "${prefix}-appinsights",
                "subscription": "${subscription_id}"
              }
            ],
            "timeGrain": "PT30M"
          },
          "queryType": "Azure Monitor",
          "refId": "Success",
          "subscription": "${subscription_id}",
          "datasource": {
            "type": "grafana-azure-monitor-datasource",
            "uid": "${datasource_uid}"
          }
        },
        {
          "azureMonitor": {
            "aggregation": "Total",
            "allowedTimeGrainsMs": [
              60000,
              300000,
              900000,
              1800000,
              3600000,
              21600000,
              43200000,
              86400000
            ],
            "customNamespace": "Azure.ApplicationInsights",
            "dimensionFilters": [],
            "metricName": "EventsUserInstitution_failures",
            "metricNamespace": "microsoft.insights/components",
            "region": "westeurope",
            "resources": [
              {
                "metricNamespace": "Microsoft.Insights/components",
                "region": "westeurope",
                "resourceGroup": "${prefix}-monitor-rg",
                "resourceName": "${prefix}-appinsights",
                "subscription": "${subscription_id}"
              }
            ],
            "timeGrain": "PT30M"
          },
          "datasource": {
            "type": "grafana-azure-monitor-datasource",
            "uid": "${datasource_uid}"
          },
          "hide": false,
          "queryType": "Azure Monitor",
          "refId": "Failure",
          "subscription": "${subscription_id}"
        }
      ],
      "title": "Panoramica eventi inviati/falliti sc-Users",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "grafana-azure-monitor-datasource",
        "uid": "${datasource_uid}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "custom": {
            "align": "auto",
            "cellOptions": {
              "type": "auto"
            },
            "footer": {
              "reducers": []
            },
            "inspect": false
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 51
      },
      "id": 8,
      "options": {
        "cellHeight": "sm",
        "showHeader": true
      },
      "pluginVersion": "12.2.0",
      "targets": [
        {
          "azureLogAnalytics": {
            "dashboardTime": true,
            "mode": "raw",
            "query": "customEvents\r\n| where name == 'USER_CDC' and customMeasurements has \"EventsUserInstitutionProduct_success\"\r\n| extend internalIstitutionID = customDimensions.institutionId\r\n| extend Prodotto = customDimensions.productId\r\n| extend Role = customDimensions.productRole\r\n| project timestamp, internalIstitutionID, Prodotto, Role, customDimensions \r\n| order by timestamp desc",
            "resources": [
              "/subscriptions/${subscription_id}/resourceGroups/${prefix}-monitor-rg/providers/Microsoft.Insights/components/${prefix}-appinsights"
            ],
            "resultFormat": "logs",
            "timeColumn": "timestamp"
          },
          "azureMonitor": {
            "allowedTimeGrainsMs": [],
            "timeGrain": "auto"
          },
          "queryType": "Azure Log Analytics",
          "refId": "A",
          "datasource": {
            "type": "grafana-azure-monitor-datasource",
            "uid": "${datasource_uid}"
          }
        }
      ],
      "title": "Sc-Users dettaglio eventi",
      "type": "table"
    }
  ],
  "refresh": "",
  "schemaVersion": 42,
  "tags": [],
  "templating": {
    "list": []
  },
  "time": {
    "from": "now-6h",
    "to": "now"
  },
  "timepicker": {},
  "timezone": "",
  "title": "Dashboard-test1",
  "uid": "subscriptions~1ab5e788-3b98-4c63-bd05-de0c7388c853~resourceGroups~dashboards~providers~Microsoft.Dashboard~dashboards~Dashboard-test1",
  "version": 48,
  "weekStart": ""
}