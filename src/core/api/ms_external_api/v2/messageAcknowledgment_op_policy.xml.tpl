<policies>
    <inbound>
        <base/>
           <choose>
                    <when condition="@(((string)context.Variables["productId"]).Contains("prod-fd"))">
                        <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="false" require-scheme="Bearer" require-signed-tokens="true">
                            <openid-config url="https://login.microsoftonline.com/${TENANT_ID}/.well-known/openid-configuration" />
                            <required-claims>
                                <claim name="aud" match="all">
                                    <value>${EXTERNAL-OAUTH2-ISSUER}</value>
                                </claim>
                            </required-claims>
                        </validate-jwt>
                        <set-header name="Authorization" exists-action="override">
                            <value>Bearer {{backend-access-token}}</value>
                        </set-header>
                    </when>
                </choose>
        <set-backend-service base-url="${MS_EXTERNAL_INTERCEPTOR_BACKEND_BASE_URL}" />
        <rewrite-uri template="@("/interceptor/acknowledgment/" + (string)context.Variables["productId"] + "/message/{messageId}/status/{status}")" />
    </inbound>
    <backend>
        <base/>
    </backend>
    <on-error>
        <base/>
    </on-error>
</policies>
