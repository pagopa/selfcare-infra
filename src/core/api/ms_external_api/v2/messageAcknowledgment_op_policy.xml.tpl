<policies>
    <inbound>
        <base/>
        <set-backend-service base-url="${MS_EXTERNAL_INTERCEPTOR_BACKEND_BASE_URL}" />
        <rewrite-uri template="@("/acknowledgment/" + (string)context.Variables["productId"] + "/message/{messageId}/status/{status}")" />
    </inbound>
    <backend>
        <base/>
    </backend>
    <on-error>
        <base/>
    </on-error>
</policies>
