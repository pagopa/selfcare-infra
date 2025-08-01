#!/bin/bash

# Script per riavviare tutti i Container Apps in un environment specifico
# Uso: ./restart_container_apps.sh [ENVIRONMENT_NAME] [RESOURCE_GROUP]

# Funzione di aiuto
show_help() {
    echo "Uso: $0 [ENVIRONMENT_NAME] [RESOURCE_GROUP]"
    echo ""
    echo "Parametri:"
    echo "  ENVIRONMENT_NAME    Nome dell'environment (es: selc-ENV-cae-002)"
    echo "  RESOURCE_GROUP      Nome del resource group (opzionale)"
    echo ""
    echo "Esempi:"
    echo "  $0 selc-ENV-cae-002"
    echo "  $0 selc-ENV-cae-002 selc-ENV-container-app-002-rg"
    echo ""
    echo "Variabili d'ambiente supportate:"
    echo "  ENVIRONMENT         Nome dell'environment"
    echo "  RESOURCE_GROUP      Nome del resource group"
    echo "  WAIT_TIME          Secondi di attesa durante lo scaling (default: 10)"
}

# Gestione parametri e variabili d'ambiente
ENVIRONMENT_NAME="${1:-${ENVIRONMENT}}"
RESOURCE_GROUP="${2:-${RESOURCE_GROUP}}"
WAIT_TIME="${WAIT_TIME:-10}"

# Validazione parametri
if [ -z "$ENVIRONMENT_NAME" ]; then
    echo "❌ Errore: ENVIRONMENT_NAME è richiesto"
    echo ""
    show_help
    exit 1
fi


echo "✅ Environment: $ENVIRONMENT_NAME"
echo "📂 Resource Group: $RESOURCE_GROUP"
echo "⏱️  Tempo di attesa: ${WAIT_TIME}s"
echo ""

# Funzione per il riavvio di un singolo Container App
restart_container_app() {
    local app_name=$1
    
    echo "🔄 Riavvio Container App: $app_name"
    
    az containerapp update --name $app --resource-group $RESOURCE_GROUP --set-env-vars "RESTART_TIMESTAMP=$(date +%s)"

    echo "  ⏳ Attendo ${WAIT_TIME} secondi..."
    sleep "$WAIT_TIME"
    
    if [ $? -eq 0 ]; then
        echo "✅ $app riavviato con successo"
    else
        echo "❌ Errore nel riavvio di $app"
    fi
    return 0
}

# Recupera tutti i Container Apps nell'environment
echo "🔍 Recupero Container Apps dall'environment: $ENVIRONMENT_NAME"

CONTAINER_APPS=$(az containerapp list \
    --resource-group "$RESOURCE_GROUP" \
    --query "[?contains(properties.environmentId, '$ENVIRONMENT_NAME')].name" \
    --output tsv 2>/dev/null)

if [ -z "$CONTAINER_APPS" ]; then
    echo "❌ Nessun Container App trovato nell'environment $ENVIRONMENT_NAME"
    exit 1
fi

# Conta i Container Apps
APP_COUNT=$(echo "$CONTAINER_APPS" | wc -l)
echo "📋 Trovati $APP_COUNT Container Apps:"
echo "$CONTAINER_APPS" | sed 's/^/  - /'
echo ""

read -p "🤔 Vuoi procedere con il riavvio di tutti i Container Apps? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Operazione annullata dall'utente"
    exit 0
fi
echo ""

# Riavvia ogni Container App
failed_apps=()
success_count=0

for app in $CONTAINER_APPS; do
    if restart_container_app "$app"; then
        success_count=$((success_count + 1))
    else
        failed_apps+=("$app")
    fi
    echo ""
done

# Riepilogo finale
echo "📊 RIEPILOGO:"
echo "  ✅ Container Apps riavviati con successo: $success_count/$APP_COUNT"

if [ ${#failed_apps[@]} -gt 0 ]; then
    echo "  ❌ Container Apps falliti:"
    printf '    - %s\n' "${failed_apps[@]}"
    echo ""
    echo "🚨 Alcuni riavvii sono falliti. Controlla i logs per maggiori dettagli."
    exit 1
else
    echo ""
    echo "🎉 Tutti i Container Apps sono stati riavviati con successo!"
fi

# Mostra comando per monitorare i logs
echo ""
echo "💡 Per monitorare i logs:"
echo "   az containerapp logs show --name <app-name> --resource-group $RESOURCE_GROUP --follow"