#!/bin/bash

# Variabili
RESOURCE_GROUP="selc-d-container-app-002-rg"
ENVIRONMENT_NAME="selc-d-cae-002"

# Ottieni tutti i Container Apps nell'environment
echo "🔍 Recupero Container Apps dall'environment: $ENVIRONMENT_NAME"
CONTAINER_APPS=$(az containerapp list \
  --resource-group $RESOURCE_GROUP \
  --query "[?contains(properties.environmentId, '$ENVIRONMENT_NAME')].name" \
  --output tsv)

if [ -z "$CONTAINER_APPS" ]; then
  echo "❌ Nessun Container App trovato nell'environment $ENVIRONMENT_NAME"
  exit 1
fi

# Riavvia ogni Container App
for app in $CONTAINER_APPS; do
  echo "🔄 Riavviando Container App: $app"
  # az containerapp restart \
  #   --name $app \
  #   --resource-group $RESOURCE_GROUP
  
  if [ $? -eq 0 ]; then
    echo "✅ $app riavviato con successo"
  else
    echo "❌ Errore nel riavvio di $app"
  fi
  echo ""
done

echo "🎉 Processo di riavvio completato!"