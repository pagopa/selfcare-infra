<policies>
    <inbound>
        <base/>
        <set-header exists-action="override" name="Authorization">
            <value>@((string)context.Variables["jwt"])</value>
        </set-header>
        <set-backend-service base-url="${USER_GROUP_BACKEND_BASE_URL}" />
        <rewrite-uri template="/" />
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