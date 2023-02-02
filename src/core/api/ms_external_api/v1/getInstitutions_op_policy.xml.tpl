<policies>
    <inbound>
        <base/>
        <set-header name="Authorization" exists-action="override">
            <value>@((string)context.Variables["jwt"])</value>
        </set-header>
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
