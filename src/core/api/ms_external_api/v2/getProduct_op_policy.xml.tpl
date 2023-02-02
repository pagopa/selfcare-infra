<policies>
    <inbound>
        <base/>
        <set-backend-service base-url="${MS_PRODUCT_BACKEND_BASE_URL}" />
        <rewrite-uri template="@("/products/" + (string)context.Variables["productId"])" />
    </inbound>
    <backend>
        <base/>
    </backend>
    <on-error>
        <base/>
    </on-error>
</policies>