<policies>
    <inbound>
        <base/>
        <set-header exists-action="override" name="Authorization">
            <value>@((string)context.Variables["jwt"])</value>
        </set-header>
        <set-backend-service base-url="${MS_PRODUCT_BACKEND_BASE_URL}" />
    </inbound>
    <backend>
        <base/>
    </backend>
    <on-error>
        <base/>
    </on-error>
</policies>