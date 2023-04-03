<policies>
    <inbound>
        <base/>
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
                    JArray response = context.Response.Body.As<JArray>();
                    foreach(JObject item in response.Children()) {
                    item.Add("logo", new JValue(new Uri("${CDN_STORAGE_URL}/institutions/" + item.GetValue("id") + "/logo.png")));
                    }
                    return response.ToString();
                    }</set-body>
            </when>
        </choose>
    </outbound>
    <on-error>
        <base/>
    </on-error>
</policies>
