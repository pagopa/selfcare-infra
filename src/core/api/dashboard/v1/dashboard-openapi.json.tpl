{
  "openapi": "3.0.3",
  "info": {
    "title": "selc-dashboard",
    "description": "Self Care Dashboard API documentation",
    "version": "0.0.1-SNAPSHOT"
  },
  "servers": [
    {
      "url": 'https://${host}/${basePath}',
      "description": "Inferred Url"
    }
  ],
  "tags": [
    {
      "name": "institutions",
      "description": "Institution operations"
    },
    {
      "name": "products",
      "description": "Product operations"
    }
  ],
  "paths": {
    "/institutions/{institutionId}": {
      "get": {
        "tags": [
          "institutions"
        ],
        "summary": "getInstitution",
        "description": "The service allows the recovery of an Entity based on its id",
        "operationId": "getInstitutionUsingGET",
        "parameters": [
          {
            "name": "institutionId",
            "in": "path",
            "description": "Institution's unique identifier",
            "required": true,
            "style": "simple",
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "x-selc-institutionId",
            "in": "header",
            "description": "Institution's unique identifier",
            "required": true,
            "allowReserved": false,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/InstitutionResource"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden"
          },
          "404": {
            "description": "Not Found"
          }
        },
        "security": [
          {
            "bearerAuth": [
              "global"
            ]
          }
        ]
      }
    },
    "/institutions/{institutionId}/logo": {
      "put": {
        "tags": [
          "institutions"
        ],
        "summary": "saveInstitutionLogo",
        "description": "Service to upload and store the institution's logo",
        "operationId": "saveInstitutionLogoUsingPUT",
        "parameters": [
          {
            "name": "institutionId",
            "in": "path",
            "description": "swagger.dashboard.model.id",
            "required": true,
            "style": "simple",
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "x-selc-institutionId",
            "in": "header",
            "description": "Institution's unique identifier",
            "required": true,
            "allowReserved": false,
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "required": [
                  "logo"
                ],
                "type": "object",
                "properties": {
                  "logo": {
                    "type": "string",
                    "description": "Institution's logo",
                    "format": "binary"
                  }
                }
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "object"
                }
              },
              "multipart/form-data": {
                "schema": {
                  "type": "object"
                }
              }
            }
          },
          "201": {
            "description": "Created"
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden"
          },
          "404": {
            "description": "Not Found"
          }
        },
        "security": [
          {
            "bearerAuth": [
              "global"
            ]
          }
        ]
      }
    },
    "/products/": {
      "get": {
        "tags": [
          "products"
        ],
        "summary": "getProducts",
        "description": "Service that returns the list of PagoPA products",
        "operationId": "getProductsUsingGET",
        "parameters": [
          {
            "name": "x-selc-institutionId",
            "in": "header",
            "description": "Institution's unique identifier",
            "required": true,
            "allowReserved": false,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/ProductsResource"
                  }
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden"
          },
          "404": {
            "description": "Not Found"
          }
        },
        "security": [
          {
            "bearerAuth": [
              "global"
            ]
          }
        ]
      }
    }
  },
  "components": {
    "schemas": {
      "InstitutionResource": {
        "title": "InstitutionResource",
        "required": [
          "IPACode",
          "category",
          "fiscalCode",
          "id",
          "mailAddress",
          "name",
          "status",
          "userRole"
        ],
        "type": "object",
        "properties": {
          "IPACode": {
            "type": "string",
            "description": "IPA code"
          },
          "category": {
            "type": "string",
            "description": "Institution's category"
          },
          "fiscalCode": {
            "type": "string",
            "description": "Fiscal code corresponding to the institution"
          },
          "id": {
            "type": "string",
            "description": "Institution's unique identifier"
          },
          "mailAddress": {
            "type": "string",
            "description": "Institution's email address"
          },
          "name": {
            "type": "string",
            "description": "Institution's name"
          },
          "status": {
            "type": "string",
            "description": "Institution's status"
          },
          "userRole": {
            "type": "string",
            "description": "Logged user's role"
          }
        }
      },
      "ProductsResource": {
        "title": "ProductsResource",
        "required": [
          "activationDateTime",
          "active",
          "authorized",
          "code",
          "id",
          "title",
          "urlBO"
        ],
        "type": "object",
        "properties": {
          "activationDateTime": {
            "type": "string",
            "description": "Date the products was activated/created",
            "format": "date-time"
          },
          "active": {
            "type": "boolean",
            "description": "flag indicating whether the institution has a valid contract related to the product",
            "example": false
          },
          "authorized": {
            "type": "boolean",
            "description": "flag indicating whether the logged user has the authorization to manage the product",
            "example": false
          },
          "code": {
            "type": "string",
            "description": "Product's code"
          },
          "description": {
            "type": "string",
            "description": "Product's description"
          },
          "id": {
            "type": "string",
            "description": "Product's unique identifier"
          },
          "logo": {
            "type": "string",
            "description": "Product's logo"
          },
          "title": {
            "type": "string",
            "description": "Product's title"
          },
          "urlBO": {
            "type": "string",
            "description": "URL that redirects to the back-office section, where is possible to manage the product"
          },
          "urlPublic": {
            "type": "string",
            "description": "URL that redirects to the public information webpage of the product"
          }
        }
      }
    },
    "securitySchemes": {
      "bearerAuth": {
        "type": "http",
        "description": "A bearer token in the format of a JWS and conformed to the specifications included in [RFC8725](https://tools.ietf.org/html/RFC8725)",
        "scheme": "bearer",
        "bearerFormat": "JWT"
      }
    }
  }
}