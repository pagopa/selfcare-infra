<policies>
    <inbound>
        <base />
        <set-header name="X-Forwarded-For" exists-action="override">
            <value>@{ 
            string headerValue = context.Request.Headers.GetValueOrDefault("x-forwarded-for",""); 
            string[] sourceIP = headerValue.Split(':'); 
            if(sourceIP.Length == 2) { headerValue = sourceIP[0]; } 
            return headerValue; }</value>
        </set-header>
        <check-header name="X-Forwarded-For" failed-check-httpcode="403" failed-check-error-message="Unauthorized IP Address" ignore-case="true">
            <value>93.63.219.230</value>
            <value>93.63.219.232</value>
            <value>93.63.219.234</value>
        </check-header>
        <set-variable name="jwt" value="@{
            // 1) Construct the Base64Url-encoded header
            var header = new { typ = "JWT", alg = "RS256", kid = "${KID}" };
            var jwtHeaderBase64UrlEncoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(header))).Replace("/", "_").Replace("+", "-"). Replace("=", "");
            // As the header is a constant, you may use this equivalent Base64Url-encoded string instead to save the repetitive computation above.
            // var jwtHeaderBase64UrlEncoded = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9";

            // 2) Construct the Base64Url-encoded payload
            var iat = new DateTimeOffset(DateTime.Now).ToUnixTimeSeconds();  // sets the expiration of the token to be 30 seconds from now
            var exp = new DateTimeOffset(DateTime.Now.AddMinutes(30)).ToUnixTimeSeconds();  // sets the expiration of the token to be 30 seconds from now
            var uid = "m2m";


            var aud = "${API_DOMAIN}";
            var iss = "SPID";
            var name = "apim";
            var payload = new { name, exp, uid, aud, iss , iat};
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

            }"/>
        <set-header name="Authorization" exists-action="override">
            <value>@((string)context.Variables["jwt"])</value>
        </set-header>
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
