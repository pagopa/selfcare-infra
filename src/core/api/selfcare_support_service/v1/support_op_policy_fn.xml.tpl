<policies>
    <inbound>
        <base />
        <set-variable name="fnkey" value="${FN_KEY}" />
        <set-header name="X-FUNCTIONS-KEY" exists-action="override">
            <value>@((string)context.Variables["fnkey"])</value>
        </set-header>
        <set-backend-service base-url="${BACKEND_BASE_URL}" />
    </inbound>
    <backend>
        <forward-request timeout="240" />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
