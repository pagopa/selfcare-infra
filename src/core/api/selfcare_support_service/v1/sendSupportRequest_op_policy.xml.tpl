<policies>
    <inbound>
        <base />
        <set-variable name="jwt" value="@{
            // 1) Construct the Base64Url-encoded header
            var header = new { typ = "JWT", alg = "RS256", kid = "jwt_86:74:1e:35:ae:a6:d8:4b:dc:e9:fc:8e:a0:35:68:b5" };
            var jwtHeaderBase64UrlEncoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(header))).Replace("/", "_").Replace("+", "-"). Replace("=", "");
            // As the header is a constant, you may use this equivalent Base64Url-encoded string instead to save the repetitive computation above.
            // var jwtHeaderBase64UrlEncoded = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9";

            // 2) Construct the Base64Url-encoded payload
            var exp = new DateTimeOffset(DateTime.Now.AddMinutes(30)).ToUnixTimeSeconds();  // sets the expiration of the token to be 30 seconds from now
            var uid = "support";
            var aud = "api.dev.selfcare.pagopa.it";
            var iss = "SPID";
            var payload = new { exp, uid, aud, iss };
            var jwtPayloadBase64UrlEncoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(payload))).Replace("/", "_").Replace("+", "-"). Replace("=", "");

            // 3) Construct the Base64Url-encoded signature
            using (RSA rsa = context.Deployment.Certificates["4A5DDC246FDF60853E82A1A99FD564C8D848621F"].GetRSAPrivateKey())
            {
            byte[] data2sign = Encoding.UTF8.GetBytes($"{jwtHeaderBase64UrlEncoded}.{jwtPayloadBase64UrlEncoded}");
            var signature = rsa.SignData(data2sign, HashAlgorithmName.SHA256, RSASignaturePadding.Pkcs1);;
            var jwtSignatureBase64UrlEncoded = Convert.ToBase64String(signature).Replace("/", "_").Replace("+", "-"). Replace("=", "");

            // 4) Return the HMAC SHA256-signed JWT as the value for the Authorization header
            return $"Bearer {jwtHeaderBase64UrlEncoded}.{jwtPayloadBase64UrlEncoded}.{jwtSignatureBase64UrlEncoded}";
            }

            }" />
        <set-header name="Authorization" exists-action="override">
            <value>@((string)context.Variables["jwt"])</value>
        </set-header>
        <set-backend-service base-url="${BACKEND_BASE_URL}" />
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
