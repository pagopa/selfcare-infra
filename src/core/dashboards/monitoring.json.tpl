{
	"lenses": {
		"0": {
			"order": 0,
			"parts": {
				"0": {
					"position": {
						"x": 0,
						"y": 0,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-vnet-rg/providers/Microsoft.Network/applicationGateways/${prefix}-app-gw"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"value": {
									"scope": "hierarchy"
								},
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "// Failed requests per hour \n// Count of requests to which Application Gateway responded with an error. \n// To create an alert for this query, click '+ New alert rule'\nAzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\" and ( httpStatus_d < 300 or httpStatus_d == 404)\n| summarize n_success = toreal(count()) by bin(TimeGenerated, 1h)\n| join kind=inner (\nAzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\"\n| summarize n_total = toreal(count()) by bin(TimeGenerated, 1h))\non TimeGenerated\n| project TimeGenerated, availability=n_success/n_total, watermark=0.99\n| render timechart\n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "Line",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-app-gw",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "TimeGenerated",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "availability",
											"type": "real"
										},
										{
											"name": "watermark",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"Query": "// Failed requests per hour \n// Count of requests to which Application Gateway responded with an error. \n// To create an alert for this query, click '+ New alert rule'\nAzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\" and ( httpStatus_d < 300 or httpStatus_d == 404)\n| summarize n_success = toreal(count()) by bin(TimeGenerated, 5m)\n| join kind=inner (\nAzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\"\n| summarize n_total = toreal(count()) by bin(TimeGenerated, 5m))\non TimeGenerated\n| project TimeGenerated, availability=(n_success/n_total)*100, watermark=99.9\n| render timechart\n\n",
								"PartTitle": "System Availability "
							}
						}
					}
				},
				"1": {
					"position": {
						"x": 7,
						"y": 0,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "options",
								"value": {
									"chart": {
										"metrics": [
											{
												"resourceMetadata": {
													"id": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-vnet-rg/providers/Microsoft.Network/applicationGateways/${prefix}-app-gw"
												},
												"name": "TotalRequests",
												"aggregationType": 1,
												"metricVisualization": {
													"displayName": "Total Requests",
													"resourceDisplayName": "${prefix}-app-gw"
												}
											}
										],
										"title": "Sum Total Requests",
										"titleKind": 2,
										"visualization": {
											"chartType": 2
										},
										"openBladeOnClick": {
											"openBlade": true
										}
									}
								},
								"isOptional": true
							},
							{
								"name": "sharedTimeRange",
								"isOptional": true
							}
						],
						"type": "Extension/HubsExtension/PartType/MonitorChartPart",
						"settings": {
							"content": {
								"options": {
									"chart": {
										"metrics": [
											{
												"resourceMetadata": {
													"id": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-vnet-rg/providers/Microsoft.Network/applicationGateways/${prefix}-app-gw"
												},
												"name": "TotalRequests",
												"aggregationType": 1,
												"namespace": "microsoft.network/applicationgateways",
												"metricVisualization": {
													"displayName": "Total Requests",
													"resourceDisplayName": "${prefix}-app-gw"
												}
											},
											{
												"resourceMetadata": {
													"id": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-vnet-rg/providers/Microsoft.Network/applicationGateways/${prefix}-app-gw"
												},
												"name": "FailedRequests",
												"aggregationType": 1,
												"namespace": "microsoft.network/applicationgateways",
												"metricVisualization": {
													"displayName": "Failed Requests",
													"resourceDisplayName": "${prefix}-app-gw"
												}
											}
										],
										"title": "Sum Total Requests",
										"titleKind": 2,
										"visualization": {
											"chartType": 2,
											"legendVisualization": {
												"isVisible": true,
												"position": 2,
												"hideSubtitle": false
											},
											"axisVisualization": {
												"x": {
													"isVisible": true,
													"axisType": 2
												},
												"y": {
													"isVisible": true,
													"axisType": 1
												}
											},
											"disablePinning": true
										}
									}
								}
							}
						}
					}
				},
				"2": {
					"position": {
						"x": 29,
						"y": 0,
						"colSpan": 14,
						"rowSpan": 1
					},
					"metadata": {
						"inputs": [],
						"type": "Extension/HubsExtension/PartType/MarkdownPart",
						"settings": {
							"content": {
								"settings": {
									"content": "",
									"title": "🤖 System",
									"subtitle": "",
									"markdownSource": 1,
									"markdownUri": null
								}
							}
						}
					}
				},
				"3": {
					"position": {
						"x": 43,
						"y": 0,
						"colSpan": 14,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourcegroups/${prefix}-monitor-rg/providers/microsoft.insights/components/${prefix}-appinsights"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "requests\n| summarize\n    succeeded=sumif(itemCount, success == true),\n    failed=sumif(itemCount, success == false)\n    by bin(timestamp, 1h), cloud_RoleName\n| project timestamp, cloud_RoleName, availability=(succeeded/(succeeded+failed))*100, watermark=0.99\n| render columnchart  with ( ymax=100, kind=unstacked ) \n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "UnstackedColumn",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-appinsights",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "availability",
											"type": "long"
										}
									],
									"splitBy": [
										{
											"name": "cloud_RoleName",
											"type": "string"
										}
									],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"Query": "requests\n| summarize\n    succeeded=sumif(itemCount, success == true),\n    failed=sumif(itemCount, success == false)\n    by bin(timestamp, 1h), cloud_RoleName\n| project timestamp, cloud_RoleName, availability=(succeeded/(succeeded+failed))*100, watermark=0.99\n| render columnchart  with ( ymax=100, kind=unstacked ) \n\n",
								"SpecificChart": "Line",
								"PartTitle": "Availability single MS",
								"LegendOptions": {
									"isEnabled": true,
									"position": "Right"
								}
							}
						}
					}
				},
				"4": {
					"position": {
						"x": 57,
						"y": 0,
						"colSpan": 14,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourcegroups/${prefix}-monitor-rg/providers/microsoft.insights/components/${prefix}-appinsights"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "requests\n| summarize\n    succeeded=sumif(itemCount, success == true),\n    failed=sumif(itemCount, success == false)\n    by bin(timestamp, 1h), cloud_RoleName\n| project timestamp, cloud_RoleName, availability=(succeeded/(succeeded+failed))*100, watermark=0.99\n| render columnchart  with ( ymax=100, kind=unstacked ) \n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "UnstackedColumn",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-appinsights",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "availability",
											"type": "long"
										}
									],
									"splitBy": [
										{
											"name": "cloud_RoleName",
											"type": "string"
										}
									],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {}
						}
					}
				},
				"5": {
					"position": {
						"x": 71,
						"y": 0,
						"colSpan": 14,
						"rowSpan": 1
					},
					"metadata": {
						"inputs": [],
						"type": "Extension/HubsExtension/PartType/MarkdownPart",
						"settings": {
							"content": {
								"settings": {
									"content": "",
									"title": "🤖 MicroServices",
									"subtitle": "",
									"markdownSource": 1,
									"markdownUri": null
								}
							}
						}
					}
				},
				"6": {
					"position": {
						"x": 0,
						"y": 4,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-vnet-rg/providers/Microsoft.Network/applicationGateways/${prefix}-app-gw"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"value": {
									"scope": "hierarchy"
								},
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "AzureDiagnostics\n| where ResourceProvider == \"MICROSOFT.NETWORK\" and Category == \"ApplicationGatewayAccessLog\"\n| where requestUri_s == \"/dashboard/v1/institutions\"\n| extend HTTPStatus = case(httpStatus_d between (200 .. 299), \"2XX\",\n                       httpStatus_d between (300 .. 399), \"3XX\",\n                       httpStatus_d between (400 .. 499), \"4XX\", \"5XX\")\n| summarize count() by HTTPStatus, bin(timeStamp_t, 1h)\n| render piechart \n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "Pie",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-app-gw",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "HTTPStatus",
										"type": "string"
									},
									"yAxis": [
										{
											"name": "count_",
											"type": "long"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"Query": "// Failed requests per hour \n// Count of requests to which Application Gateway responded with an error. \n// To create an alert for this query, click '+ New alert rule'\nlet api_httpStatus = datatable (name: int) [ 200, 201, 202, 204, 300, 301, 302, 303, 304, 307, 401, 403, 404, 409 ];\nlet success=AzureDiagnostics\n| where ResourceProvider == \"MICROSOFT.NETWORK\" and Category == \"ApplicationGatewayAccessLog\"\n| where (requestUri_s != \"dummy\" and requestUri_s != \"/spid/v1/metadata\")\n| where httpStatus_d in (api_httpStatus)\n| summarize count() by HTTPStatus=\" Success\", bin(TimeGenerated, 5m);\nlet fail=AzureDiagnostics\n| where ResourceProvider == \"MICROSOFT.NETWORK\" and Category == \"ApplicationGatewayAccessLog\"\n| where (requestUri_s != \"dummy\" and requestUri_s != \"/spid/v1/metadata\")\n| where httpStatus_d !in (api_httpStatus)\n| extend HTTPStatus = case(\nhttpStatus_d between (200 .. 299), \"2XX\",\nhttpStatus_d between (300 .. 399), \"3XX\",\nhttpStatus_d between (400 .. 499), \"4XX\",\n\"5XX\"\n)\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m);\nunion success, fail\n| render areachart\n\n",
								"SpecificChart": "StackedArea",
								"PartTitle": "System Response Codes",
								"Dimensions": {
									"xAxis": {
										"name": "TimeGenerated",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "count_",
											"type": "long"
										}
									],
									"splitBy": [
										{
											"name": "HTTPStatus",
											"type": "string"
										}
									],
									"aggregation": "Sum"
								}
							}
						}
					}
				},
				"7": {
					"position": {
						"x": 7,
						"y": 4,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-vnet-rg/providers/Microsoft.Network/applicationGateways/${prefix}-app-gw"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"value": {
									"scope": "hierarchy"
								},
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "AzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\" and ( httpStatus_d < 300 or httpStatus_d == 404) and requestUri_s != \"dummy\" and requestUri_s != \"/spid/v1/metadata\"\n| summarize percentiles(timeTaken_d, 95) by bin(TimeGenerated, 5m), watermark=1\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "Line",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-app-gw",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "TimeGenerated",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "watermark",
											"type": "long"
										},
										{
											"name": "percentile_timeTaken_d_95",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"Query": "AzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\" and ( httpStatus_d < 300 or httpStatus_d == 404) and requestUri_s != \"dummy\" and requestUri_s != \"/spid/v1/metadata\"\n| summarize percentiles(timeTaken_d, 99) by bin(TimeGenerated, 5m), watermark=1\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")\n\n",
								"PartTitle": "System Percentile Response Time",
								"Dimensions": {
									"xAxis": {
										"name": "TimeGenerated",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "watermark",
											"type": "long"
										},
										{
											"name": "percentile_timeTaken_d_99",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								}
							}
						}
					}
				},
				"8": {
					"position": {
						"x": 0,
						"y": 8,
						"colSpan": 7,
						"rowSpan": 1
					},
					"metadata": {
						"inputs": [],
						"type": "Extension/HubsExtension/PartType/MarkdownPart",
						"settings": {
							"content": {
								"settings": {
									"content": "",
									"title": "MicroService Dashboard",
									"subtitle": "",
									"markdownSource": 1,
									"markdownUri": null
								}
							}
						}
					}
				},
				"9": {
					"position": {
						"x": 7,
						"y": 8,
						"colSpan": 7,
						"rowSpan": 1
					},
					"metadata": {
						"inputs": [],
						"type": "Extension/HubsExtension/PartType/MarkdownPart",
						"settings": {
							"content": {
								"settings": {
									"content": "",
									"title": "MicroService Onboarding",
									"subtitle": "",
									"markdownSource": 1
								}
							}
						}
					}
				},
				"10": {
					"position": {
						"x": 0,
						"y": 9,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-vnet-rg/providers/Microsoft.Network/applicationGateways/${prefix}-app-gw"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"value": {
									"scope": "hierarchy"
								},
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "// Failed requests per hour \n// Count of requests to which Application Gateway responded with an error. \n// To create an alert for this query, click '+ New alert rule'\nlet api_url = \"/dashboard\";\nAzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\"\n| where requestUri_s startswith api_url\n| where ( httpStatus_d < 300 or httpStatus_d == 404)\n| summarize n_success = toreal(count()) by bin(TimeGenerated, 5m)\n| join kind=inner (\nAzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\"\n| where requestUri_s startswith api_url\n| summarize n_total = toreal(count()) by bin(TimeGenerated, 5m))\non TimeGenerated\n| project TimeGenerated, availability=(n_success/n_total)*100, watermark=99.9\n| render timechart with ( ymax=100 )\n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "Line",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-app-gw",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "TimeGenerated",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "availability",
											"type": "real"
										},
										{
											"name": "watermark",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"PartTitle": "Availability | MS Dashboard"
							}
						}
					}
				},
				"11": {
					"position": {
						"x": 7,
						"y": 9,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-vnet-rg/providers/Microsoft.Network/applicationGateways/${prefix}-app-gw"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P3D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"value": {
									"scope": "hierarchy"
								},
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "let api_url = \"/onboarding\";\nAzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\"\n| where requestUri_s startswith api_url\n| where ( httpStatus_d < 300 or httpStatus_d == 404)\n| summarize n_success = toreal(count()) by bin(TimeGenerated, 5m)\n| join kind=inner (\nAzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\"\n| where requestUri_s startswith api_url\n| summarize n_total = toreal(count()) by bin(TimeGenerated, 5m))\non TimeGenerated\n| project TimeGenerated, availability=(n_success/n_total)*100, watermark=99.9\n| render timechart with ( ymax=100 )\n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "AnalyticsGrid",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-app-gw",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"ControlType": "FrameControlChart",
								"SpecificChart": "Line",
								"PartTitle": "Availability | MS Onboarding",
								"Dimensions": {
									"xAxis": {
										"name": "TimeGenerated",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "availability",
											"type": "real"
										},
										{
											"name": "watermark",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								},
								"LegendOptions": {
									"isEnabled": true,
									"position": "Bottom"
								}
							}
						}
					}
				},
				"12": {
					"position": {
						"x": 0,
						"y": 13,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-vnet-rg/providers/Microsoft.Network/applicationGateways/${prefix}-app-gw"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"value": {
									"scope": "hierarchy"
								},
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "let api_url = \"/dashboard\";\nAzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\" and ( httpStatus_d < 300 or httpStatus_d == 404) \n| where requestUri_s startswith api_url\n| summarize percentiles(timeTaken_d, 99) by bin(TimeGenerated, 5m), watermark=1\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")\n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "Line",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-app-gw",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "TimeGenerated",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "watermark",
											"type": "long"
										},
										{
											"name": "percentile_timeTaken_d_99",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"Query": "let api_url = \"/dashboard\";\nAzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\" and ( httpStatus_d < 300 or httpStatus_d == 404) \n| where requestUri_s startswith api_url\n| summarize percentiles(timeTaken_d, 99) by bin(TimeGenerated, 5m), watermark=1.6\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")\n\n",
								"PartTitle": "Percentile Response Time | MS Dashboard",
								"Dimensions": {
									"xAxis": {
										"name": "TimeGenerated",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "watermark",
											"type": "real"
										},
										{
											"name": "percentile_timeTaken_d_99",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								}
							}
						}
					}
				},
				"13": {
					"position": {
						"x": 7,
						"y": 13,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-vnet-rg/providers/Microsoft.Network/applicationGateways/${prefix}-app-gw"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"value": {
									"scope": "hierarchy"
								},
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "let api_url = \"/onboarding\";\nAzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\" and ( httpStatus_d < 300 or httpStatus_d == 404) \n| where requestUri_s startswith api_url\n| summarize percentiles(timeTaken_d, 99) by bin(TimeGenerated, 5m), watermark=1\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")\n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "Line",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-app-gw",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "TimeGenerated",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "watermark",
											"type": "long"
										},
										{
											"name": "percentile_timeTaken_d_99",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"Query": "let api_url = \"/onboarding\";\nAzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\" and ( httpStatus_d < 300 or httpStatus_d == 404) \n| where requestUri_s startswith api_url\n| summarize percentiles(timeTaken_d, 99) by bin(TimeGenerated, 5m), watermark=2\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")\n\n",
								"PartTitle": "Percentile Response Time | MS Onboarding"
							}
						}
					}
				},
				"14": {
					"position": {
						"x": 0,
						"y": 17,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-vnet-rg/providers/Microsoft.Network/applicationGateways/${prefix}-app-gw"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"value": {
									"scope": "hierarchy"
								},
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "// Failed requests per hour \n// Count of requests to which Application Gateway responded with an error. \n// To create an alert for this query, click '+ New alert rule'\nlet api_url = \"/dashboard\";\nlet api_httpStatus = datatable (name: int) [ 200 , 304 ];\nlet success=AzureDiagnostics\n| where requestUri_s startswith api_url\n| where httpStatus_d in (api_httpStatus)\n| summarize count() by HTTPStatus=\" Success\", bin(TimeGenerated, 5m);\nlet fail=AzureDiagnostics\n| where requestUri_s startswith api_url\n| where httpStatus_d !in (api_httpStatus)\n| extend HTTPStatus = case(\nhttpStatus_d between (200 .. 299), \"2XX\",\nhttpStatus_d between (300 .. 399), \"3XX\",\nhttpStatus_d between (400 .. 499), \"4XX\",\n\"5XX\"\n)\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m);\nunion success, fail\n| render areachart\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "StackedArea",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-app-gw",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "TimeGenerated",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "count_",
											"type": "long"
										}
									],
									"splitBy": [
										{
											"name": "HTTPStatus",
											"type": "string"
										}
									],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"Query": "// Failed requests per hour \n// Count of requests to which Application Gateway responded with an error. \n// To create an alert for this query, click '+ New alert rule'\nlet api_url = \"/dashboard\";\nlet api_httpStatus = datatable (name: int) [ 200, 201, 204, 304, 401, 403, 404 ];\nlet success=AzureDiagnostics\n| where requestUri_s startswith api_url\n| where httpStatus_d in (api_httpStatus)\n| summarize count() by HTTPStatus=\" Success\", bin(TimeGenerated, 5m);\nlet fail=AzureDiagnostics\n| where requestUri_s startswith api_url\n| where httpStatus_d !in (api_httpStatus)\n| extend HTTPStatus = case(\nhttpStatus_d between (200 .. 299), \"2XX\",\nhttpStatus_d between (300 .. 399), \"3XX\",\nhttpStatus_d between (400 .. 499), \"4XX\",\n\"5XX\"\n)\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m);\nunion success, fail\n| render areachart\n\n",
								"PartTitle": "System Response Codes | MS Dashboard"
							}
						}
					}
				},
				"15": {
					"position": {
						"x": 7,
						"y": 17,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-vnet-rg/providers/Microsoft.Network/applicationGateways/${prefix}-app-gw"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"value": {
									"scope": "hierarchy"
								},
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "// Failed requests per hour \n// Count of requests to which Application Gateway responded with an error. \n// To create an alert for this query, click '+ New alert rule'\nlet api_url = \"/dashboard\";\nlet api_httpStatus = datatable (name: int) [ 200 , 304 ];\nlet success=AzureDiagnostics\n| where requestUri_s startswith api_url\n| where httpStatus_d in (api_httpStatus)\n| summarize count() by HTTPStatus=\" Success\", bin(TimeGenerated, 5m);\nlet fail=AzureDiagnostics\n| where requestUri_s startswith api_url\n| where httpStatus_d !in (api_httpStatus)\n| extend HTTPStatus = case(\nhttpStatus_d between (200 .. 299), \"2XX\",\nhttpStatus_d between (300 .. 399), \"3XX\",\nhttpStatus_d between (400 .. 499), \"4XX\",\n\"5XX\"\n)\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m);\nunion success, fail\n| render areachart\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "StackedArea",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-app-gw",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "TimeGenerated",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "count_",
											"type": "long"
										}
									],
									"splitBy": [
										{
											"name": "HTTPStatus",
											"type": "string"
										}
									],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"Query": "// Failed requests per hour \n// Count of requests to which Application Gateway responded with an error. \n// To create an alert for this query, click '+ New alert rule'\nlet api_url = \"/onboarding\";\nlet api_httpStatus = datatable (name: int) [ 200, 201, 204, 304, 401, 403, 404 ];\nlet success=AzureDiagnostics\n| where requestUri_s startswith api_url\n| where httpStatus_d in (api_httpStatus)\n| summarize count() by HTTPStatus=\" Success\", bin(TimeGenerated, 5m);\nlet fail=AzureDiagnostics\n| where requestUri_s startswith api_url\n| where httpStatus_d !in (api_httpStatus)\n| extend HTTPStatus = case(\nhttpStatus_d between (200 .. 299), \"2XX\",\nhttpStatus_d between (300 .. 399), \"3XX\",\nhttpStatus_d between (400 .. 499), \"4XX\",\n\"5XX\"\n)\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m);\nunion success, fail\n| render areachart\n\n",
								"PartTitle": "System Response Codes | MS Onboarding"
							}
						}
					}
				},
				"16": {
					"position": {
						"x": 0,
						"y": 21,
						"colSpan": 7,
						"rowSpan": 1
					},
					"metadata": {
						"inputs": [],
						"type": "Extension/HubsExtension/PartType/MarkdownPart",
						"settings": {
							"content": {
								"settings": {
									"content": "",
									"title": "MicroService Spid Login",
									"subtitle": "",
									"markdownSource": 1
								}
							}
						}
					}
				},
				"17": {
					"position": {
						"x": 7,
						"y": 21,
						"colSpan": 7,
						"rowSpan": 1
					},
					"metadata": {
						"inputs": [],
						"type": "Extension/HubsExtension/PartType/MarkdownPart",
						"settings": {
							"content": {
								"settings": {
									"content": "",
									"title": "MicroService Products",
									"subtitle": "",
									"markdownSource": 1
								}
							}
						}
					}
				},
				"18": {
					"position": {
						"x": 0,
						"y": 22,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-monitor-rg/providers/microsoft.insights/components/${prefix}-appinsights"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "let roleName = \"hub-spid-login-ms\";\nrequests\n| summarize\n    succeeded=sumif(itemCount, success == true),\n    failed=sumif(itemCount, success == false)\n    by bin(timestamp, 5m), cloud_RoleName\n| where cloud_RoleName == roleName\n| project timestamp, availability=(succeeded/(succeeded+failed))*100, watermark=99.9\n| render timechart with ( ymax=100 ) \n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "Line",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-appinsights",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "availability",
											"type": "long"
										},
										{
											"name": "watermark",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"PartTitle": "Availability | MS Spid Login"
							}
						}
					}
				},
				"19": {
					"position": {
						"x": 7,
						"y": 22,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-monitor-rg/providers/microsoft.insights/components/${prefix}-appinsights"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "let roleName = \"ms-product\";\nrequests\n| summarize\n    succeeded=sumif(itemCount, success == true),\n    failed=sumif(itemCount, success == false)\n    by bin(timestamp, 1h), cloud_RoleName\n| where cloud_RoleName == roleName\n| project timestamp, availability=(succeeded/(succeeded+failed))*100, watermark=99.9\n| render timechart with ( ymax=100 ) \n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "Line",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-appinsights",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "availability",
											"type": "long"
										},
										{
											"name": "watermark",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"Query": "let roleName = \"ms-product\";\nrequests\n| summarize\n    succeeded=sumif(itemCount, success == true),\n    failed=sumif(itemCount, success == false)\n    by bin(timestamp, 5m), cloud_RoleName\n| where cloud_RoleName == roleName\n| project timestamp, availability=(succeeded/(succeeded+failed))*100, watermark=99.9\n| render timechart with ( ymax=100 ) \n\n",
								"PartTitle": "Availability | MS Products"
							}
						}
					}
				},
				"20": {
					"position": {
						"x": 0,
						"y": 26,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-monitor-rg/providers/microsoft.insights/components/${prefix}-appinsights"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "let roleName = \"hub-spid-login-ms\";\nrequests\n| where cloud_RoleName == roleName\n| summarize percentiles(duration/1000, 99) by bin(timestamp, 5m), watermark=1.2\n| render timechart\n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "Line",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-appinsights",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "watermark",
											"type": "real"
										},
										{
											"name": "percentile__99",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"PartTitle": "Percentile Response Time | MS Login"
							}
						}
					}
				},
				"21": {
					"position": {
						"x": 7,
						"y": 26,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-monitor-rg/providers/microsoft.insights/components/${prefix}-appinsights"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "// Failed operations \n// Calculate how many times operations failed, and how many users were impacted. \n// To create an alert for this query, click '+ New alert rule'\nlet roleName = \"ms-product\";\nlet api_httpStatus = datatable (name: int) [ 200, 201, 204, 301, 302, 304, 401, 403, 404 ];\nlet success=requests\n| where cloud_RoleName == roleName\n| where success == true\n| where resultCode  in (api_httpStatus)\n| extend HTTPStatus = case(\ntoint(resultCode) between (200 .. 299), \"2XX\",\ntoint(resultCode) between (300 .. 399), \"3XX\",\ntoint(resultCode) between (400 .. 499), \"4XX\",\n\"5XX\"\n)\n| summarize count() by HTTPStatus, bin(timestamp, 5m);\nlet fail=requests\n| where success == false\n| where resultCode  !in (api_httpStatus)\n| extend HTTPStatus = case(\ntoint(resultCode) between (200 .. 299), \"2XX\",\ntoint(resultCode) between (300 .. 399), \"3XX\",\ntoint(resultCode) between (400 .. 499), \"4XX\",\n\"5XX\"\n)\n| summarize count() by HTTPStatus, bin(timestamp, 5m);\nunion success, fail\n| render areachart\n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "StackedArea",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-appinsights",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "count_",
											"type": "long"
										}
									],
									"splitBy": [
										{
											"name": "HTTPStatus",
											"type": "string"
										}
									],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"PartTitle": "System Response Codes | MS Product"
							}
						}
					}
				},
				"22": {
					"position": {
						"x": 0,
						"y": 30,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-monitor-rg/providers/microsoft.insights/components/${prefix}-appinsights"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "// Failed operations \n// Calculate how many times operations failed, and how many users were impacted. \n// To create an alert for this query, click '+ New alert rule'\nlet roleName = \"hub-spid-login-ms\";\nlet api_httpStatus = datatable (name: int) [ 200, 201, 204, 301, 302, 304, 401, 403, 404 ];\nlet success=requests\n| where cloud_RoleName == roleName\n| where success == true\n| where resultCode  in (api_httpStatus)\n| extend HTTPStatus = case(\ntoint(resultCode) between (200 .. 299), \"2XX\",\ntoint(resultCode) between (300 .. 399), \"3XX\",\ntoint(resultCode) between (400 .. 499), \"4XX\",\n\"5XX\"\n)\n| summarize count() by HTTPStatus, bin(timestamp, 5m);\nlet fail=requests\n| where success == false\n| where resultCode  !in (api_httpStatus)\n| extend HTTPStatus = case(\ntoint(resultCode) between (200 .. 299), \"2XX\",\ntoint(resultCode) between (300 .. 399), \"3XX\",\ntoint(resultCode) between (400 .. 499), \"4XX\",\n\"5XX\"\n)\n| summarize count() by HTTPStatus, bin(timestamp, 5m);\nunion success, fail\n| render areachart\n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "StackedArea",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-appinsights",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "count_",
											"type": "long"
										}
									],
									"splitBy": [
										{
											"name": "HTTPStatus",
											"type": "string"
										}
									],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"PartTitle": "System Response Codes | MS Login"
							}
						}
					}
				},
				"23": {
					"position": {
						"x": 7,
						"y": 30,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-monitor-rg/providers/microsoft.insights/components/${prefix}-appinsights"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "let roleName = \"ms-product\";\nrequests\n| where cloud_RoleName == roleName\n| summarize percentiles(duration, 99) by bin(timestamp, 5m), watermark=1200\n| render timechart\n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "Line",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-appinsights",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "watermark",
											"type": "long"
										},
										{
											"name": "percentile_duration_99",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"Query": "let roleName = \"ms-product\";\nrequests\n| where cloud_RoleName == roleName\n| summarize percentiles(duration/1000, 99) by bin(timestamp, 5m), watermark=1.2\n| render timechart\n\n",
								"PartTitle": "Percentile Response Time | MS Product",
								"Dimensions": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "watermark",
											"type": "real"
										},
										{
											"name": "percentile__99",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								}
							}
						}
					}
				},
				"24": {
					"position": {
						"x": 0,
						"y": 34,
						"colSpan": 7,
						"rowSpan": 1
					},
					"metadata": {
						"inputs": [],
						"type": "Extension/HubsExtension/PartType/MarkdownPart",
						"settings": {
							"content": {
								"settings": {
									"content": "",
									"title": "MicroService User Group",
									"subtitle": "",
									"markdownSource": 1
								}
							}
						}
					}
				},
				"25": {
					"position": {
						"x": 7,
						"y": 34,
						"colSpan": 7,
						"rowSpan": 1
					},
					"metadata": {
						"inputs": [],
						"type": "Extension/HubsExtension/PartType/MarkdownPart",
						"settings": {
							"content": {
								"settings": {
									"content": "",
									"title": "MicroService Party Process",
									"subtitle": "",
									"markdownSource": 1
								}
							}
						}
					}
				},
				"26": {
					"position": {
						"x": 0,
						"y": 35,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-monitor-rg/providers/microsoft.insights/components/${prefix}-appinsights"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "let roleName = \"ms-user-group\";\nrequests\n| summarize\n    succeeded=sumif(itemCount, success == true),\n    failed=sumif(itemCount, success == false)\n    by bin(timestamp, 5m), cloud_RoleName\n| where cloud_RoleName == roleName\n| project timestamp, availability=(succeeded/(succeeded+failed))*100, watermark=99.9\n| render timechart with ( ymax=100 ) \n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "Line",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-appinsights",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "availability",
											"type": "long"
										},
										{
											"name": "watermark",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"PartTitle": "Availability | MS User Group"
							}
						}
					}
				},
				"27": {
					"position": {
						"x": 7,
						"y": 35,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-monitor-rg/providers/microsoft.insights/components/${prefix}-appinsights"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "let roleName = \"ms-notification-manager\";\nrequests\n| summarize\n    succeeded=sumif(itemCount, success == true),\n    failed=sumif(itemCount, success == false)\n    by bin(timestamp, 5m), cloud_RoleName\n| where cloud_RoleName == roleName\n| project timestamp, availability=(succeeded/(succeeded+failed))*100, watermark=99.9\n| render timechart with ( ymax=100 ) \n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "Line",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-appinsights",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "availability",
											"type": "long"
										},
										{
											"name": "watermark",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"PartTitle": "Availability | MS Notification Manager"
							}
						}
					}
				},
				"28": {
					"position": {
						"x": 0,
						"y": 39,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-monitor-rg/providers/microsoft.insights/components/${prefix}-appinsights"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "// Failed operations \n// Calculate how many times operations failed, and how many users were impacted. \n// To create an alert for this query, click '+ New alert rule'\nlet roleName = \"ms-user-group\";\nlet api_httpStatus = datatable (name: int) [ 200, 201, 204, 301, 302, 304, 401, 403, 404 ];\nlet success=requests\n| where cloud_RoleName == roleName\n| where success == true\n| where resultCode  in (api_httpStatus)\n| extend HTTPStatus = case(\ntoint(resultCode) between (200 .. 299), \"2XX\",\ntoint(resultCode) between (300 .. 399), \"3XX\",\ntoint(resultCode) between (400 .. 499), \"4XX\",\n\"5XX\"\n)\n| summarize count() by HTTPStatus, bin(timestamp, 5m);\nlet fail=requests\n| where success == false\n| where resultCode  !in (api_httpStatus)\n| extend HTTPStatus = case(\ntoint(resultCode) between (200 .. 299), \"2XX\",\ntoint(resultCode) between (300 .. 399), \"3XX\",\ntoint(resultCode) between (400 .. 499), \"4XX\",\n\"5XX\"\n)\n| summarize count() by HTTPStatus, bin(timestamp, 5m);\nunion success, fail\n| render areachart\n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "StackedArea",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-appinsights",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "count_",
											"type": "long"
										}
									],
									"splitBy": [
										{
											"name": "HTTPStatus",
											"type": "string"
										}
									],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"PartTitle": "System Response Codes | MS User Group"
							}
						}
					}
				},
				"29": {
					"position": {
						"x": 7,
						"y": 39,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-monitor-rg/providers/microsoft.insights/components/${prefix}-appinsights"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "// Failed operations \n// Calculate how many times operations failed, and how many users were impacted. \n// To create an alert for this query, click '+ New alert rule'\nlet roleName = \"ms-notification-ms\";\nlet api_httpStatus = datatable (name: int) [ 200, 201, 204, 301, 302, 304, 401, 403, 404 ];\nlet success=requests\n| where cloud_RoleName == roleName\n| where success == true\n| where resultCode  in (api_httpStatus)\n| extend HTTPStatus = case(\ntoint(resultCode) between (200 .. 299), \"2XX\",\ntoint(resultCode) between (300 .. 399), \"3XX\",\ntoint(resultCode) between (400 .. 499), \"4XX\",\n\"5XX\"\n)\n| summarize count() by HTTPStatus, bin(timestamp, 5m);\nlet fail=requests\n| where success == false\n| where resultCode  !in (api_httpStatus)\n| extend HTTPStatus = case(\ntoint(resultCode) between (200 .. 299), \"2XX\",\ntoint(resultCode) between (300 .. 399), \"3XX\",\ntoint(resultCode) between (400 .. 499), \"4XX\",\n\"5XX\"\n)\n| summarize count() by HTTPStatus, bin(timestamp, 5m);\nunion success, fail\n| render areachart\n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "StackedArea",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-appinsights",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "count_",
											"type": "long"
										}
									],
									"splitBy": [
										{
											"name": "HTTPStatus",
											"type": "string"
										}
									],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"PartTitle": "System Response Codes | S Notification Manager"
							}
						}
					}
				},
				"30": {
					"position": {
						"x": 0,
						"y": 43,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-monitor-rg/providers/microsoft.insights/components/${prefix}-appinsights"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "let roleName = \"ms-user-group\";\nrequests\n| where cloud_RoleName == roleName\n| summarize percentiles(duration, 99) by bin(timestamp, 5m), watermark=1200\n| render timechart\n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "Line",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-appinsights",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "watermark",
											"type": "long"
										},
										{
											"name": "percentile_duration_99",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"Query": "let roleName = \"ms-user-group\";\nrequests\n| where cloud_RoleName == roleName\n| summarize percentiles(duration/1000, 99) by bin(timestamp, 5m), watermark=1.2\n| render timechart\n\n",
								"PartTitle": "Percentile Response Time | MS User Group",
								"Dimensions": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "watermark",
											"type": "real"
										},
										{
											"name": "percentile__99",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								}
							}
						}
					}
				},
				"31": {
					"position": {
						"x": 7,
						"y": 43,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-monitor-rg/providers/microsoft.insights/components/${prefix}-appinsights"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "let roleName = \"ms-notification-manager\";\nrequests\n| where cloud_RoleName == roleName\n| summarize percentiles(duration, 99) by bin(timestamp, 5m), watermark=1200\n| render timechart\n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "Line",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-appinsights",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "watermark",
											"type": "long"
										},
										{
											"name": "percentile_duration_99",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"Query": "let roleName = \"ms-notification-manager\";\nrequests\n| where cloud_RoleName == roleName\n| summarize percentiles(duration/1000, 99) by bin(timestamp, 5m), watermark=1.200\n| render timechart\n\n",
								"PartTitle": "Percentile Response Time | MS Notification Manager",
								"Dimensions": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "watermark",
											"type": "real"
										},
										{
											"name": "percentile__99",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								}
							}
						}
					}
				},
				"32": {
					"position": {
						"x": 0,
						"y": 47,
						"colSpan": 7,
						"rowSpan": 1
					},
					"metadata": {
						"inputs": [],
						"type": "Extension/HubsExtension/PartType/MarkdownPart",
						"settings": {
							"content": {
								"settings": {
									"content": "",
									"title": "MicroService Notification Manager",
									"subtitle": "",
									"markdownSource": 1
								}
							}
						}
					}
				},
				"33": {
					"position": {
						"x": 7,
						"y": 47,
						"colSpan": 7,
						"rowSpan": 1
					},
					"metadata": {
						"inputs": [],
						"type": "Extension/HubsExtension/PartType/MarkdownPart",
						"settings": {
							"content": {
								"settings": {
									"content": "",
									"title": "Aruba PEC Service",
									"subtitle": "",
									"markdownSource": 1
								}
							}
						}
					}
				},
				"34": {
					"position": {
						"x": 0,
						"y": 48,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-monitor-rg/providers/microsoft.insights/components/${prefix}-appinsights"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "dependencies\n| summarize\n    succeeded=sumif(itemCount, success == true),\n    failed=sumif(itemCount, success == false)\n    by bin(timestamp, 5m), target\n| where target == \"interop-be-party-process:8088\"\n| project timestamp, availability=(succeeded/(succeeded+failed))*100, watermark=99.9\n| render timechart with ( ymax=100 ) \n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "Line",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-appinsights",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "availability",
											"type": "long"
										},
										{
											"name": "watermark",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"PartTitle": "Availability | MS Party Process"
							}
						}
					}
				},
				"35": {
					"position": {
						"x": 7,
						"y": 48,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-aks-rg/providers/Microsoft.ContainerService/managedClusters/${prefix}-aks"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"value": {
									"scope": "hierarchy"
								},
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "ContainerLog \n| where LogEntry has \"[onboarding-contract-email] Email successful sent\"\n| summarize n_success = toreal(count()) by bin(TimeGenerated, 5m)\n| join kind=inner (ContainerLog \n| where LogEntry has \"[onboarding-contract-email]\"\n| summarize n_total = toreal(count()) by bin(TimeGenerated, 5m))\non TimeGenerated\n| project TimeGenerated, availability=(n_success/n_total)*100, watermark=99.9\n| render timechart with ( ymax=100 )\n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "Line",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-aks",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "TimeGenerated",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "availability",
											"type": "real"
										},
										{
											"name": "watermark",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"PartTitle": "Availability | Aruba PEC Service"
							}
						}
					}
				},
				"36": {
					"position": {
						"x": 0,
						"y": 52,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-monitor-rg/providers/microsoft.insights/components/${prefix}-appinsights"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "dependencies \n| where target == \"interop-be-party-process:8088\"\n| summarize percentiles(duration, 99) by bin(timestamp, 5m), watermark=1200\n| render timechart \n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "Line",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-appinsights",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "watermark",
											"type": "long"
										},
										{
											"name": "percentile_duration_99",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"Query": "dependencies \n| where target == \"interop-be-party-process:8088\"\n| summarize percentiles(duration/1000, 99) by bin(timestamp, 5m), watermark=1.2\n| render timechart \n\n",
								"PartTitle": "Percentile Response Time | MS Party Process",
								"Dimensions": {
									"xAxis": {
										"name": "timestamp",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "watermark",
											"type": "real"
										},
										{
											"name": "percentile__99",
											"type": "real"
										}
									],
									"splitBy": [],
									"aggregation": "Sum"
								}
							}
						}
					}
				},
				"37": {
					"position": {
						"x": 7,
						"y": 52,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-aks-rg/providers/Microsoft.ContainerService/managedClusters/${prefix}-aks"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"value": {
									"scope": "hierarchy"
								},
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "let success=ContainerLog \n| where LogEntry has \"[onboarding-contract-email] Email successful sent\"\n| summarize count() by HTTPStatus=\"Success\", bin(TimeGenerated, 5m);\nlet fail=ContainerLog \n| where LogEntry has \"[onboarding-contract-email] An error occurred while sending email\"\n| summarize count() by HTTPStatus=\"Fail\", bin(TimeGenerated, 5m);\nunion success, fail\n| render areachart\n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "StackedArea",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-aks",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "TimeGenerated",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "count_",
											"type": "long"
										}
									],
									"splitBy": [
										{
											"name": "HTTPStatus",
											"type": "string"
										}
									],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"PartTitle": "System Response Codes | Aruba PEC Service"
							}
						}
					}
				},
				"38": {
					"position": {
						"x": 0,
						"y": 56,
						"colSpan": 14,
						"rowSpan": 1
					},
					"metadata": {
						"inputs": [],
						"type": "Extension/HubsExtension/PartType/MarkdownPart",
						"settings": {
							"content": {
								"settings": {
									"content": "",
									"title": "Storage Layer",
									"subtitle": "",
									"markdownSource": 1
								}
							}
						}
					}
				},
				"39": {
					"position": {
						"x": 0,
						"y": 57,
						"colSpan": 14,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "ComponentId",
								"value": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-cosmosdb-mongodb-rg/providers/Microsoft.DocumentDB/databaseAccounts/${prefix}-cosmosdb-mongodb-account",
								"isOptional": true
							},
							{
								"name": "TimeContext",
								"value": null,
								"isOptional": true
							},
							{
								"name": "ResourceIds",
								"isOptional": true
							},
							{
								"name": "ConfigurationId",
								"value": "Community-Workbooks/CosmosDb/Resource Insights",
								"isOptional": true
							},
							{
								"name": "Type",
								"value": "cosmosdb-insights",
								"isOptional": true
							},
							{
								"name": "GalleryResourceType",
								"value": "Microsoft.DocumentDb/databaseAccounts",
								"isOptional": true
							},
							{
								"name": "PinName",
								"value": "Azure Cosmos DB Resource Insights",
								"isOptional": true
							},
							{
								"name": "StepSettings",
								"value": "{\"version\":\"MetricsItem/2.0\",\"size\":0,\"chartType\":2,\"resourceType\":\"microsoft.documentdb/databaseaccounts\",\"metricScope\":0,\"resourceParameter\":\"Resources\",\"resourceIds\":[\"{Resources}\"],\"timeContextFromParameter\":\"TimeRange\",\"timeContext\":{\"durationMs\":14400000},\"metrics\":[{\"namespace\":\"microsoft.documentdb/databaseaccounts\",\"metric\":\"microsoft.documentdb/databaseaccounts-Requests-ServiceAvailability\",\"aggregation\":4,\"splitBy\":null},{\"namespace\":\"microsoft.documentdb/databaseaccounts\",\"metric\":\"microsoft.documentdb/databaseaccounts-Requests-ServiceAvailability\",\"aggregation\":2},{\"namespace\":\"microsoft.documentdb/databaseaccounts\",\"metric\":\"microsoft.documentdb/databaseaccounts-Requests-ServiceAvailability\",\"aggregation\":3}],\"title\":\"Service Availability (min/max/avg in %)\",\"timeBrushParameterName\":\"TimeRange\",\"timeBrushExportOnlyWhenBrushed\":true,\"gridSettings\":{\"formatters\":[{\"columnMatch\":\"Subscription\",\"formatter\":5},{\"columnMatch\":\"Name\",\"formatter\":13,\"formatOptions\":{\"linkTarget\":\"Resource\"}},{\"columnMatch\":\"microsoft.documentdb/databaseaccounts-Requests-ServiceAvailability Timeline\",\"formatter\":5},{\"columnMatch\":\"microsoft.documentdb/databaseaccounts-Requests-ServiceAvailability\",\"formatter\":1,\"numberFormat\":{\"unit\":1,\"options\":null}}],\"rowLimit\":10000,\"labelSettings\":[{\"columnId\":\"Subscription\",\"label\":\"Subscription/Database/Collection\"},{\"columnId\":\"microsoft.documentdb/databaseaccounts-Requests-ServiceAvailability\",\"label\":\"Service Availability (Average)\"},{\"columnId\":\"microsoft.documentdb/databaseaccounts-Requests-ServiceAvailability Timeline\",\"label\":\"Service Availability Timeline\"}]}}",
								"isOptional": true
							},
							{
								"name": "ParameterValues",
								"value": {
									"Resources": {
										"type": 5,
										"value": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-cosmosdb-mongodb-rg/providers/Microsoft.DocumentDB/databaseAccounts/${prefix}-cosmosdb-mongodb-account",
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "Any one",
										"displayName": "Azure Cosmos DB",
										"specialValue": "value::1",
										"formattedValue": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-cosmosdb-mongodb-rg/providers/Microsoft.DocumentDB/databaseAccounts/${prefix}-cosmosdb-mongodb-account"
									},
									"EnabledApiTypes": {
										"type": 1,
										"value": "MongoDB",
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "MongoDB",
										"displayName": "EnabledApiTypes",
										"formattedValue": "MongoDB"
									},
									"ApiDatabases": {
										"type": 1,
										"value": "mongodbDatabases",
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "mongodbDatabases",
										"displayName": "ApiDatabases",
										"formattedValue": "mongodbDatabases"
									},
									"TimeRange": {
										"type": 4,
										"value": {
											"durationMs": 14400000
										},
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": true,
										"labelValue": "Last 4 hours",
										"displayName": "Time Range",
										"formattedValue": "Last 4 hours"
									},
									"Database": {
										"type": 2,
										"value": null,
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "<unset>",
										"displayName": "Database",
										"formattedValue": ""
									},
									"APIContainerType": {
										"type": 1,
										"value": "collections",
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "collections",
										"displayName": "APIContainerType",
										"formattedValue": "collections"
									},
									"Container": {
										"type": 2,
										"value": null,
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "<unset>",
										"displayName": "Collection",
										"formattedValue": ""
									},
									"selectedTab": {
										"type": 1,
										"value": "Availability",
										"formattedValue": "Availability"
									},
									"DatabaseText": {
										"type": 1,
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "<unset>",
										"displayName": "Database",
										"formattedValue": ""
									},
									"ContainerText": {
										"type": 1,
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "<unset>",
										"displayName": "Collection",
										"formattedValue": ""
									}
								},
								"isOptional": true
							},
							{
								"name": "Location",
								"isOptional": true
							}
						],
						"type": "Extension/AppInsightsExtension/PartType/PinnedNotebookMetricsPart",
						"partHeader": {
							"title": "DB Cosmos Mongo Availability",
							"subtitle": ""
						}
					}
				},
				"40": {
					"position": {
						"x": 0,
						"y": 61,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "ComponentId",
								"value": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-cosmosdb-mongodb-rg/providers/Microsoft.DocumentDB/databaseAccounts/${prefix}-cosmosdb-mongodb-account",
								"isOptional": true
							},
							{
								"name": "TimeContext",
								"value": null,
								"isOptional": true
							},
							{
								"name": "ResourceIds",
								"isOptional": true
							},
							{
								"name": "ConfigurationId",
								"value": "Community-Workbooks/CosmosDb/Resource Insights",
								"isOptional": true
							},
							{
								"name": "Type",
								"value": "cosmosdb-insights",
								"isOptional": true
							},
							{
								"name": "GalleryResourceType",
								"value": "Microsoft.DocumentDb/databaseAccounts",
								"isOptional": true
							},
							{
								"name": "PinName",
								"value": "Azure Cosmos DB Resource Insights",
								"isOptional": true
							},
							{
								"name": "StepSettings",
								"value": "{\"version\":\"MetricsItem/2.0\",\"size\":1,\"chartType\":2,\"resourceType\":\"microsoft.documentdb/databaseaccounts\",\"metricScope\":0,\"resourceParameter\":\"Resources\",\"resourceIds\":[\"{Resources}\"],\"timeContextFromParameter\":\"TimeRange\",\"timeContext\":{\"durationMs\":14400000},\"metrics\":[{\"namespace\":\"microsoft.documentdb/databaseaccounts\",\"metric\":\"microsoft.documentdb/databaseaccounts-Requests-MongoRequests\",\"aggregation\":7,\"splitBy\":\"CommandName\",\"columnName\":\"MongoDB Client Requests\"}],\"title\":\"Client Requests {DatabaseText} {ContainerText}\",\"showOpenInMe\":true,\"filters\":[{\"id\":\"4\",\"key\":\"CollectionName\",\"operator\":0,\"valueParam\":\"Container\"},{\"id\":\"5\",\"key\":\"DatabaseName\",\"operator\":0,\"valueParam\":\"Database\"}],\"timeBrushParameterName\":\"TimeRange\",\"timeBrushExportOnlyWhenBrushed\":true,\"gridSettings\":{\"rowLimit\":10000}}",
								"isOptional": true
							},
							{
								"name": "ParameterValues",
								"value": {
									"Resources": {
										"type": 5,
										"value": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-cosmosdb-mongodb-rg/providers/Microsoft.DocumentDB/databaseAccounts/${prefix}-cosmosdb-mongodb-account",
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "Any one",
										"displayName": "Azure Cosmos DB",
										"specialValue": "value::1",
										"formattedValue": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-cosmosdb-mongodb-rg/providers/Microsoft.DocumentDB/databaseAccounts/${prefix}-cosmosdb-mongodb-account"
									},
									"EnabledApiTypes": {
										"type": 1,
										"value": "MongoDB",
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "MongoDB",
										"displayName": "EnabledApiTypes",
										"formattedValue": "MongoDB"
									},
									"ApiDatabases": {
										"type": 1,
										"value": "mongodbDatabases",
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "mongodbDatabases",
										"displayName": "ApiDatabases",
										"formattedValue": "mongodbDatabases"
									},
									"TimeRange": {
										"type": 4,
										"value": {
											"durationMs": 14400000
										},
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": true,
										"labelValue": "Last 4 hours",
										"displayName": "Time Range",
										"formattedValue": "Last 4 hours"
									},
									"Database": {
										"type": 2,
										"value": null,
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "<unset>",
										"displayName": "Database",
										"formattedValue": ""
									},
									"APIContainerType": {
										"type": 1,
										"value": "collections",
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "collections",
										"displayName": "APIContainerType",
										"formattedValue": "collections"
									},
									"Container": {
										"type": 2,
										"value": null,
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "<unset>",
										"displayName": "Collection",
										"formattedValue": ""
									},
									"selectedTab": {
										"type": 1,
										"value": "Overview",
										"formattedValue": "Overview"
									},
									"DatabaseText": {
										"type": 1,
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "<unset>",
										"displayName": "Database",
										"formattedValue": ""
									},
									"ContainerText": {
										"type": 1,
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "<unset>",
										"displayName": "Collection",
										"formattedValue": ""
									}
								},
								"isOptional": true
							},
							{
								"name": "Location",
								"isOptional": true
							}
						],
						"type": "Extension/AppInsightsExtension/PartType/PinnedNotebookMetricsPart",
						"partHeader": {
							"title": "DB Cosmos Mongo Client Requests",
							"subtitle": ""
						}
					}
				},
				"41": {
					"position": {
						"x": 7,
						"y": 61,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "ComponentId",
								"value": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-cosmosdb-mongodb-rg/providers/Microsoft.DocumentDB/databaseAccounts/${prefix}-cosmosdb-mongodb-account",
								"isOptional": true
							},
							{
								"name": "TimeContext",
								"value": null,
								"isOptional": true
							},
							{
								"name": "ResourceIds",
								"isOptional": true
							},
							{
								"name": "ConfigurationId",
								"value": "Community-Workbooks/CosmosDb/Resource Insights",
								"isOptional": true
							},
							{
								"name": "Type",
								"value": "cosmosdb-insights",
								"isOptional": true
							},
							{
								"name": "GalleryResourceType",
								"value": "Microsoft.DocumentDb/databaseAccounts",
								"isOptional": true
							},
							{
								"name": "PinName",
								"value": "Azure Cosmos DB Resource Insights",
								"isOptional": true
							},
							{
								"name": "StepSettings",
								"value": "{\"version\":\"MetricsItem/2.0\",\"size\":1,\"chartType\":2,\"resourceType\":\"microsoft.documentdb/databaseaccounts\",\"metricScope\":0,\"resourceParameter\":\"Resources\",\"resourceIds\":[\"{Resources}\"],\"timeContextFromParameter\":\"TimeRange\",\"timeContext\":{\"durationMs\":14400000},\"metrics\":[{\"namespace\":\"microsoft.documentdb/databaseaccounts\",\"metric\":\"microsoft.documentdb/databaseaccounts-Requests-MongoRequests\",\"aggregation\":7,\"splitBy\":\"ErrorCode\",\"columnName\":\"Failed Requests\"}],\"title\":\"Failed Client Requests {DatabaseText} {ContainerText}\",\"gridFormatType\":2,\"showOpenInMe\":true,\"filters\":[{\"id\":\"1\",\"key\":\"ErrorCode\",\"operator\":1,\"values\":[\"0\"]},{\"id\":\"2\",\"key\":\"CollectionName\",\"operator\":0,\"valueParam\":\"Container\"},{\"id\":\"3\",\"key\":\"DatabaseName\",\"operator\":0,\"valueParam\":\"Database\"}],\"timeBrushParameterName\":\"TimeRange\",\"timeBrushExportOnlyWhenBrushed\":true,\"gridSettings\":{\"formatters\":[{\"columnMatch\":\"Subscription\",\"formatter\":5},{\"columnMatch\":\"Name\",\"formatter\":13,\"formatOptions\":{\"linkTarget\":\"Resource\"}},{\"columnMatch\":\"microsoft.documentdb/databaseaccounts-Requests-TotalRequests Timeline\",\"formatter\":5},{\"columnMatch\":\"microsoft.documentdb/databaseaccounts-Requests-TotalRequests\",\"formatter\":1,\"numberFormat\":{\"unit\":0,\"options\":null}},{\"columnMatch\":\"Metric\",\"formatter\":1},{\"columnMatch\":\"Aggregation\",\"formatter\":5},{\"columnMatch\":\"Value\",\"formatter\":1},{\"columnMatch\":\"Timeline\",\"formatter\":9}],\"rowLimit\":10000,\"labelSettings\":[{\"columnId\":\"microsoft.documentdb/databaseaccounts-Requests-TotalRequests\",\"label\":\"Total Requests (Count)\"},{\"columnId\":\"microsoft.documentdb/databaseaccounts-Requests-TotalRequests Timeline\",\"label\":\"Total Requests (Count) Timeline\"}]}}",
								"isOptional": true
							},
							{
								"name": "ParameterValues",
								"value": {
									"Resources": {
										"type": 5,
										"value": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-cosmosdb-mongodb-rg/providers/Microsoft.DocumentDB/databaseAccounts/${prefix}-cosmosdb-mongodb-account",
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "Any one",
										"displayName": "Azure Cosmos DB",
										"specialValue": "value::1",
										"formattedValue": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-cosmosdb-mongodb-rg/providers/Microsoft.DocumentDB/databaseAccounts/${prefix}-cosmosdb-mongodb-account"
									},
									"EnabledApiTypes": {
										"type": 1,
										"value": "MongoDB",
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "MongoDB",
										"displayName": "EnabledApiTypes",
										"formattedValue": "MongoDB"
									},
									"ApiDatabases": {
										"type": 1,
										"value": "mongodbDatabases",
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "mongodbDatabases",
										"displayName": "ApiDatabases",
										"formattedValue": "mongodbDatabases"
									},
									"TimeRange": {
										"type": 4,
										"value": {
											"durationMs": 14400000
										},
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": true,
										"labelValue": "Last 4 hours",
										"displayName": "Time Range",
										"formattedValue": "Last 4 hours"
									},
									"Database": {
										"type": 2,
										"value": null,
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "<unset>",
										"displayName": "Database",
										"formattedValue": ""
									},
									"APIContainerType": {
										"type": 1,
										"value": "collections",
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "collections",
										"displayName": "APIContainerType",
										"formattedValue": "collections"
									},
									"Container": {
										"type": 2,
										"value": null,
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "<unset>",
										"displayName": "Collection",
										"formattedValue": ""
									},
									"selectedTab": {
										"type": 1,
										"value": "Overview",
										"formattedValue": "Overview"
									},
									"DatabaseText": {
										"type": 1,
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "<unset>",
										"displayName": "Database",
										"formattedValue": ""
									},
									"ContainerText": {
										"type": 1,
										"isPending": false,
										"isWaiting": false,
										"isFailed": false,
										"isGlobal": false,
										"labelValue": "<unset>",
										"displayName": "Collection",
										"formattedValue": ""
									}
								},
								"isOptional": true
							},
							{
								"name": "Location",
								"isOptional": true
							}
						],
						"type": "Extension/AppInsightsExtension/PartType/PinnedNotebookMetricsPart",
						"partHeader": {
							"title": "DB Cosmos Mongo Failed Client Requests",
							"subtitle": ""
						}
					}
				},
				"42": {
					"position": {
						"x": 0,
						"y": 65,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "options",
								"value": {
									"chart": {
										"metrics": [
											{
												"resourceMetadata": {
													"id": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-postgres-rg/providers/Microsoft.DBforPostgreSQL/servers/${prefix}-postgresql"
												},
												"name": "connections_failed",
												"aggregationType": 1,
												"namespace": "microsoft.dbforpostgresql/servers",
												"metricVisualization": {
													"displayName": "Failed Connections",
													"color": "#d40004"
												}
											},
											{
												"resourceMetadata": {
													"id": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-postgres-rg/providers/Microsoft.DBforPostgreSQL/servers/${prefix}-postgresql"
												},
												"name": "active_connections",
												"aggregationType": 2,
												"namespace": "microsoft.dbforpostgresql/servers",
												"metricVisualization": {
													"displayName": "Active Connections",
													"color": "#001ee0"
												}
											}
										],
										"title": "Sum Failed Connections and Min Active Connections for ${prefix}-postgresql",
										"titleKind": 1,
										"visualization": {
											"chartType": 2,
											"legendVisualization": {
												"isVisible": true,
												"position": 2,
												"hideSubtitle": false
											},
											"axisVisualization": {
												"x": {
													"isVisible": true,
													"axisType": 2
												},
												"y": {
													"isVisible": true,
													"axisType": 1
												}
											}
										},
										"timespan": {
											"relative": {
												"duration": 86400000
											},
											"showUTCTime": false,
											"grain": 1
										}
									}
								},
								"isOptional": true
							},
							{
								"name": "sharedTimeRange",
								"isOptional": true
							}
						],
						"type": "Extension/HubsExtension/PartType/MonitorChartPart",
						"settings": {
							"content": {
								"options": {
									"chart": {
										"metrics": [
											{
												"resourceMetadata": {
													"id": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-postgres-rg/providers/Microsoft.DBforPostgreSQL/servers/${prefix}-postgresql"
												},
												"name": "connections_failed",
												"aggregationType": 1,
												"namespace": "microsoft.dbforpostgresql/servers",
												"metricVisualization": {
													"displayName": "Failed Connections",
													"color": "#d40004"
												}
											},
											{
												"resourceMetadata": {
													"id": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-postgres-rg/providers/Microsoft.DBforPostgreSQL/servers/${prefix}-postgresql"
												},
												"name": "active_connections",
												"aggregationType": 2,
												"namespace": "microsoft.dbforpostgresql/servers",
												"metricVisualization": {
													"displayName": "Active Connections",
													"color": "#001ee0"
												}
											}
										],
										"title": "Sum Failed Connections and Min Active Connections for ${prefix}-postgresql",
										"titleKind": 1,
										"visualization": {
											"chartType": 2,
											"legendVisualization": {
												"isVisible": true,
												"position": 2,
												"hideSubtitle": false
											},
											"axisVisualization": {
												"x": {
													"isVisible": true,
													"axisType": 2
												},
												"y": {
													"isVisible": true,
													"axisType": 1
												}
											},
											"disablePinning": true
										}
									}
								}
							}
						},
						"filters": {
							"MsPortalFx_TimeRange": {
								"model": {
									"format": "local",
									"granularity": "auto",
									"relative": "1440m"
								}
							}
						}
					}
				},
				"43": {
					"position": {
						"x": 7,
						"y": 65,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "options",
								"value": {
									"chart": {
										"metrics": [
											{
												"resourceMetadata": {
													"id": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-postgres-rg/providers/Microsoft.DBforPostgreSQL/servers/${prefix}-postgresql"
												},
												"name": "cpu_percent",
												"aggregationType": 3,
												"namespace": "microsoft.dbforpostgresql/servers",
												"metricVisualization": {
													"displayName": "CPU percent"
												}
											},
											{
												"resourceMetadata": {
													"id": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-postgres-rg/providers/Microsoft.DBforPostgreSQL/servers/${prefix}-postgresql"
												},
												"name": "storage_percent",
												"aggregationType": 3,
												"namespace": "microsoft.dbforpostgresql/servers",
												"metricVisualization": {
													"displayName": "Storage percent"
												}
											},
											{
												"resourceMetadata": {
													"id": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-postgres-rg/providers/Microsoft.DBforPostgreSQL/servers/${prefix}-postgresql"
												},
												"name": "memory_percent",
												"aggregationType": 3,
												"namespace": "microsoft.dbforpostgresql/servers",
												"metricVisualization": {
													"displayName": "Memory percent"
												}
											}
										],
										"title": "Max CPU percent, Max Storage percent, and Max Memory percent for ${prefix}-postgresql",
										"titleKind": 1,
										"visualization": {
											"chartType": 2,
											"legendVisualization": {
												"isVisible": true,
												"position": 2,
												"hideSubtitle": false
											},
											"axisVisualization": {
												"x": {
													"isVisible": true,
													"axisType": 2
												},
												"y": {
													"isVisible": true,
													"axisType": 1
												}
											}
										},
										"timespan": {
											"relative": {
												"duration": 86400000
											},
											"showUTCTime": false,
											"grain": 1
										}
									}
								},
								"isOptional": true
							},
							{
								"name": "sharedTimeRange",
								"isOptional": true
							}
						],
						"type": "Extension/HubsExtension/PartType/MonitorChartPart",
						"settings": {
							"content": {
								"options": {
									"chart": {
										"metrics": [
											{
												"resourceMetadata": {
													"id": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-postgres-rg/providers/Microsoft.DBforPostgreSQL/servers/${prefix}-postgresql"
												},
												"name": "cpu_percent",
												"aggregationType": 3,
												"namespace": "microsoft.dbforpostgresql/servers",
												"metricVisualization": {
													"displayName": "CPU percent"
												}
											},
											{
												"resourceMetadata": {
													"id": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-postgres-rg/providers/Microsoft.DBforPostgreSQL/servers/${prefix}-postgresql"
												},
												"name": "storage_percent",
												"aggregationType": 3,
												"namespace": "microsoft.dbforpostgresql/servers",
												"metricVisualization": {
													"displayName": "Storage percent"
												}
											},
											{
												"resourceMetadata": {
													"id": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-postgres-rg/providers/Microsoft.DBforPostgreSQL/servers/${prefix}-postgresql"
												},
												"name": "memory_percent",
												"aggregationType": 3,
												"namespace": "microsoft.dbforpostgresql/servers",
												"metricVisualization": {
													"displayName": "Memory percent"
												}
											}
										],
										"title": "Max CPU percent, Max Storage percent, and Max Memory percent for ${prefix}-postgresql",
										"titleKind": 1,
										"visualization": {
											"chartType": 2,
											"legendVisualization": {
												"isVisible": true,
												"position": 2,
												"hideSubtitle": false
											},
											"axisVisualization": {
												"x": {
													"isVisible": true,
													"axisType": 2
												},
												"y": {
													"isVisible": true,
													"axisType": 1
												}
											},
											"disablePinning": true
										}
									}
								}
							}
						},
						"filters": {
							"MsPortalFx_TimeRange": {
								"model": {
									"format": "local",
									"granularity": "auto",
									"relative": "1440m"
								}
							}
						}
					}
				},
				"44": {
					"position": {
						"x": 0,
						"y": 69,
						"colSpan": 14,
						"rowSpan": 1
					},
					"metadata": {
						"inputs": [],
						"type": "Extension/HubsExtension/PartType/MarkdownPart",
						"settings": {
							"content": {
								"settings": {
									"content": "",
									"title": "Utilities",
									"subtitle": "",
									"markdownSource": 1
								}
							}
						}
					}
				},
				"45": {
					"position": {
						"x": 0,
						"y": 70,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "ComponentId",
								"value": "/subscriptions/${subscription_id}/resourceGroups/${prefix}-monitor-rg/providers/Microsoft.Insights/components/${prefix}-appinsights"
							}
						],
						"type": "Extension/AppInsightsExtension/PartType/AppMapGalPt",
						"settings": {},
						"asset": {
							"idInputName": "ComponentId",
							"type": "ApplicationInsights"
						}
					}
				},
				"46": {
					"position": {
						"x": 7,
						"y": 70,
						"colSpan": 7,
						"rowSpan": 4
					},
					"metadata": {
						"inputs": [
							{
								"name": "resourceTypeMode",
								"isOptional": true
							},
							{
								"name": "ComponentId",
								"isOptional": true
							},
							{
								"name": "Scope",
								"value": {
									"resourceIds": [
										"/subscriptions/${subscription_id}/resourceGroups/${prefix}-vnet-rg/providers/Microsoft.Network/applicationGateways/${prefix}-app-gw"
									]
								},
								"isOptional": true
							},
							{
								"name": "PartId",
								"isOptional": true
							},
							{
								"name": "Version",
								"value": "2.0",
								"isOptional": true
							},
							{
								"name": "TimeRange",
								"value": "P1D",
								"isOptional": true
							},
							{
								"name": "DashboardId",
								"isOptional": true
							},
							{
								"name": "DraftRequestParameters",
								"value": {
									"scope": "hierarchy"
								},
								"isOptional": true
							},
							{
								"name": "Query",
								"value": "AzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\" and ( httpStatus_d < 300 or httpStatus_d == 404) and requestUri_s != \"dummy\" and requestUri_s != \"/spid/v1/metadata\"\n| summarize n_success = toreal(count()) by bin(TimeGenerated, 1h), resourcePath = substring(requestUri_s, 0, case(indexof(requestUri_s, \"/\", 0, -1, 4) >= 0,indexof(requestUri_s, \"/\", 0, -1, 4), indexof(requestUri_s, \"/\", 0, -1, 4) <0, strlen(requestUri_s), 0))\n| join kind=inner (\nAzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\" and requestUri_s != \"dummy\" and requestUri_s != \"/spid/v1/metadata\"\n| summarize n_total = toreal(count()) by bin(TimeGenerated, 1h), resourcePath = substring(requestUri_s, 0, case(indexof(requestUri_s, \"/\", 0, -1, 4) >= 0,indexof(requestUri_s, \"/\", 0, -1, 4), indexof(requestUri_s, \"/\", 0, -1, 4) <0, strlen(requestUri_s), 0))\n) on TimeGenerated, resourcePath\n| project TimeGenerated, resourcePath, availability=(n_success/n_total)*100, watermark=99.9\n| render columnchart  with ( ymax=100, kind=unstacked  ) \n\n",
								"isOptional": true
							},
							{
								"name": "ControlType",
								"value": "FrameControlChart",
								"isOptional": true
							},
							{
								"name": "SpecificChart",
								"value": "UnstackedColumn",
								"isOptional": true
							},
							{
								"name": "PartTitle",
								"value": "Analytics",
								"isOptional": true
							},
							{
								"name": "PartSubTitle",
								"value": "${prefix}-app-gw",
								"isOptional": true
							},
							{
								"name": "Dimensions",
								"value": {
									"xAxis": {
										"name": "TimeGenerated",
										"type": "datetime"
									},
									"yAxis": [
										{
											"name": "availability",
											"type": "real"
										}
									],
									"splitBy": [
										{
											"name": "resourcePath",
											"type": "string"
										}
									],
									"aggregation": "Sum"
								},
								"isOptional": true
							},
							{
								"name": "LegendOptions",
								"value": {
									"isEnabled": true,
									"position": "Bottom"
								},
								"isOptional": true
							},
							{
								"name": "IsQueryContainTimeRange",
								"value": false,
								"isOptional": true
							}
						],
						"type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
						"settings": {
							"content": {
								"Query": "AzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\" and ( httpStatus_d < 300 or httpStatus_d == 404) and requestUri_s != \"dummy\" and requestUri_s != \"/spid/v1/metadata\"\n| summarize n_success = toreal(count()) by bin(TimeGenerated, 15m), resourcePath = substring(requestUri_s, 0, case(indexof(requestUri_s, \"/\", 0, -1, 4) >= 0,indexof(requestUri_s, \"/\", 0, -1, 4), indexof(requestUri_s, \"/\", 0, -1, 4) <0, strlen(requestUri_s), 0))\n| join kind=inner (\nAzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\" and requestUri_s != \"dummy\" and requestUri_s != \"/spid/v1/metadata\"\n| summarize n_total = toreal(count()) by bin(TimeGenerated, 15m), resourcePath = substring(requestUri_s, 0, case(indexof(requestUri_s, \"/\", 0, -1, 4) >= 0,indexof(requestUri_s, \"/\", 0, -1, 4), indexof(requestUri_s, \"/\", 0, -1, 4) <0, strlen(requestUri_s), 0))\n) on TimeGenerated, resourcePath\n| project TimeGenerated, resourcePath, availability=(n_success/n_total)*100, watermark=99.9\n| render columnchart  with ( ymax=100, kind=unstacked  ) \n\n",
								"SpecificChart": "Line",
								"PartTitle": "Availability single MS | 4hours",
								"PartSubTitle": "step 15m",
								"LegendOptions": {
									"isEnabled": true,
									"position": "Right"
								}
							}
						},
						"filters": {
							"MsPortalFx_TimeRange": {
								"model": {
									"format": "utc",
									"granularity": "15m",
									"relative": "4h"
								}
							}
						},
						"partHeader": {
							"title": "Availability single API | Last 4 hours",
							"subtitle": "Step 15m"
						}
					}
				}
			}
		}
	},
	"metadata": {
		"model": {
			"timeRange": {
				"value": {
					"relative": {
						"duration": 24,
						"timeUnit": 1
					}
				},
				"type": "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
			},
			"filterLocale": {
				"value": "en-us"
			},
			"filters": {
				"value": {
					"MsPortalFx_TimeRange": {
						"model": {
							"format": "utc",
							"granularity": "auto",
							"relative": "24h"
						},
						"displayCache": {
							"name": "UTC Time",
							"value": "Past 24 hours"
						}
					}
				}
			}
		}
	}
}