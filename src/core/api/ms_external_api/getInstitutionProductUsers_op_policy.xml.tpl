<policies>
    <inbound>
        <base/>
        <set-header exists-action="override" name="Authorization">
            <value>@((string)context.Variables["jwt"])</value>
        </set-header>
        <set-backend-service base-url="${MS_SELFCARE_DASHBOARD_BACKEND_BASE_URL}" />
    </inbound>
    <backend>
        <base/>
    </backend>
    <outbound>
        <base />
        <choose>
            <when condition="@(context.Response.StatusCode == 200)">
                <set-body>@{
                    JArray response = context.Response.Body.As<JArray>();
                    foreach(JObject item in response.Children())
                    {
                        List<string> roles = new List<string>();
                        var roleInfos = item["product"]["roleInfos"];
                        foreach(var role in roleInfos){
                        roles.Add(role["role"].ToString());
                        }
                        
                        foreach (var key in new [] {"id", "role", "product"}) 
                        {
                            try {
                            item.Property(key).Remove();
                            } catch (Exception ex) {
                            // do nothing
                            }
                        }
                        
                        item.Add("roles", new JArray(roles.ToArray()));
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
