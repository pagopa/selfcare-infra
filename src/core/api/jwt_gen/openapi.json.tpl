{
    "openapi": "3.0.1",
    "info": {
        "title": "jwt-gen",
        "description": "",
        "version": "1.0"
    },
    "servers": [{
        "url": "https://${host}"
    }],
    "paths": {
        "/": {
            "get": {
                "summary": "GET",
                "operationId": "get",
                "parameters": [
                  {
                    "name": "uid",
                    "in": "header",
                    "description": "User UID",
                    "required": true,
                    "allowReserved": false,
                    "schema": { "type": "string" }
                  }
                ],
                "responses": {
                    "200": {
                        "description": null
                    }
                }
            }
        }
    },
    "components": {
        "securitySchemes": {
            "apiKeyHeader": {
                "type": "apiKey",
                "name": "Ocp-Apim-Subscription-Key",
                "in": "header"
            },
            "apiKeyQuery": {
                "type": "apiKey",
                "name": "subscription-key",
                "in": "query"
            }
        }
    },
    "security": [{
        "apiKeyHeader": []
    }, {
        "apiKeyQuery": []
    }]
}
