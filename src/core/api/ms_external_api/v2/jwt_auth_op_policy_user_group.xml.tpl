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
        <set-backend-service base-url="${USER_GROUP_BACKEND_BASE_URL}" />
        <rewrite-uri template="/" />
        <set-query-parameter name="productId" exists-action="override">
            <value>@((string)context.Variables["productId"])</value>
        </set-query-parameter>
    </inbound>
    <backend>
        <base/>
    </backend>
    <outbound>
        <base/>
        <choose>
            <when condition="@(context.Response.StatusCode == 200)">
                <set-body>@{
                    JObject response = context.Response.Body.As<JObject>();
                    foreach(JObject item in response.GetValue("content").Children()) {
                    foreach (var key in new [] {"members", "createdAt", "createdBy", "modifiedAt", "modifiedBy"}) {
                    try {
                    item.Property(key).Remove();
                    } catch (Exception ex) {
                    // do nothing
                    }
                    }
                    }
                    return response.ToString();
                    }
                </set-body>
            </when>
        </choose>
    </outbound>
    <on-error>
        <base/>
    </on-error>
</policies>