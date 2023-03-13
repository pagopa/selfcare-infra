<policies>
  <inbound>
    <base/>
    <set-header name="x-selfcare-uid" exists-action="override">
      <value>"onboarding-io"</value>
    </set-header>
    <set-header exists-action="override" name="Authorization">
                <value>@((string)context.Variables["jwt"])</value>
    </set-header>
  </inbound>
  <backend>
    <base/>
  </backend>
  <outbound>
    <base/>
  </outbound>
  <on-error>
    <base/>
  </on-error>
</policies>
