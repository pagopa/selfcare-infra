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
    <outbound>
        <base/>
        <choose>
            <when condition="@(context.Response.StatusCode == 200)">
                <set-body>@{
                    JObject response = context.Response.Body.As<JObject>();
                    response.Add("logo", new JValue(new Uri("${CDN_STORAGE_URL}/institutions/" + response.GetValue("id") + "/logo.png")));
                    return response.ToString();
                    }</set-body>
            </when>
        </choose>
    </outbound>
    <on-error>
        <base/>
    </on-error>
</policies>