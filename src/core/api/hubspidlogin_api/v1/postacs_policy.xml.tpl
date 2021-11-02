<policies>
  <inbound>
    <cors>
      <allowed-origins>
        %{ for origin in origins ~}
        <origin>${origin}</origin>
        %{ endfor ~}
      </allowed-origins>
    </cors>
    <base />
  </inbound>
</policies>
