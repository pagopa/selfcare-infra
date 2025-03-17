#!/bin/bash
# filepath: restart-container-apps.sh
RESOURCE_GROUP="selc-p-container-app-rg"

# Recupera tutte le container app nel gruppo di risorse
APPS=$(az containerapp list --resource-group $RESOURCE_GROUP --query "[].name" -o tsv)

# Riavvia ogni app
for APP in $APPS; do
  echo "Riavvio di $APP..."
  az containerapp update --name $APP --resource-group $RESOURCE_GROUP --set-env-vars "jwt=$(date +%s)"
done

# jwt_f9:eb:0a:6a:6c:f0:22:2c:42:59:00:80:6d:48:e6:b4 
