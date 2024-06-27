<policies>
    <inbound>
        <base/>
        <set-header name="x-functions-key" exists-action="override">
            <value>@(${FN_KEY})</value>
        </set-header>
        <set-backend-service base-url="${BACKEND_BASE_URL}" />
    </inbound>
    <backend>
        <forward-request timeout="240"/>
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base/>
    </on-error>
</policies>
