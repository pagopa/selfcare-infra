<policies>
    <inbound>
        <base />
        <return-response response-variable-name="existing response variable">
            <set-status code="200" reason="OK" />
            <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
            </set-header>
            <set-body>@{
                // 1) Construct the Base64Url-encoded header
                var header = new { typ = "JWT", alg = "RS256", kid = "${KID}" };
                var jwtHeaderBase64UrlEncoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(header))).Replace("/", "_").Replace("+", "-"). Replace("=", "");
                // As the header is a constant, you may use this equivalent Base64Url-encoded string instead to save the repetitive computation above.
                // var jwtHeaderBase64UrlEncoded = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9";

                // 2) Construct the Base64Url-encoded payload
                // TODO config duration
                var exp = new DateTimeOffset(DateTime.Now.AddMinutes(10)).ToUnixTimeSeconds();  // sets the expiration of the token to be 10 minutes from now
                // TODO read uid from Headers
                var uid = "9b17ce70-f79f-42d9-8b0e-4e7eb4d88074";
                // var fiscal_number = "SRTNLM09T06G635S";
                var payload = new { exp, uid };
                var jwtPayloadBase64UrlEncoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(payload))).Replace("/", "_").Replace("+", "-"). Replace("=", "");

                // 3) Construct the Base64Url-encoded signature
                using (RSA rsa = context.Deployment.Certificates["${JWT_CERTIFICATE_THUMBPRINT}"].GetRSAPrivateKey())
                {
                byte[] data2sign = Encoding.UTF8.GetBytes($"{jwtHeaderBase64UrlEncoded}.{jwtPayloadBase64UrlEncoded}");
                var signature = rsa.SignData(data2sign, HashAlgorithmName.SHA256, RSASignaturePadding.Pkcs1);;
                var jwtSignatureBase64UrlEncoded = Convert.ToBase64String(signature).Replace("/", "_").Replace("+", "-"). Replace("=", "");

                // 4) Return the HMAC SHA256-signed JWT as the value for the Authorization header
                return $"Bearer {jwtHeaderBase64UrlEncoded}.{jwtPayloadBase64UrlEncoded}.{jwtSignatureBase64UrlEncoded}";
                }

                }</set-body>
        </return-response>
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>