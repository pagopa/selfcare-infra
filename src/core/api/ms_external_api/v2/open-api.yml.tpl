{
  "openapi": "3.0.3",
  "info": {
    "title": "selc-ms-core",
    "version": "1.0-SNAPSHOT"
  },
  "servers": [
    {
      "url": "{url}:{port}{basePath}",
      "variables": {
        "url": {
          "default": "http://localhost"
        },
        "port": {
          "default": "80"
        },
        "basePath": {
          "default": ""
        }
      }
    }
  ],
  "tags": [
    {
      "name": "Delegation",
      "description": "Delegation Controller"
    },
    {
      "name": "External",
      "description": "External Controller"
    },
    {
      "name": "Institution",
      "description": "Institution Controller"
    },
    {
      "name": "Management",
      "description": "Management Controller"
    },
    {
      "name": "Migration",
      "description": "Crud Controller"
    },
    {
      "name": "Onboarding",
      "description": "Onboarding Controller"
    },
    {
      "name": "Persons",
      "description": "User Controller"
    },
    {
      "name": "Token",
      "description": "Token Controller"
    },
    {
      "name": "scheduler",
      "description": "Scheduler Controller"
    },
    {
      "name": "institutions",
      "description": "Instituions operations"
    },
    {
      "name": "institutions-pnpg",
      "description": "Pn Pg Controller"
    },
    {
      "name": "onboarding",
      "description": "Onboarding operations"
    },
    {
      "name": "product",
      "description": "Products operations"
    },
    {
      "name": "users",
      "description": "User Controller"
    },
    {
      "name": "delegations",
      "description": "Delegation Controller"
    },
    {
      "name": "pnPGInstitutions",
      "description": "PN PG Institution operations"
    },
    {
      "name": "products",
      "description": "Products operations"
    },
    {
      "name": "relationships",
      "description": "Relationships operations"
    },
    {
      "name": "support",
      "description": "Support Controller"
    },
    {
      "name": "token",
      "description": "Token operations"
    },
    {
      "name": "user",
      "description": "User Controller"
    },
    {
      "name": "user-groups",
      "description": "UserGroups operations"
    },
    {
      "name": "user-group",
      "description": "User group endpoint CRUD operations"
    },
    {
      "name": "interceptor",
      "description": "Interceptor operations"
    }
  ],
  "paths": {
    "/institutions": {
      "get": {
        "tags": [
          "external-v2"
        ],
        "summary": "getInstitutions",
        "description": "The service retrieves all the onboarded institutions related to the logged user",
        "operationId": "getInstitutionsUsingGET",
        "parameters": [
          {
            "name": "productId",
            "in": "query",
            "description": "Product's unique identifier",
            "required": true,
            "style": "form",
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
                    "$ref": "#/components/schemas/InstitutionResource"
                  }
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
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
    "/institutions/byGeoTaxonomies": {
      "get": {
        "tags": [
          "external-v2"
        ],
        "summary": "getInstitutionsByGeoTaxonomies",
        "description": "The service retrieves all the institutions based on given a list of geotax ids and a searchMode",
        "operationId": "getInstitutionsByGeoTaxonomiesUsingGET",
        "parameters": [
          {
            "name": "geoTaxonomies",
            "in": "query",
            "description": "Geotaxonomy's internal Id",
            "required": true,
            "style": "form",
            "explode": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "searchMode",
            "in": "query",
            "description": "Searching mode to find institutions based on geotax",
            "required": false,
            "style": "form",
            "schema": {
              "type": "string",
              "enum": [
                "all",
                "any",
                "exact"
              ]
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
                    "$ref": "#/components/schemas/InstitutionDetailResource"
                  }
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
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
    "/institutions/{institutionId}/contract": {
      "get": {
        "tags": [
          "external-v2",
          "support"
        ],
        "summary": "getContract",
        "description": "Service to retrieve a contract given institutionId and productId",
        "operationId": "getContractUsingGET",
        "parameters": [
          {
            "name": "institutionId",
            "in": "path",
            "description": "Institution's unique internal Id",
            "required": true,
            "style": "simple",
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "productId",
            "in": "query",
            "description": "Product's unique identifier",
            "required": true,
            "style": "form",
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/octet-stream": {
                "schema": {
                  "type": "string",
                  "format": "byte"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
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
    "/institutions/{institutionId}/geographicTaxonomy": {
      "get": {
        "tags": [
          "external-v2"
        ],
        "summary": "getInstitutionGeographicTaxonomies",
        "description": "The service retrieve the institution's geographic taxonomy",
        "operationId": "getInstitutionGeographicTaxonomiesUsingGET",
        "parameters": [
          {
            "name": "institutionId",
            "in": "path",
            "description": "Institution's unique internal Id",
            "required": true,
            "style": "simple",
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
                    "$ref": "#/components/schemas/GeographicTaxonomyResource"
                  }
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
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
    "/institutions/{institutionId}/products": {
      "get": {
        "tags": [
          "external-v2"
        ],
        "summary": "getInstitutionUserProducts",
        "description": "Service to retrieve all active products for given institution and logged user",
        "operationId": "getInstitutionUserProductsUsingGET",
        "parameters": [
          {
            "name": "institutionId",
            "in": "path",
            "description": "Institution's unique internal Id",
            "required": true,
            "style": "simple",
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
                    "$ref": "#/components/schemas/ProductResource"
                  }
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
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
    "/institutions/{institutionId}/products/{productId}/users": {
      "get": {
        "tags": [
          "external-v2"
        ],
        "summary": "getInstitutionProductsUsers",
        "description": "Service to get all the active users related to a specific pair of institution-product",
        "operationId": "getInstitutionProductsUsersUsingGET",
        "parameters": [
          {
            "name": "institutionId",
            "in": "path",
            "description": "Institution's unique internal Id",
            "required": true,
            "style": "simple",
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "productId",
            "in": "path",
            "description": "Product's unique identifier",
            "required": true,
            "style": "simple",
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "userId",
            "in": "query",
            "description": "User's unique identifier",
            "required": false,
            "style": "form",
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "productRoles",
            "in": "query",
            "description": "User's roles in product",
            "required": false,
            "style": "form",
            "explode": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "x-selfcare-uid",
            "in": "header",
            "description": "x-selfcare-uid",
            "required": false,
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
                    "$ref": "#/components/schemas/UserResource"
                  }
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
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
    "/users": {
      "post": {
        "tags": [
          "external-v2",
          "support"
        ],
        "summary": "getUserInfo",
        "description": "Service to retrieve user info including institutions and products linked to him",
        "operationId": "getUserInfoUsingPOST",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/SearchUserDto"
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
                  "$ref": "#/components/schemas/UserInfoResource"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem1"
                }
              }
            }
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
    "/support": {
      "post": {
        "tags": [
          "support"
        ],
        "summary": "sendSupportRequest",
        "description": "Service to retrieve Support contact's form",
        "operationId": "sendSupportRequestUsingPOST",
        "parameters": [
          {
            "name": "authenticated",
            "in": "query",
            "required": false,
            "style": "form",
            "schema": {
              "type": "boolean"
            }
          },
          {
            "name": "authorities[0].authority",
            "in": "query",
            "required": false,
            "style": "form",
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "credentials",
            "in": "query",
            "required": false,
            "style": "form",
            "schema": {
              "type": "object"
            }
          },
          {
            "name": "details",
            "in": "query",
            "required": false,
            "style": "form",
            "schema": {
              "type": "object"
            }
          },
          {
            "name": "principal",
            "in": "query",
            "required": false,
            "style": "form",
            "schema": {
              "type": "object"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/SupportRequestDto"
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
                  "$ref": "#/components/schemas/SupportResponse"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem2"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem2"
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem2"
                }
              }
            }
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
    "/user-groups/v1/": {
      "get": {
        "tags": [
          "external-v2",
          "support"
        ],
        "summary": "getUserGroups",
        "description": "Service that allows to get a list of UserGroup entities",
        "operationId": "getUserGroupsUsingGET",
        "parameters": [
          {
            "name": "institutionId",
            "in": "query",
            "description": "Users group's institutionId",
            "required": false,
            "style": "form",
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "The page number to access (0 indexed, defaults to 0)",
            "required": false,
            "style": "form",
            "allowReserved": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "size",
            "in": "query",
            "description": "Number of records per page (defaults to 20, max 2000)",
            "required": false,
            "style": "form",
            "allowReserved": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "sort",
            "in": "query",
            "description": "Sorting criteria in the format: property(,asc|desc). Default sort order is ascending. Multiple sort criteria are supported.",
            "required": false,
            "style": "form",
            "allowReserved": true,
            "schema": {
              "type": "array",
              "items": {
                "type": "string"
              }
            }
          },
          {
            "name": "productId",
            "in": "query",
            "description": "Users group's productId",
            "required": false,
            "style": "form",
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "userId",
            "in": "query",
            "description": "Member's unique identifier",
            "required": false,
            "style": "form",
            "schema": {
              "type": "string",
              "format": "uuid"
            }
          },
          {
            "name": "status",
            "in": "query",
            "description": "If filter on status is present, it must be used with at least one of the other filters",
            "required": false,
            "style": "form",
            "explode": true,
            "schema": {
              "type": "string",
              "enum": [
                "ACTIVE",
                "DELETED",
                "SUSPENDED"
              ]
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PageOfUserGroupResource"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem3"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem3"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem3"
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem3"
                }
              }
            }
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
    "/products/{id}": {
      "get": {
        "tags": [
          "external-v2",
          "product"
        ],
        "summary": "getProduct",
        "description": "Service that returns the information for a single product given its product id",
        "operationId": "getProductUsingGET",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "Product's unique identifier",
            "required": true,
            "style": "simple",
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "institutionType",
            "in": "query",
            "description": "Institution's type",
            "required": false,
            "style": "form",
            "schema": {
              "type": "string",
              "enum": [
                "AS",
                "GSP",
                "PA",
                "PG",
                "PSP",
                "PT",
                "SA",
                "SCP"
              ]
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProductResource1"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem4"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem4"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem4"
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem4"
                }
              }
            }
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
    "/interceptor/acknowledgment/{productId}/message/{messageId}/status/{status}": {
      "post": {
        "tags": [
          "external-v2"
        ],
        "summary": "messageAcknowledgment",
        "description": "Service to acknowledge message consumption by a consumer",
        "operationId": "messageAcknowledgmentUsingPOST",
        "parameters": [
          {
            "name": "productId",
            "in": "path",
            "description": "Product's unique identifier",
            "required": true,
            "style": "simple",
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "messageId",
            "in": "path",
            "description": "Kafka message unique identifier",
            "required": true,
            "style": "simple",
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "status",
            "in": "path",
            "description": "Kafka message consumption acknowledgment status",
            "required": true,
            "style": "simple",
            "schema": {
              "type": "string",
              "enum": [
                "ACK",
                "NACK"
              ]
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/AckPayloadRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem5"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem5"
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error",
            "content": {
              "application/problem+json": {
                "schema": {
                  "$ref": "#/components/schemas/Problem5"
                }
              }
            }
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
      "Attributes": {
        "title": "Attributes",
        "type": "object",
        "properties": {
          "code": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "origin": {
            "type": "string"
          }
        }
      },
      "AttributesRequest": {
        "title": "AttributesRequest",
        "type": "object",
        "properties": {
          "code": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "origin": {
            "type": "string"
          }
        }
      },
      "AttributesResponse": {
        "title": "AttributesResponse",
        "type": "object",
        "properties": {
          "code": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "origin": {
            "type": "string"
          }
        }
      },
      "Billing": {
        "title": "Billing",
        "type": "object",
        "properties": {
          "publicServices": {
            "type": "boolean"
          },
          "recipientCode": {
            "type": "string"
          },
          "vatNumber": {
            "type": "string"
          }
        }
      },
      "BillingRequest": {
        "title": "BillingRequest",
        "type": "object",
        "properties": {
          "publicServices": {
            "type": "boolean"
          },
          "recipientCode": {
            "type": "string"
          },
          "vatNumber": {
            "type": "string"
          }
        }
      },
      "BillingResponse": {
        "title": "BillingResponse",
        "type": "object",
        "properties": {
          "publicServices": {
            "type": "boolean"
          },
          "recipientCode": {
            "type": "string"
          },
          "vatNumber": {
            "type": "string"
          }
        }
      },
      "BrokerResponse": {
        "title": "BrokerResponse",
        "type": "object",
        "properties": {
          "description": {
            "type": "string"
          },
          "id": {
            "type": "string"
          },
          "numberOfDelegations": {
            "type": "integer",
            "format": "int32"
          }
        }
      },
      "BulkInstitution": {
        "title": "BulkInstitution",
        "type": "object",
        "properties": {
          "address": {
            "type": "string"
          },
          "attributes": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/AttributesResponse"
            }
          },
          "description": {
            "type": "string"
          },
          "digitalAddress": {
            "type": "string"
          },
          "externalId": {
            "type": "string"
          },
          "id": {
            "type": "string"
          },
          "institutionType": {
            "type": "string",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "origin": {
            "type": "string"
          },
          "originId": {
            "type": "string"
          },
          "products": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/BulkProduct"
            }
          },
          "taxCode": {
            "type": "string"
          },
          "zipCode": {
            "type": "string"
          }
        }
      },
      "BulkInstitutions": {
        "title": "BulkInstitutions",
        "type": "object",
        "properties": {
          "found": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/BulkInstitution"
            }
          },
          "notFound": {
            "type": "array",
            "items": {
              "type": "string"
            }
          }
        }
      },
      "BulkPartiesSeed": {
        "title": "BulkPartiesSeed",
        "type": "object",
        "properties": {
          "partyIdentifiers": {
            "type": "array",
            "items": {
              "type": "string"
            }
          }
        }
      },
      "BulkProduct": {
        "title": "BulkProduct",
        "type": "object",
        "properties": {
          "billing": {
            "$ref": "#/components/schemas/BillingResponse"
          },
          "pricingPlan": {
            "type": "string"
          },
          "product": {
            "type": "string"
          },
          "status": {
            "type": "string",
            "enum": [
              "ACTIVE",
              "DELETED",
              "PENDING",
              "REJECTED",
              "SUSPENDED",
              "TOBEVALIDATED"
            ]
          }
        }
      },
      "BusinessData": {
        "title": "BusinessData",
        "type": "object",
        "properties": {
          "businessRegisterPlace": {
            "type": "string"
          },
          "rea": {
            "type": "string"
          },
          "shareCapital": {
            "type": "string"
          }
        }
      },
      "Contract": {
        "title": "Contract",
        "type": "object",
        "properties": {
          "path": {
            "type": "string"
          },
          "version": {
            "type": "string"
          }
        }
      },
      "ContractRequest": {
        "title": "ContractRequest",
        "type": "object",
        "properties": {
          "path": {
            "type": "string"
          },
          "version": {
            "type": "string"
          }
        }
      },
      "CreatePgInstitutionRequest": {
        "title": "CreatePgInstitutionRequest",
        "type": "object",
        "properties": {
          "description": {
            "type": "string"
          },
          "existsInRegistry": {
            "type": "boolean"
          },
          "taxId": {
            "type": "string"
          }
        }
      },
      "CreatePnPgInstitutionRequest": {
        "title": "CreatePnPgInstitutionRequest",
        "type": "object",
        "properties": {
          "description": {
            "type": "string"
          },
          "taxId": {
            "type": "string"
          }
        }
      },
      "DataProtectionOfficer": {
        "title": "DataProtectionOfficer",
        "type": "object",
        "properties": {
          "address": {
            "type": "string"
          },
          "email": {
            "type": "string"
          },
          "pec": {
            "type": "string"
          }
        }
      },
      "DataProtectionOfficerRequest": {
        "title": "DataProtectionOfficerRequest",
        "type": "object",
        "properties": {
          "address": {
            "type": "string"
          },
          "email": {
            "type": "string"
          },
          "pec": {
            "type": "string"
          }
        }
      },
      "DataProtectionOfficerResponse": {
        "title": "DataProtectionOfficerResponse",
        "type": "object",
        "properties": {
          "address": {
            "type": "string"
          },
          "email": {
            "type": "string"
          },
          "pec": {
            "type": "string"
          }
        }
      },
      "DelegationRequest": {
        "title": "DelegationRequest",
        "type": "object",
        "properties": {
          "from": {
            "type": "string"
          },
          "institutionFromName": {
            "type": "string"
          },
          "institutionToName": {
            "type": "string"
          },
          "productId": {
            "type": "string"
          },
          "to": {
            "type": "string"
          },
          "type": {
            "type": "string",
            "enum": [
              "AOO",
              "PT"
            ]
          }
        }
      },
      "DelegationRequestFromTaxcode": {
        "title": "DelegationRequestFromTaxcode",
        "type": "object",
        "properties": {
          "fromSubunitCode": {
            "type": "string"
          },
          "fromTaxCode": {
            "type": "string"
          },
          "institutionFromName": {
            "type": "string"
          },
          "institutionToName": {
            "type": "string"
          },
          "productId": {
            "type": "string"
          },
          "toSubunitCode": {
            "type": "string"
          },
          "toTaxCode": {
            "type": "string"
          },
          "type": {
            "type": "string",
            "enum": [
              "AOO",
              "PT"
            ]
          }
        }
      },
      "DelegationResponse": {
        "title": "DelegationResponse",
        "type": "object",
        "properties": {
          "brokerId": {
            "type": "string"
          },
          "brokerName": {
            "type": "string"
          },
          "brokerTaxCode": {
            "type": "string"
          },
          "brokerType": {
            "type": "string"
          },
          "id": {
            "type": "string"
          },
          "institutionId": {
            "type": "string"
          },
          "institutionName": {
            "type": "string"
          },
          "institutionRootName": {
            "type": "string"
          },
          "institutionType": {
            "type": "string",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "productId": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          },
          "type": {
            "type": "string",
            "enum": [
              "AOO",
              "PT"
            ]
          }
        }
      },
      "GeoTaxonomies": {
        "title": "GeoTaxonomies",
        "type": "object",
        "properties": {
          "code": {
            "type": "string"
          },
          "desc": {
            "type": "string"
          }
        }
      },
      "GeographicTaxonomies": {
        "title": "GeographicTaxonomies",
        "type": "object",
        "properties": {
          "code": {
            "type": "string"
          },
          "country": {
            "type": "string"
          },
          "country_abbreviation": {
            "type": "string"
          },
          "desc": {
            "type": "string"
          },
          "enabled": {
            "type": "boolean"
          },
          "istat_code": {
            "type": "string"
          },
          "province_abbreviation": {
            "type": "string"
          },
          "province_id": {
            "type": "string"
          },
          "region_id": {
            "type": "string"
          }
        }
      },
      "Institution": {
        "title": "Institution",
        "type": "object",
        "properties": {
          "address": {
            "type": "string"
          },
          "attributes": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Attributes"
            }
          },
          "billing": {
            "$ref": "#/components/schemas/Billing"
          },
          "businessRegisterPlace": {
            "type": "string"
          },
          "city": {
            "type": "string"
          },
          "country": {
            "type": "string"
          },
          "county": {
            "type": "string"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "dataProtectionOfficer": {
            "$ref": "#/components/schemas/DataProtectionOfficer"
          },
          "description": {
            "type": "string"
          },
          "digitalAddress": {
            "type": "string"
          },
          "externalId": {
            "type": "string"
          },
          "geographicTaxonomies": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/InstitutionGeographicTaxonomies"
            }
          },
          "id": {
            "type": "string"
          },
          "imported": {
            "type": "boolean"
          },
          "institutionType": {
            "type": "string",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "istatCode": {
            "type": "string"
          },
          "onboarding": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Onboarding"
            }
          },
          "origin": {
            "type": "string"
          },
          "originId": {
            "type": "string"
          },
          "paAttributes": {
            "$ref": "#/components/schemas/PaAttributes"
          },
          "parentDescription": {
            "type": "string"
          },
          "paymentServiceProvider": {
            "$ref": "#/components/schemas/PaymentServiceProvider"
          },
          "rea": {
            "type": "string"
          },
          "rootParentId": {
            "type": "string"
          },
          "shareCapital": {
            "type": "string"
          },
          "subunitCode": {
            "type": "string"
          },
          "subunitType": {
            "type": "string"
          },
          "supportEmail": {
            "type": "string"
          },
          "supportPhone": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time"
          },
          "zipCode": {
            "type": "string"
          }
        }
      },
      "InstitutionBillingResponse": {
        "title": "InstitutionBillingResponse",
        "type": "object",
        "properties": {
          "address": {
            "type": "string"
          },
          "aooParentCode": {
            "type": "string"
          },
          "billing": {
            "$ref": "#/components/schemas/BillingResponse"
          },
          "description": {
            "type": "string"
          },
          "digitalAddress": {
            "type": "string"
          },
          "externalId": {
            "type": "string"
          },
          "institutionId": {
            "type": "string"
          },
          "institutionType": {
            "type": "string",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "origin": {
            "type": "string",
            "enum": [
              "ADE",
              "ANAC",
              "INFOCAMERE",
              "IPA",
              "IVASS",
              "MOCK",
              "SELC",
              "UNKNOWN"
            ]
          },
          "originId": {
            "type": "string"
          },
          "pricingPlan": {
            "type": "string"
          },
          "subunitCode": {
            "type": "string"
          },
          "subunitType": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          },
          "zipCode": {
            "type": "string"
          }
        }
      },
      "InstitutionFromIpaPost": {
        "title": "InstitutionFromIpaPost",
        "type": "object",
        "properties": {
          "subunitCode": {
            "type": "string"
          },
          "subunitType": {
            "type": "string",
            "enum": [
              "AOO",
              "UO"
            ]
          },
          "taxCode": {
            "type": "string"
          }
        }
      },
      "InstitutionGeographicTaxonomies": {
        "title": "InstitutionGeographicTaxonomies",
        "type": "object",
        "properties": {
          "code": {
            "type": "string"
          },
          "desc": {
            "type": "string"
          }
        }
      },
      "InstitutionListResponse": {
        "title": "InstitutionListResponse",
        "type": "object",
        "properties": {
          "items": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/InstitutionManagementResponse"
            }
          }
        }
      },
      "InstitutionManagementResponse": {
        "title": "InstitutionManagementResponse",
        "type": "object",
        "properties": {
          "address": {
            "type": "string"
          },
          "aooParentCode": {
            "type": "string"
          },
          "attributes": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/AttributesResponse"
            }
          },
          "businessRegisterPlace": {
            "type": "string"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "dataProtectionOfficer": {
            "$ref": "#/components/schemas/DataProtectionOfficerResponse"
          },
          "description": {
            "type": "string"
          },
          "digitalAddress": {
            "type": "string"
          },
          "externalId": {
            "type": "string"
          },
          "geographicTaxonomies": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/GeoTaxonomies"
            }
          },
          "id": {
            "type": "string"
          },
          "imported": {
            "type": "boolean"
          },
          "institutionType": {
            "type": "string",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "origin": {
            "type": "string"
          },
          "originId": {
            "type": "string"
          },
          "paymentServiceProvider": {
            "$ref": "#/components/schemas/PaymentServiceProviderResponse"
          },
          "products": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/ProductsManagement"
            }
          },
          "rea": {
            "type": "string"
          },
          "shareCapital": {
            "type": "string"
          },
          "subunitCode": {
            "type": "string"
          },
          "subunitType": {
            "type": "string"
          },
          "supportEmail": {
            "type": "string"
          },
          "supportPhone": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time"
          },
          "zipCode": {
            "type": "string"
          }
        }
      },
      "InstitutionManagerResponse": {
        "title": "InstitutionManagerResponse",
        "type": "object",
        "properties": {
          "billing": {
            "$ref": "#/components/schemas/BillingResponse"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "from": {
            "type": "string"
          },
          "id": {
            "type": "string"
          },
          "institutionUpdate": {
            "$ref": "#/components/schemas/InstitutionUpdateResponse"
          },
          "pricingPlan": {
            "type": "string"
          },
          "product": {
            "$ref": "#/components/schemas/ProductInfo"
          },
          "role": {
            "type": "string"
          },
          "state": {
            "type": "string",
            "enum": [
              "ACTIVE",
              "DELETED",
              "PENDING",
              "REJECTED",
              "SUSPENDED",
              "TOBEVALIDATED"
            ]
          },
          "to": {
            "type": "string"
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time"
          }
        }
      },
      "InstitutionOnboardingListResponse": {
        "title": "InstitutionOnboardingListResponse",
        "type": "object",
        "properties": {
          "items": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/InstitutionOnboardingResponse"
            }
          }
        }
      },
      "InstitutionOnboardingResponse": {
        "title": "InstitutionOnboardingResponse",
        "type": "object",
        "properties": {
          "address": {
            "type": "string"
          },
          "aooParentCode": {
            "type": "string"
          },
          "attributes": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/AttributesResponse"
            }
          },
          "businessRegisterPlace": {
            "type": "string"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "dataProtectionOfficer": {
            "$ref": "#/components/schemas/DataProtectionOfficerResponse"
          },
          "description": {
            "type": "string"
          },
          "digitalAddress": {
            "type": "string"
          },
          "externalId": {
            "type": "string"
          },
          "geographicTaxonomies": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/GeoTaxonomies"
            }
          },
          "id": {
            "type": "string"
          },
          "imported": {
            "type": "boolean"
          },
          "institutionType": {
            "type": "string",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "onboardings": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/OnboardingResponse"
            }
          },
          "origin": {
            "type": "string"
          },
          "originId": {
            "type": "string"
          },
          "paymentServiceProvider": {
            "$ref": "#/components/schemas/PaymentServiceProviderResponse"
          },
          "rea": {
            "type": "string"
          },
          "shareCapital": {
            "type": "string"
          },
          "subunitCode": {
            "type": "string"
          },
          "subunitType": {
            "type": "string"
          },
          "supportEmail": {
            "type": "string"
          },
          "supportPhone": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time"
          },
          "zipCode": {
            "type": "string"
          }
        }
      },
      "InstitutionPnPgResponse": {
        "title": "InstitutionPnPgResponse",
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          }
        }
      },
      "InstitutionProduct": {
        "title": "InstitutionProduct",
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "state": {
            "type": "string",
            "enum": [
              "ACTIVE",
              "DELETED",
              "PENDING",
              "REJECTED",
              "SUSPENDED",
              "TOBEVALIDATED"
            ]
          }
        }
      },
      "InstitutionProducts": {
        "title": "InstitutionProducts",
        "type": "object",
        "properties": {
          "institutionId": {
            "type": "string"
          },
          "institutionName": {
            "type": "string"
          },
          "institutionRootName": {
            "type": "string"
          },
          "products": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Product"
            }
          }
        }
      },
      "InstitutionPut": {
        "title": "InstitutionPut",
        "type": "object",
        "properties": {
          "description": {
            "type": "string"
          },
          "digitalAddress": {
            "type": "string"
          },
          "geographicTaxonomyCodes": {
            "type": "array",
            "items": {
              "type": "string"
            }
          }
        }
      },
      "InstitutionRequest": {
        "title": "InstitutionRequest",
        "type": "object",
        "properties": {
          "address": {
            "type": "string"
          },
          "attributes": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/AttributesRequest"
            }
          },
          "billing": {
            "$ref": "#/components/schemas/BillingRequest"
          },
          "businessRegisterPlace": {
            "type": "string"
          },
          "city": {
            "type": "string"
          },
          "country": {
            "type": "string"
          },
          "county": {
            "type": "string"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "dataProtectionOfficer": {
            "$ref": "#/components/schemas/DataProtectionOfficerRequest"
          },
          "description": {
            "type": "string"
          },
          "digitalAddress": {
            "type": "string"
          },
          "externalId": {
            "type": "string"
          },
          "geographicTaxonomies": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/GeoTaxonomies"
            }
          },
          "id": {
            "type": "string"
          },
          "imported": {
            "type": "boolean"
          },
          "institutionType": {
            "type": "string",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "onboarding": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/OnboardingRequest"
            }
          },
          "origin": {
            "type": "string"
          },
          "originId": {
            "type": "string"
          },
          "paymentServiceProvider": {
            "$ref": "#/components/schemas/PaymentServiceProviderRequest"
          },
          "rea": {
            "type": "string"
          },
          "shareCapital": {
            "type": "string"
          },
          "supportEmail": {
            "type": "string"
          },
          "supportPhone": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time"
          },
          "zipCode": {
            "type": "string"
          }
        }
      },
      "InstitutionResponse": {
        "title": "InstitutionResponse",
        "type": "object",
        "properties": {
          "address": {
            "type": "string"
          },
          "aooParentCode": {
            "type": "string"
          },
          "attributes": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/AttributesResponse"
            }
          },
          "businessRegisterPlace": {
            "type": "string"
          },
          "city": {
            "type": "string"
          },
          "country": {
            "type": "string"
          },
          "county": {
            "type": "string"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "dataProtectionOfficer": {
            "$ref": "#/components/schemas/DataProtectionOfficerResponse"
          },
          "description": {
            "type": "string"
          },
          "digitalAddress": {
            "type": "string"
          },
          "externalId": {
            "type": "string"
          },
          "geographicTaxonomies": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/GeoTaxonomies"
            }
          },
          "id": {
            "type": "string"
          },
          "imported": {
            "type": "boolean"
          },
          "institutionType": {
            "type": "string",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "onboarding": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/OnboardedProductResponse"
            }
          },
          "origin": {
            "type": "string"
          },
          "originId": {
            "type": "string"
          },
          "paymentServiceProvider": {
            "$ref": "#/components/schemas/PaymentServiceProviderResponse"
          },
          "rea": {
            "type": "string"
          },
          "rootParent": {
            "$ref": "#/components/schemas/RootParentResponse"
          },
          "shareCapital": {
            "type": "string"
          },
          "subunitCode": {
            "type": "string"
          },
          "subunitType": {
            "type": "string"
          },
          "supportEmail": {
            "type": "string"
          },
          "supportPhone": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time"
          },
          "zipCode": {
            "type": "string"
          }
        }
      },
      "InstitutionToOnboard": {
        "title": "InstitutionToOnboard",
        "type": "object",
        "properties": {
          "cfImpresa": {
            "type": "string"
          },
          "denominazione": {
            "type": "string"
          }
        }
      },
      "InstitutionUpdate": {
        "title": "InstitutionUpdate",
        "type": "object",
        "properties": {
          "address": {
            "type": "string"
          },
          "businessRegisterPlace": {
            "type": "string"
          },
          "city": {
            "type": "string"
          },
          "country": {
            "type": "string"
          },
          "county": {
            "type": "string"
          },
          "dataProtectionOfficer": {
            "$ref": "#/components/schemas/DataProtectionOfficer"
          },
          "description": {
            "type": "string"
          },
          "digitalAddress": {
            "type": "string"
          },
          "geographicTaxonomies": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/InstitutionGeographicTaxonomies"
            }
          },
          "imported": {
            "type": "boolean"
          },
          "institutionType": {
            "type": "string",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "ivassCode": {
            "type": "string"
          },
          "paymentServiceProvider": {
            "$ref": "#/components/schemas/PaymentServiceProvider"
          },
          "rea": {
            "type": "string"
          },
          "shareCapital": {
            "type": "string"
          },
          "supportEmail": {
            "type": "string"
          },
          "supportPhone": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          },
          "zipCode": {
            "type": "string"
          }
        }
      },
      "InstitutionUpdateRequest": {
        "title": "InstitutionUpdateRequest",
        "type": "object",
        "properties": {
          "address": {
            "type": "string"
          },
          "businessRegisterPlace": {
            "type": "string"
          },
          "city": {
            "type": "string"
          },
          "country": {
            "type": "string"
          },
          "county": {
            "type": "string"
          },
          "dataProtectionOfficer": {
            "$ref": "#/components/schemas/DataProtectionOfficerRequest"
          },
          "description": {
            "type": "string"
          },
          "digitalAddress": {
            "type": "string"
          },
          "geographicTaxonomyCodes": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "imported": {
            "type": "boolean"
          },
          "institutionType": {
            "type": "string",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "ivassCode": {
            "type": "string"
          },
          "paymentServiceProvider": {
            "$ref": "#/components/schemas/PaymentServiceProviderRequest"
          },
          "rea": {
            "type": "string"
          },
          "shareCapital": {
            "type": "string"
          },
          "supportEmail": {
            "type": "string"
          },
          "supportPhone": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          },
          "zipCode": {
            "type": "string"
          }
        }
      },
      "InstitutionUpdateResponse": {
        "title": "InstitutionUpdateResponse",
        "type": "object",
        "properties": {
          "address": {
            "type": "string"
          },
          "aooParentCode": {
            "type": "string"
          },
          "businessRegisterPlace": {
            "type": "string"
          },
          "city": {
            "type": "string"
          },
          "country": {
            "type": "string"
          },
          "county": {
            "type": "string"
          },
          "dataProtectionOfficer": {
            "$ref": "#/components/schemas/DataProtectionOfficerResponse"
          },
          "description": {
            "type": "string"
          },
          "digitalAddress": {
            "type": "string"
          },
          "geographicTaxonomyCodes": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "imported": {
            "type": "boolean"
          },
          "institutionType": {
            "type": "string",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "paymentServiceProvider": {
            "$ref": "#/components/schemas/PaymentServiceProviderResponse"
          },
          "rea": {
            "type": "string"
          },
          "shareCapital": {
            "type": "string"
          },
          "subunitCode": {
            "type": "string"
          },
          "subunitType": {
            "type": "string"
          },
          "supportEmail": {
            "type": "string"
          },
          "supportPhone": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          },
          "zipCode": {
            "type": "string"
          }
        }
      },
      "InstitutionsResponse": {
        "title": "InstitutionsResponse",
        "type": "object",
        "properties": {
          "institutions": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/InstitutionResponse"
            }
          }
        }
      },
      "LegalsResponse": {
        "title": "LegalsResponse",
        "type": "object",
        "properties": {
          "env": {
            "type": "string",
            "enum": [
              "COLL",
              "DEV",
              "PROD",
              "ROOT"
            ]
          },
          "partyId": {
            "type": "string"
          },
          "relationshipId": {
            "type": "string"
          },
          "role": {
            "type": "string",
            "enum": [
              "DELEGATE",
              "MANAGER",
              "OPERATOR",
              "SUB_DELEGATE"
            ]
          }
        }
      },
      "MigrationInstitution": {
        "title": "MigrationInstitution",
        "type": "object",
        "properties": {
          "address": {
            "type": "string"
          },
          "attributes": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Attributes"
            }
          },
          "billing": {
            "$ref": "#/components/schemas/Billing"
          },
          "businessRegisterPlace": {
            "type": "string"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "dataProtectionOfficer": {
            "$ref": "#/components/schemas/DataProtectionOfficer"
          },
          "description": {
            "type": "string"
          },
          "digitalAddress": {
            "type": "string"
          },
          "externalId": {
            "type": "string"
          },
          "geographicTaxonomies": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/InstitutionGeographicTaxonomies"
            }
          },
          "id": {
            "type": "string"
          },
          "imported": {
            "type": "boolean"
          },
          "institutionType": {
            "type": "string",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "onboarding": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Onboarding"
            }
          },
          "origin": {
            "type": "string"
          },
          "originId": {
            "type": "string"
          },
          "paymentServiceProvider": {
            "$ref": "#/components/schemas/PaymentServiceProvider"
          },
          "rea": {
            "type": "string"
          },
          "shareCapital": {
            "type": "string"
          },
          "supportEmail": {
            "type": "string"
          },
          "supportPhone": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time"
          },
          "zipCode": {
            "type": "string"
          }
        }
      },
      "MigrationOnboardedUser": {
        "title": "MigrationOnboardedUser",
        "type": "object",
        "properties": {
          "bindings": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/UserBinding"
            }
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "id": {
            "type": "string"
          }
        }
      },
      "MigrationToken": {
        "title": "MigrationToken",
        "type": "object",
        "properties": {
          "checksum": {
            "type": "string"
          },
          "closedAt": {
            "type": "string",
            "format": "date-time"
          },
          "contractSigned": {
            "type": "string"
          },
          "contractTemplate": {
            "type": "string"
          },
          "contractVersion": {
            "type": "string"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "expiringDate": {
            "type": "string",
            "format": "date-time"
          },
          "id": {
            "type": "string"
          },
          "institutionId": {
            "type": "string"
          },
          "institutionUpdate": {
            "$ref": "#/components/schemas/InstitutionUpdate"
          },
          "productId": {
            "type": "string"
          },
          "status": {
            "type": "string",
            "enum": [
              "ACTIVE",
              "DELETED",
              "PENDING",
              "REJECTED",
              "SUSPENDED",
              "TOBEVALIDATED"
            ]
          },
          "type": {
            "type": "string",
            "enum": [
              "INSTITUTION",
              "LEGALS"
            ]
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time"
          },
          "users": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/TokenUser"
            }
          }
        }
      },
      "OnboardedInstitutionResponse": {
        "title": "OnboardedInstitutionResponse",
        "type": "object",
        "properties": {
          "address": {
            "type": "string"
          },
          "aooParentCode": {
            "type": "string"
          },
          "attributes": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/AttributesResponse"
            }
          },
          "billing": {
            "$ref": "#/components/schemas/Billing"
          },
          "businessData": {
            "$ref": "#/components/schemas/BusinessData"
          },
          "dataProtectionOfficer": {
            "$ref": "#/components/schemas/DataProtectionOfficerResponse"
          },
          "description": {
            "type": "string"
          },
          "digitalAddress": {
            "type": "string"
          },
          "externalId": {
            "type": "string"
          },
          "geographicTaxonomies": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/GeoTaxonomies"
            }
          },
          "id": {
            "type": "string"
          },
          "institutionType": {
            "type": "string",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "origin": {
            "type": "string"
          },
          "originId": {
            "type": "string"
          },
          "parentDescription": {
            "type": "string"
          },
          "paymentServiceProvider": {
            "$ref": "#/components/schemas/PaymentServiceProviderResponse"
          },
          "pricingPlan": {
            "type": "string"
          },
          "productInfo": {
            "$ref": "#/components/schemas/ProductInfo"
          },
          "role": {
            "type": "string",
            "enum": [
              "DELEGATE",
              "MANAGER",
              "OPERATOR",
              "SUB_DELEGATE"
            ]
          },
          "rootParentId": {
            "type": "string"
          },
          "state": {
            "type": "string"
          },
          "subunitCode": {
            "type": "string"
          },
          "subunitType": {
            "type": "string"
          },
          "supportContact": {
            "$ref": "#/components/schemas/SupportContact"
          },
          "taxCode": {
            "type": "string"
          },
          "zipCode": {
            "type": "string"
          }
        }
      },
      "OnboardedProduct": {
        "title": "OnboardedProduct",
        "type": "object",
        "properties": {
          "contract": {
            "type": "string"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "env": {
            "type": "string",
            "enum": [
              "COLL",
              "DEV",
              "PROD",
              "ROOT"
            ]
          },
          "productId": {
            "type": "string"
          },
          "productRole": {
            "type": "string"
          },
          "relationshipId": {
            "type": "string"
          },
          "role": {
            "type": "string",
            "enum": [
              "DELEGATE",
              "MANAGER",
              "OPERATOR",
              "SUB_DELEGATE"
            ]
          },
          "status": {
            "type": "string",
            "enum": [
              "ACTIVE",
              "DELETED",
              "PENDING",
              "REJECTED",
              "SUSPENDED",
              "TOBEVALIDATED"
            ]
          },
          "tokenId": {
            "type": "string"
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time"
          }
        }
      },
      "OnboardedProductResponse": {
        "title": "OnboardedProductResponse",
        "type": "object",
        "properties": {
          "billing": {
            "$ref": "#/components/schemas/BillingResponse"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "productId": {
            "type": "string"
          },
          "status": {
            "type": "string",
            "enum": [
              "ACTIVE",
              "DELETED",
              "PENDING",
              "REJECTED",
              "SUSPENDED",
              "TOBEVALIDATED"
            ]
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time"
          }
        }
      },
      "OnboardedProducts": {
        "title": "OnboardedProducts",
        "type": "object",
        "properties": {
          "products": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/InstitutionProduct"
            }
          }
        }
      },
      "OnboardedUser": {
        "title": "OnboardedUser",
        "type": "object",
        "properties": {
          "bindings": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/UserBinding"
            }
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "id": {
            "type": "string"
          }
        }
      },
      "Onboarding": {
        "title": "Onboarding",
        "type": "object",
        "properties": {
          "billing": {
            "$ref": "#/components/schemas/Billing"
          },
          "closedAt": {
            "type": "string",
            "format": "date-time"
          },
          "contract": {
            "type": "string"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "pricingPlan": {
            "type": "string"
          },
          "productId": {
            "type": "string"
          },
          "status": {
            "type": "string",
            "enum": [
              "ACTIVE",
              "DELETED",
              "PENDING",
              "REJECTED",
              "SUSPENDED",
              "TOBEVALIDATED"
            ]
          },
          "tokenId": {
            "type": "string"
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time"
          }
        }
      },
      "OnboardingImportContract": {
        "title": "OnboardingImportContract",
        "type": "object",
        "properties": {
          "contractType": {
            "type": "string"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "fileName": {
            "type": "string"
          },
          "filePath": {
            "type": "string"
          }
        }
      },
      "OnboardingInfoResponse": {
        "title": "OnboardingInfoResponse",
        "type": "object",
        "properties": {
          "institutions": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/OnboardedInstitutionResponse"
            }
          },
          "userId": {
            "type": "string"
          }
        }
      },
      "OnboardingInstitutionLegalsRequest": {
        "title": "OnboardingInstitutionLegalsRequest",
        "type": "object",
        "properties": {
          "contract": {
            "$ref": "#/components/schemas/ContractRequest"
          },
          "institutionExternalId": {
            "type": "string"
          },
          "institutionId": {
            "type": "string"
          },
          "productId": {
            "type": "string"
          },
          "productName": {
            "type": "string"
          },
          "signContract": {
            "type": "boolean"
          },
          "users": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Person"
            }
          }
        }
      },
      "OnboardingInstitutionOperatorsRequest": {
        "title": "OnboardingInstitutionOperatorsRequest",
        "type": "object",
        "properties": {
          "institutionId": {
            "type": "string"
          },
          "productId": {
            "type": "string"
          },
          "productTitle": {
            "type": "string"
          },
          "users": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Person"
            }
          }
        }
      },
      "OnboardingInstitutionRequest": {
        "title": "OnboardingInstitutionRequest",
        "type": "object",
        "properties": {
          "billing": {
            "$ref": "#/components/schemas/BillingRequest"
          },
          "contract": {
            "$ref": "#/components/schemas/ContractRequest"
          },
          "contractImported": {
            "$ref": "#/components/schemas/OnboardingImportContract"
          },
          "institutionExternalId": {
            "type": "string"
          },
          "institutionUpdate": {
            "$ref": "#/components/schemas/InstitutionUpdateRequest"
          },
          "pricingPlan": {
            "type": "string"
          },
          "productId": {
            "type": "string"
          },
          "productName": {
            "type": "string"
          },
          "sendCompleteOnboardingEmail": {
            "type": "boolean",
            "description": "Parameter that allows you to specify whether following completion of onboarding you want to receive an email",
            "example": false
          },
          "signContract": {
            "type": "boolean"
          },
          "users": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Person"
            }
          }
        }
      },
      "OnboardingInstitutionUsersRequest": {
        "title": "OnboardingInstitutionUsersRequest",
        "type": "object",
        "properties": {
          "institutionSubunitCode": {
            "type": "string"
          },
          "institutionTaxCode": {
            "type": "string"
          },
          "productId": {
            "type": "string"
          },
          "sendCreateUserNotificationEmail": {
            "type": "boolean"
          },
          "users": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Person"
            }
          }
        }
      },
      "OnboardingRequest": {
        "title": "OnboardingRequest",
        "type": "object",
        "properties": {
          "billingRequest": {
            "$ref": "#/components/schemas/Billing"
          },
          "contract": {
            "$ref": "#/components/schemas/Contract"
          },
          "contractCreatedAt": {
            "type": "string",
            "format": "date-time"
          },
          "contractFilePath": {
            "type": "string"
          },
          "institutionExternalId": {
            "type": "string"
          },
          "institutionUpdate": {
            "$ref": "#/components/schemas/InstitutionUpdate"
          },
          "pricingPlan": {
            "type": "string"
          },
          "productId": {
            "type": "string"
          },
          "productName": {
            "type": "string"
          },
          "sendCompleteOnboardingEmail": {
            "type": "boolean"
          },
          "signContract": {
            "type": "boolean"
          },
          "tokenType": {
            "type": "string",
            "enum": [
              "INSTITUTION",
              "LEGALS"
            ]
          },
          "users": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/UserToOnboard"
            }
          }
        }
      },
      "OnboardingResponse": {
        "title": "OnboardingResponse",
        "type": "object",
        "properties": {
          "billing": {
            "$ref": "#/components/schemas/BillingResponse"
          },
          "closedAt": {
            "type": "string",
            "format": "date-time"
          },
          "contract": {
            "type": "string"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "pricingPlan": {
            "type": "string"
          },
          "productId": {
            "type": "string"
          },
          "status": {
            "type": "string",
            "enum": [
              "ACTIVE",
              "DELETED",
              "PENDING",
              "REJECTED",
              "SUSPENDED",
              "TOBEVALIDATED"
            ]
          },
          "tokenId": {
            "type": "string"
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time"
          }
        }
      },
      "OnboardingsResponse": {
        "title": "OnboardingsResponse",
        "type": "object",
        "properties": {
          "onboardings": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/OnboardingResponse"
            }
          }
        }
      },
      "PaAttributes": {
        "title": "PaAttributes",
        "type": "object",
        "properties": {
          "aooParentCode": {
            "type": "string"
          }
        }
      },
      "PaymentServiceProvider": {
        "title": "PaymentServiceProvider",
        "type": "object",
        "properties": {
          "abiCode": {
            "type": "string"
          },
          "businessRegisterNumber": {
            "type": "string"
          },
          "legalRegisterName": {
            "type": "string"
          },
          "legalRegisterNumber": {
            "type": "string"
          },
          "vatNumberGroup": {
            "type": "boolean"
          }
        }
      },
      "PaymentServiceProviderRequest": {
        "title": "PaymentServiceProviderRequest",
        "type": "object",
        "properties": {
          "abiCode": {
            "type": "string"
          },
          "businessRegisterNumber": {
            "type": "string"
          },
          "legalRegisterName": {
            "type": "string"
          },
          "legalRegisterNumber": {
            "type": "string"
          },
          "vatNumberGroup": {
            "type": "boolean"
          }
        }
      },
      "PaymentServiceProviderResponse": {
        "title": "PaymentServiceProviderResponse",
        "type": "object",
        "properties": {
          "abiCode": {
            "type": "string"
          },
          "businessRegisterNumber": {
            "type": "string"
          },
          "legalRegisterName": {
            "type": "string"
          },
          "legalRegisterNumber": {
            "type": "string"
          },
          "vatNumberGroup": {
            "type": "boolean"
          }
        }
      },
      "PdaInstitutionRequest": {
        "title": "PdaInstitutionRequest",
        "type": "object",
        "properties": {
          "billing": {
            "$ref": "#/components/schemas/BillingRequest"
          },
          "description": {
            "type": "string"
          },
          "injectionInstitutionType": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          }
        }
      },
      "Person": {
        "title": "Person",
        "type": "object",
        "properties": {
          "email": {
            "type": "string"
          },
          "env": {
            "type": "string",
            "enum": [
              "COLL",
              "DEV",
              "PROD",
              "ROOT"
            ]
          },
          "id": {
            "type": "string"
          },
          "name": {
            "type": "string"
          },
          "productRole": {
            "type": "string"
          },
          "role": {
            "type": "string",
            "enum": [
              "DELEGATE",
              "MANAGER",
              "OPERATOR",
              "SUB_DELEGATE"
            ]
          },
          "roleLabel": {
            "type": "string"
          },
          "surname": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          }
        }
      },
      "PersonId": {
        "title": "PersonId",
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          }
        }
      },
      "Problem": {
        "title": "Problem",
        "type": "object",
        "properties": {
          "errors": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/ProblemError"
            }
          },
          "status": {
            "type": "integer",
            "format": "int32"
          }
        }
      },
      "ProblemError": {
        "title": "ProblemError",
        "type": "object"
      },
      "Product": {
        "title": "Product",
        "type": "object",
        "properties": {
          "contract": {
            "type": "string"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "env": {
            "type": "string",
            "enum": [
              "COLL",
              "DEV",
              "PROD",
              "ROOT"
            ]
          },
          "productId": {
            "type": "string"
          },
          "productRole": {
            "type": "string"
          },
          "role": {
            "type": "string",
            "enum": [
              "DELEGATE",
              "MANAGER",
              "OPERATOR",
              "SUB_DELEGATE"
            ]
          },
          "status": {
            "type": "string",
            "enum": [
              "ACTIVE",
              "DELETED",
              "PENDING",
              "REJECTED",
              "SUSPENDED",
              "TOBEVALIDATED"
            ]
          },
          "tokenId": {
            "type": "string"
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time"
          }
        }
      },
      "ProductInfo": {
        "title": "ProductInfo",
        "type": "object",
        "properties": {
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "id": {
            "type": "string"
          },
          "role": {
            "type": "string"
          },
          "status": {
            "type": "string"
          }
        }
      },
      "ProductsManagement": {
        "title": "ProductsManagement",
        "type": "object",
        "properties": {
          "billing": {
            "$ref": "#/components/schemas/BillingResponse"
          },
          "pricingPlan": {
            "type": "string"
          },
          "product": {
            "type": "string"
          }
        }
      },
      "RelationshipResult": {
        "title": "RelationshipResult",
        "type": "object",
        "properties": {
          "billing": {
            "$ref": "#/components/schemas/BillingResponse"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "from": {
            "type": "string"
          },
          "id": {
            "type": "string"
          },
          "institutionUpdate": {
            "$ref": "#/components/schemas/InstitutionUpdateResponse"
          },
          "pricingPlan": {
            "type": "string"
          },
          "product": {
            "$ref": "#/components/schemas/ProductInfo"
          },
          "role": {
            "type": "string",
            "enum": [
              "DELEGATE",
              "MANAGER",
              "OPERATOR",
              "SUB_DELEGATE"
            ]
          },
          "state": {
            "type": "string",
            "enum": [
              "ACTIVE",
              "DELETED",
              "PENDING",
              "REJECTED",
              "SUSPENDED",
              "TOBEVALIDATED"
            ]
          },
          "to": {
            "type": "string"
          },
          "tokenId": {
            "type": "string"
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time"
          }
        }
      },
      "RelationshipsManagement": {
        "title": "RelationshipsManagement",
        "type": "object",
        "properties": {
          "items": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/RelationshipResult"
            }
          }
        }
      },
      "RootParentResponse": {
        "title": "RootParentResponse",
        "type": "object",
        "properties": {
          "description": {
            "type": "string"
          },
          "id": {
            "type": "string"
          }
        }
      },
      "SupportContact": {
        "title": "SupportContact",
        "type": "object",
        "properties": {
          "supportEmail": {
            "type": "string"
          },
          "supportPhone": {
            "type": "string"
          }
        }
      },
      "Token": {
        "title": "Token",
        "type": "object",
        "properties": {
          "activatedAt": {
            "type": "string",
            "format": "date-time"
          },
          "checksum": {
            "type": "string"
          },
          "contentType": {
            "type": "string"
          },
          "contractSigned": {
            "type": "string"
          },
          "contractTemplate": {
            "type": "string"
          },
          "contractVersion": {
            "type": "string"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "deletedAt": {
            "type": "string",
            "format": "date-time"
          },
          "expiringDate": {
            "type": "string",
            "format": "date-time"
          },
          "id": {
            "type": "string"
          },
          "institutionId": {
            "type": "string"
          },
          "institutionUpdate": {
            "$ref": "#/components/schemas/InstitutionUpdate"
          },
          "productId": {
            "type": "string"
          },
          "status": {
            "type": "string",
            "enum": [
              "ACTIVE",
              "DELETED",
              "PENDING",
              "REJECTED",
              "SUSPENDED",
              "TOBEVALIDATED"
            ]
          },
          "type": {
            "type": "string",
            "enum": [
              "INSTITUTION",
              "LEGALS"
            ]
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time"
          },
          "users": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/TokenUser"
            }
          }
        }
      },
      "TokenListResponse": {
        "title": "TokenListResponse",
        "type": "object",
        "properties": {
          "items": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/TokenResponse"
            }
          }
        }
      },
      "TokenResource": {
        "title": "TokenResource",
        "type": "object",
        "properties": {
          "checksum": {
            "type": "string"
          },
          "closedAt": {
            "type": "string",
            "format": "date-time"
          },
          "contractSigned": {
            "type": "string"
          },
          "contractTemplate": {
            "type": "string"
          },
          "contractVersion": {
            "type": "string"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "expiringDate": {
            "type": "string",
            "format": "date-time"
          },
          "id": {
            "type": "string"
          },
          "institutionId": {
            "type": "string"
          },
          "institutionUpdate": {
            "$ref": "#/components/schemas/InstitutionUpdate"
          },
          "productId": {
            "type": "string"
          },
          "status": {
            "type": "string",
            "enum": [
              "ACTIVE",
              "DELETED",
              "PENDING",
              "REJECTED",
              "SUSPENDED",
              "TOBEVALIDATED"
            ]
          },
          "type": {
            "type": "string",
            "enum": [
              "INSTITUTION",
              "LEGALS"
            ]
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time"
          },
          "users": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/TokenUser"
            }
          }
        }
      },
      "TokenResponse": {
        "title": "TokenResponse",
        "type": "object",
        "properties": {
          "checksum": {
            "type": "string"
          },
          "closedAt": {
            "type": "string",
            "format": "date-time"
          },
          "contentType": {
            "type": "string"
          },
          "contractSigned": {
            "type": "string"
          },
          "contractTemplate": {
            "type": "string"
          },
          "contractVersion": {
            "type": "string"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "expiringDate": {
            "type": "string",
            "format": "date-time"
          },
          "id": {
            "type": "string"
          },
          "institutionId": {
            "type": "string"
          },
          "institutionUpdate": {
            "$ref": "#/components/schemas/InstitutionUpdate"
          },
          "legals": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/LegalsResponse"
            }
          },
          "productId": {
            "type": "string"
          },
          "status": {
            "type": "string",
            "enum": [
              "ACTIVE",
              "DELETED",
              "PENDING",
              "REJECTED",
              "SUSPENDED",
              "TOBEVALIDATED"
            ]
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time"
          },
          "users": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/TokenUser"
            }
          }
        }
      },
      "TokenUser": {
        "title": "TokenUser",
        "type": "object",
        "properties": {
          "role": {
            "type": "string",
            "enum": [
              "DELEGATE",
              "MANAGER",
              "OPERATOR",
              "SUB_DELEGATE"
            ]
          },
          "userId": {
            "type": "string"
          }
        }
      },
      "UserBinding": {
        "title": "UserBinding",
        "type": "object",
        "properties": {
          "institutionId": {
            "type": "string"
          },
          "institutionName": {
            "type": "string"
          },
          "institutionRootName": {
            "type": "string"
          },
          "products": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/OnboardedProduct"
            }
          }
        }
      },
      "UserInfoResponse": {
        "title": "UserInfoResponse",
        "type": "object",
        "properties": {
          "email": {
            "type": "string"
          },
          "id": {
            "type": "string"
          },
          "name": {
            "type": "string"
          },
          "products": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/OnboardedProduct"
            }
          },
          "surname": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          }
        }
      },
      "UserProductsResponse": {
        "title": "UserProductsResponse",
        "type": "object",
        "properties": {
          "bindings": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/InstitutionProducts"
            }
          },
          "id": {
            "type": "string"
          }
        }
      },
      "UserResponse": {
        "title": "UserResponse",
        "type": "object",
        "properties": {
          "email": {
            "type": "string"
          },
          "id": {
            "type": "string"
          },
          "name": {
            "type": "string"
          },
          "surname": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          }
        }
      },
      "UserToOnboard": {
        "title": "UserToOnboard",
        "type": "object",
        "properties": {
          "email": {
            "type": "string"
          },
          "env": {
            "type": "string",
            "enum": [
              "COLL",
              "DEV",
              "PROD",
              "ROOT"
            ]
          },
          "id": {
            "type": "string"
          },
          "name": {
            "type": "string"
          },
          "productRole": {
            "type": "string"
          },
          "role": {
            "type": "string",
            "enum": [
              "DELEGATE",
              "MANAGER",
              "OPERATOR",
              "SUB_DELEGATE"
            ]
          },
          "roleLabel": {
            "type": "string"
          },
          "surname": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          }
        }
      },
      "AssistanceContactsDto": {
        "title": "AssistanceContactsDto",
        "type": "object",
        "properties": {
          "supportEmail": {
            "type": "string",
            "description": "Institution's support email contact",
            "format": "email",
            "example": "email@example.com"
          },
          "supportPhone": {
            "type": "string",
            "description": "Institution's support phone contact"
          }
        }
      },
      "AssistanceContactsResource": {
        "title": "AssistanceContactsResource",
        "type": "object",
        "properties": {
          "supportEmail": {
            "type": "string",
            "description": "Institution's support email contact"
          },
          "supportPhone": {
            "type": "string",
            "description": "Institution's support phone contact"
          }
        }
      },
      "BillingDataDto": {
        "title": "BillingDataDto",
        "required": [
          "businessName",
          "digitalAddress",
          "recipientCode",
          "registeredOffice",
          "taxCode",
          "vatNumber",
          "zipCode"
        ],
        "type": "object",
        "properties": {
          "businessName": {
            "type": "string",
            "description": "Institution's legal name"
          },
          "digitalAddress": {
            "type": "string",
            "description": "Institution's digitalAddress"
          },
          "publicServices": {
            "type": "boolean",
            "description": "Institution's service type",
            "example": false
          },
          "recipientCode": {
            "type": "string",
            "description": "Billing recipient code, not required only for institutionType SA"
          },
          "registeredOffice": {
            "type": "string",
            "description": "Institution's physical address"
          },
          "taxCode": {
            "type": "string",
            "description": "Institution's taxCode"
          },
          "vatNumber": {
            "type": "string",
            "description": "Institution's VAT number"
          },
          "zipCode": {
            "type": "string",
            "description": "Institution's zipCode"
          }
        }
      },
      "CompanyInformationsDto": {
        "title": "CompanyInformationsDto",
        "type": "object",
        "properties": {
          "businessRegisterPlace": {
            "type": "string",
            "description": "Institution's business register place"
          },
          "rea": {
            "type": "string",
            "description": "Institution's REA"
          },
          "shareCapital": {
            "type": "string",
            "description": "Institution's share capital value"
          }
        }
      },
      "CompanyInformationsResource": {
        "title": "CompanyInformationsResource",
        "type": "object",
        "properties": {
          "businessRegisterPlace": {
            "type": "string",
            "description": "Institution's business register place"
          },
          "rea": {
            "type": "string",
            "description": "Institution's REA"
          },
          "shareCapital": {
            "type": "string",
            "description": "Institution's share capital value"
          }
        }
      },
      "CreatePnPgInstitutionDto": {
        "title": "CreatePnPgInstitutionDto",
        "required": [
          "externalId"
        ],
        "type": "object",
        "properties": {
          "description": {
            "type": "string",
            "description": "Institution's legal name"
          },
          "externalId": {
            "type": "string",
            "description": "Institution's unique external identifier"
          }
        }
      },
      "DpoDataDto": {
        "title": "DpoDataDto",
        "required": [
          "address",
          "email",
          "pec"
        ],
        "type": "object",
        "properties": {
          "address": {
            "type": "string",
            "description": "DPO's address"
          },
          "email": {
            "type": "string",
            "description": "DPO's email",
            "format": "email",
            "example": "email@example.com"
          },
          "pec": {
            "type": "string",
            "description": "DPO's PEC",
            "format": "email",
            "example": "email@example.com"
          }
        }
      },
      "DpoDataResource": {
        "title": "DpoDataResource",
        "type": "object",
        "properties": {
          "address": {
            "type": "string",
            "description": "DPO's address"
          },
          "email": {
            "type": "string",
            "description": "DPO's email"
          },
          "pec": {
            "type": "string",
            "description": "DPO's PEC"
          }
        }
      },
      "GeographicTaxonomyDto": {
        "title": "GeographicTaxonomyDto",
        "required": [
          "code",
          "desc"
        ],
        "type": "object",
        "properties": {
          "code": {
            "type": "string",
            "description": "Institution's geographic taxonomy ISTAT code"
          },
          "desc": {
            "type": "string",
            "description": "Institution's geographic taxonomy extended name"
          }
        }
      },
      "GeographicTaxonomyDto0": {
        "title": "GeographicTaxonomyDto0",
        "required": [
          "code",
          "desc"
        ],
        "type": "object",
        "properties": {
          "code": {
            "type": "string",
            "description": "Institution's geographic taxonomy ISTAT code"
          },
          "desc": {
            "type": "string",
            "description": "Institution's geographic taxonomy extended name"
          }
        }
      },
      "GeographicTaxonomyResource": {
        "title": "GeographicTaxonomyResource",
        "type": "object",
        "properties": {
          "code": {
            "type": "string",
            "description": "Institution's geographic taxonomy ISTAT code"
          },
          "desc": {
            "type": "string",
            "description": "Institution's geographic taxonomy extended name"
          }
        }
      },
      "ImportContractDto": {
        "title": "ImportContractDto",
        "required": [
          "contractType",
          "fileName",
          "filePath",
          "onboardingDate"
        ],
        "type": "object",
        "properties": {
          "contractType": {
            "type": "string",
            "description": "Institution's old contract version"
          },
          "fileName": {
            "type": "string",
            "description": "Institution's old contract file name"
          },
          "filePath": {
            "type": "string",
            "description": "Institution's old contract file path"
          },
          "onboardingDate": {
            "type": "string",
            "description": "Institution's old onboarding date in the format 2007-12-03T10:15:30+01:00 (YYYY-MM-DD-T-HH:mm:ss+UTC)",
            "format": "date-time"
          }
        }
      },
      "InstitutionDetailResource": {
        "title": "InstitutionDetailResource",
        "type": "object",
        "properties": {
          "address": {
            "type": "string",
            "description": "Institution's physical address"
          },
          "aooParentCode": {
            "type": "string",
            "description": "AOO unit parent institution Code"
          },
          "businessRegisterPlace": {
            "type": "string",
            "description": "Institution's business register place"
          },
          "city": {
            "type": "string",
            "description": "Institution's physical address city"
          },
          "country": {
            "type": "string",
            "description": "Institution's physical address country"
          },
          "county": {
            "type": "string",
            "description": "Institution's physical address county"
          },
          "description": {
            "type": "string",
            "description": "Institution's legal name"
          },
          "digitalAddress": {
            "type": "string",
            "description": "Institution's digitalAddress"
          },
          "externalId": {
            "type": "string",
            "description": "Institution's unique external identifier"
          },
          "geographicTaxonomies": {
            "type": "array",
            "description": "Institution's geographic taxonomy",
            "items": {
              "$ref": "#/components/schemas/GeographicTaxonomyResource"
            }
          },
          "id": {
            "type": "string",
            "description": "Institution's unique internal Id",
            "format": "uuid"
          },
          "imported": {
            "type": "boolean",
            "description": "True if institution is stored from batch api",
            "example": false
          },
          "institutionType": {
            "type": "string",
            "description": "Institution's type",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "origin": {
            "type": "string",
            "description": "Institution data origin"
          },
          "originId": {
            "type": "string",
            "description": "Institution's details origin Id"
          },
          "parentDescription": {
            "type": "string",
            "description": "Institutions AOO/UO unit parent's description"
          },
          "rea": {
            "type": "string",
            "description": "Institution's REA"
          },
          "shareCapital": {
            "type": "string",
            "description": "Institution's share capital value"
          },
          "subunitCode": {
            "type": "string",
            "description": "Institutions AOO/UO unit Code"
          },
          "subunitType": {
            "type": "string",
            "description": "Institutions AOO/UO unit type"
          },
          "supportEmail": {
            "type": "string",
            "description": "Institution's support email contact"
          },
          "supportPhone": {
            "type": "string",
            "description": "Institution's support phone contact"
          },
          "taxCode": {
            "type": "string",
            "description": "Institution's taxCode"
          },
          "zipCode": {
            "type": "string",
            "description": "Institution's zipCode"
          }
        }
      },
      "InstitutionLocationDataDto": {
        "title": "InstitutionLocationDataDto",
        "required": [
          "city",
          "country",
          "county"
        ],
        "type": "object",
        "properties": {
          "city": {
            "type": "string",
            "description": "Institution's physical address city"
          },
          "country": {
            "type": "string",
            "description": "Institution's physical address country"
          },
          "county": {
            "type": "string",
            "description": "Institution's physical address county"
          }
        }
      },
      "InstitutionResource": {
        "title": "InstitutionResource",
        "type": "object",
        "properties": {
          "address": {
            "type": "string",
            "description": "Institution's physical address"
          },
          "aooParentCode": {
            "type": "string",
            "description": "AOO unit parent institution Code"
          },
          "assistanceContacts": {
            "description": "Institution's assistance contacts",
            "$ref": "#/components/schemas/AssistanceContactsResource"
          },
          "city": {
            "type": "string",
            "description": "Institution's physical address city"
          },
          "companyInformations": {
            "description": "GPS, SCP, PT optional data",
            "$ref": "#/components/schemas/CompanyInformationsResource"
          },
          "country": {
            "type": "string",
            "description": "Institution's physical address country"
          },
          "county": {
            "type": "string",
            "description": "Institution's physical address county"
          },
          "description": {
            "type": "string",
            "description": "Institution's legal name"
          },
          "digitalAddress": {
            "type": "string",
            "description": "Institution's digitalAddress"
          },
          "dpoData": {
            "description": "Data Protection Officer (DPO) specific data",
            "$ref": "#/components/schemas/DpoDataResource"
          },
          "externalId": {
            "type": "string",
            "description": "Institution's unique external identifier"
          },
          "id": {
            "type": "string",
            "description": "Institution's unique internal Id",
            "format": "uuid"
          },
          "institutionType": {
            "type": "string",
            "description": "Institution's type",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "origin": {
            "type": "string",
            "description": "Institution data origin"
          },
          "originId": {
            "type": "string",
            "description": "Institution's details origin Id"
          },
          "pspData": {
            "description": "Payment Service Provider (PSP) specific data",
            "$ref": "#/components/schemas/PspDataResource"
          },
          "recipientCode": {
            "type": "string",
            "description": "Billing recipient code, not required only for institutionType SA"
          },
          "rootParent": {
            "description": "Institution AOO/UO root institutionDescription",
            "$ref": "#/components/schemas/RootParentResource"
          },
          "status": {
            "type": "string",
            "description": "Institution onboarding status"
          },
          "subunitCode": {
            "type": "string",
            "description": "Institutions AOO/UO unit Code"
          },
          "subunitType": {
            "type": "string",
            "description": "Institutions AOO/UO unit type"
          },
          "taxCode": {
            "type": "string",
            "description": "Institution's taxCode"
          },
          "userProductRoles": {
            "type": "array",
            "description": "Logged user's roles on product",
            "items": {
              "type": "string"
            }
          },
          "zipCode": {
            "type": "string",
            "description": "Institution's zipCode"
          }
        }
      },
      "InvalidParam": {
        "title": "InvalidParam",
        "required": [
          "name",
          "reason"
        ],
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "description": "Invalid parameter name."
          },
          "reason": {
            "type": "string",
            "description": "Invalid parameter reason."
          }
        }
      },
      "OnboardedInstitutionResource": {
        "title": "OnboardedInstitutionResource",
        "type": "object",
        "properties": {
          "address": {
            "type": "string",
            "description": "Institution's address"
          },
          "description": {
            "type": "string",
            "description": "Institution's description"
          },
          "digitalAddress": {
            "type": "string",
            "description": "Institution's digital address"
          },
          "id": {
            "type": "string",
            "description": "Institution's Id"
          },
          "institutionType": {
            "type": "string",
            "description": "Institution's type",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "productInfo": {
            "description": "Products' info of onboardings",
            "$ref": "#/components/schemas/ProductInfo"
          },
          "state": {
            "type": "string",
            "description": "Onboarding's state"
          },
          "taxCode": {
            "type": "string",
            "description": "Institution's tax code"
          },
          "userEmail": {
            "type": "string",
            "description": "User's email linked to the institution"
          },
          "zipCode": {
            "type": "string",
            "description": "Institution's zip code"
          }
        }
      },
      "OnboardedProductResource": {
        "title": "OnboardedProductResource",
        "type": "object",
        "properties": {
          "createdAt": {
            "type": "string",
            "description": "User product relation create date",
            "format": "date-time"
          },
          "productId": {
            "type": "string",
            "description": "Product's unique identifier"
          },
          "role": {
            "type": "string",
            "description": "User's role",
            "enum": [
              "DELEGATE",
              "MANAGER",
              "OPERATOR",
              "SUB_DELEGATE"
            ]
          },
          "roles": {
            "type": "array",
            "description": "User's roles in product",
            "items": {
              "type": "string"
            }
          }
        }
      },
      "OnboardingDto": {
        "title": "OnboardingDto",
        "required": [
          "billingData",
          "geographicTaxonomies",
          "institutionType",
          "users"
        ],
        "type": "object",
        "properties": {
          "assistanceContacts": {
            "description": "Institution's assistance contacts",
            "$ref": "#/components/schemas/AssistanceContactsDto"
          },
          "billingData": {
            "description": "Institution's billing information",
            "$ref": "#/components/schemas/BillingDataDto"
          },
          "companyInformations": {
            "description": "GPS, SCP, PT optional data",
            "$ref": "#/components/schemas/CompanyInformationsDto"
          },
          "geographicTaxonomies": {
            "type": "array",
            "description": "Institution's geographic taxonomy",
            "items": {
              "$ref": "#/components/schemas/GeographicTaxonomyDto"
            }
          },
          "institutionType": {
            "type": "string",
            "description": "Institution's type",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "origin": {
            "type": "string",
            "description": "Institution data origin"
          },
          "pricingPlan": {
            "type": "string",
            "description": "Product's pricing plan"
          },
          "pspData": {
            "description": "Payment Service Provider (PSP) specific data",
            "$ref": "#/components/schemas/PspDataDto"
          },
          "users": {
            "type": "array",
            "description": "List of onboarding users",
            "items": {
              "$ref": "#/components/schemas/UserDto"
            }
          }
        }
      },
      "OnboardingImportDto": {
        "title": "OnboardingImportDto",
        "required": [
          "importContract",
          "users"
        ],
        "type": "object",
        "properties": {
          "importContract": {
            "description": "Institution's old contract information",
            "$ref": "#/components/schemas/ImportContractDto"
          },
          "users": {
            "type": "array",
            "description": "List of onboarding users",
            "items": {
              "$ref": "#/components/schemas/UserDto"
            }
          }
        }
      },
      "OnboardingProductDto": {
        "title": "OnboardingProductDto",
        "required": [
          "billingData",
          "geographicTaxonomies",
          "institutionType",
          "productId",
          "taxCode",
          "users"
        ],
        "type": "object",
        "properties": {
          "assistanceContacts": {
            "description": "Institution's assistance contacts",
            "$ref": "#/components/schemas/AssistanceContactsDto"
          },
          "billingData": {
            "description": "Institution's billing information",
            "$ref": "#/components/schemas/BillingDataDto"
          },
          "companyInformations": {
            "description": "GPS, SCP, PT optional data",
            "$ref": "#/components/schemas/CompanyInformationsDto"
          },
          "geographicTaxonomies": {
            "type": "array",
            "description": "List of geographic Taxonomies",
            "items": {
              "$ref": "#/components/schemas/GeographicTaxonomyDto0"
            }
          },
          "institutionLocationData": {
            "description": "Institution's location Data",
            "$ref": "#/components/schemas/InstitutionLocationDataDto"
          },
          "institutionType": {
            "type": "string",
            "description": "Institution's type",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "origin": {
            "type": "string",
            "description": "Institution data origin"
          },
          "pricingPlan": {
            "type": "string",
            "description": "Product's pricing plan"
          },
          "productId": {
            "type": "string",
            "description": "Product's unique identifier"
          },
          "pspData": {
            "description": "Payment Service Provider (PSP) specific data",
            "$ref": "#/components/schemas/PspDataDto"
          },
          "subunitCode": {
            "type": "string",
            "description": "Institutions AOO/UO unit Code"
          },
          "subunitType": {
            "type": "string",
            "description": "Institutions AOO/UO unit type"
          },
          "taxCode": {
            "type": "string",
            "description": "Institution's taxCode"
          },
          "users": {
            "type": "array",
            "description": "List of onboarding users",
            "items": {
              "$ref": "#/components/schemas/UserDto"
            }
          }
        }
      },
      "PdaOnboardingDto": {
        "title": "PdaOnboardingDto",
        "required": [
          "businessName",
          "productId",
          "recipientCode",
          "taxCode",
          "users",
          "vatNumber"
        ],
        "type": "object",
        "properties": {
          "businessName": {
            "type": "string",
            "description": "Institution's legal name"
          },
          "productId": {
            "type": "string",
            "description": "Product's unique identifier"
          },
          "recipientCode": {
            "type": "string",
            "description": "Billing recipient code, not required only for institutionType SA"
          },
          "taxCode": {
            "type": "string",
            "description": "Institution's taxCode"
          },
          "users": {
            "type": "array",
            "description": "List of onboarding users",
            "items": {
              "$ref": "#/components/schemas/UserDto"
            }
          },
          "vatNumber": {
            "type": "string",
            "description": "Institution's VAT number"
          }
        }
      },
      "PnPgInstitutionIdResource": {
        "title": "PnPgInstitutionIdResource",
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "Institution's unique internal Id"
          }
        }
      },
      "Problem1": {
        "title": "Problem",
        "required": [
          "status",
          "title"
        ],
        "type": "object",
        "properties": {
          "detail": {
            "type": "string",
            "description": "Human-readable description of this specific problem."
          },
          "instance": {
            "type": "string",
            "description": "A URI that describes where the problem occurred."
          },
          "invalidParams": {
            "type": "array",
            "description": "A list of invalid parameters details.",
            "items": {
              "$ref": "#/components/schemas/InvalidParam"
            }
          },
          "status": {
            "type": "integer",
            "description": "The HTTP status code.",
            "format": "int32",
            "example": 500
          },
          "title": {
            "type": "string",
            "description": "Short human-readable summary of the problem."
          },
          "type": {
            "type": "string",
            "description": "A URL to a page with more details regarding the problem."
          }
        },
        "description": "A \"problem detail\" as a way to carry machine-readable details of errors (https://datatracker.ietf.org/doc/html/rfc7807)"
      },
      "ProductResource": {
        "title": "ProductResource",
        "type": "object",
        "properties": {
          "contractTemplatePath": {
            "type": "string",
            "description": "The path of contract"
          },
          "contractTemplateUpdatedAt": {
            "type": "string",
            "description": "Date the contract was postponed",
            "format": "date-time"
          },
          "contractTemplateVersion": {
            "type": "string",
            "description": "Version of the contract"
          },
          "createdAt": {
            "type": "string",
            "description": "Date the products was activated/created",
            "format": "date-time"
          },
          "depictImageUrl": {
            "type": "string",
            "description": "Product's depiction image url"
          },
          "description": {
            "type": "string",
            "description": "Product's description"
          },
          "id": {
            "type": "string",
            "description": "Product's unique identifier"
          },
          "identityTokenAudience": {
            "type": "string",
            "description": "Product's identity token audience"
          },
          "logo": {
            "type": "string",
            "description": "Product's logo"
          },
          "logoBgColor": {
            "type": "string",
            "description": "Product logo's background color"
          },
          "parentId": {
            "type": "string",
            "description": "Root parent of the sub product"
          },
          "roleManagementURL": {
            "type": "string",
            "description": "Url of the utilities management"
          },
          "roleMappings": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/ProductRoleInfo"
            },
            "description": "Mappings between Party's and Product's role"
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
      },
      "ProductRole": {
        "title": "ProductRole",
        "required": [
          "code",
          "description",
          "label"
        ],
        "type": "object",
        "properties": {
          "code": {
            "type": "string",
            "description": "Product role internal code"
          },
          "description": {
            "type": "string",
            "description": "Product role description"
          },
          "label": {
            "type": "string",
            "description": "Product role label"
          }
        }
      },
      "ProductRoleInfo": {
        "title": "ProductRoleInfo",
        "required": [
          "multiroleAllowed",
          "roles"
        ],
        "type": "object",
        "properties": {
          "multiroleAllowed": {
            "type": "boolean",
            "description": "Flag indicating if a User can have more than one product role",
            "example": false
          },
          "roles": {
            "type": "array",
            "description": "Available product roles",
            "items": {
              "$ref": "#/components/schemas/ProductRole"
            }
          }
        }
      },
      "PspDataDto": {
        "title": "PspDataDto",
        "required": [
          "abiCode",
          "businessRegisterNumber",
          "dpoData",
          "legalRegisterName",
          "legalRegisterNumber",
          "vatNumberGroup"
        ],
        "type": "object",
        "properties": {
          "abiCode": {
            "type": "string",
            "description": "PSP's ABI code"
          },
          "businessRegisterNumber": {
            "type": "string",
            "description": "PSP's Business Register number"
          },
          "dpoData": {
            "description": "Data Protection Officer (DPO) specific data",
            "$ref": "#/components/schemas/DpoDataDto"
          },
          "legalRegisterName": {
            "type": "string",
            "description": "PSP's legal register name"
          },
          "legalRegisterNumber": {
            "type": "string",
            "description": "PSP's legal register number"
          },
          "vatNumberGroup": {
            "type": "boolean",
            "description": "PSP's Vat Number group",
            "example": false
          }
        }
      },
      "PspDataResource": {
        "title": "PspDataResource",
        "type": "object",
        "properties": {
          "abiCode": {
            "type": "string",
            "description": "PSP's ABI code"
          },
          "businessRegisterNumber": {
            "type": "string",
            "description": "PSP's Business Register number"
          },
          "legalRegisterName": {
            "type": "string",
            "description": "PSP's legal register name"
          },
          "legalRegisterNumber": {
            "type": "string",
            "description": "PSP's legal register number"
          },
          "vatNumberGroup": {
            "type": "boolean",
            "description": "PSP's Vat Number group",
            "example": false
          }
        }
      },
      "RootParentResource": {
        "title": "RootParentResource",
        "type": "object",
        "properties": {
          "description": {
            "type": "string",
            "description": "swagger.external_api.institutions.model.parentDescription"
          },
          "id": {
            "type": "string",
            "description": "Institution's unique internal Id"
          }
        }
      },
      "SearchUserDto": {
        "title": "SearchUserDto",
        "required": [
          "fiscalCode"
        ],
        "type": "object",
        "properties": {
          "fiscalCode": {
            "type": "string",
            "description": "User's fiscal code"
          },
          "statuses": {
            "type": "array",
            "description": "User's statuses",
            "items": {
              "type": "string",
              "enum": [
                "ACTIVE",
                "DELETED",
                "PENDING",
                "REJECTED",
                "SUSPENDED"
              ]
            }
          }
        }
      },
      "UserDetailsResource": {
        "title": "UserDetailsResource",
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "User's unique identifier"
          },
          "institutionId": {
            "type": "string",
            "description": " swagger.external_api.institutions.model.id"
          },
          "onboardedProductDetails": {
            "description": "Object that includes user's onboarded product info",
            "$ref": "#/components/schemas/OnboardedProductResource"
          }
        }
      },
      "UserDto": {
        "title": "UserDto",
        "required": [
          "email",
          "name",
          "role",
          "surname",
          "taxCode"
        ],
        "type": "object",
        "properties": {
          "email": {
            "type": "string",
            "description": "User's email",
            "format": "email",
            "example": "email@example.com"
          },
          "name": {
            "type": "string",
            "description": "User's name"
          },
          "role": {
            "type": "string",
            "description": "User's role",
            "enum": [
              "DELEGATE",
              "MANAGER",
              "OPERATOR",
              "SUB_DELEGATE"
            ]
          },
          "surname": {
            "type": "string",
            "description": "User's surname"
          },
          "taxCode": {
            "type": "string",
            "description": "User's fiscal code"
          }
        }
      },
      "UserInfoResource": {
        "title": "UserInfoResource",
        "type": "object",
        "properties": {
          "onboardedInstitutions": {
            "type": "array",
            "description": "Object that includes all info about onboarded institutions linked to a user",
            "items": {
              "$ref": "#/components/schemas/OnboardedInstitutionResource"
            }
          },
          "user": {
            "description": "Object that includes all info about a user",
            "$ref": "#/components/schemas/UserResource"
          }
        }
      },
      "UserResource": {
        "title": "UserResource",
        "type": "object",
        "properties": {
          "email": {
            "type": "string",
            "description": "User's institutional email"
          },
          "fiscalCode": {
            "type": "string",
            "description": "User's fiscal code"
          },
          "id": {
            "type": "string",
            "description": "User's unique identifier",
            "format": "uuid"
          },
          "name": {
            "type": "string",
            "description": "User's name"
          },
          "role": {
            "type": "string",
            "description": "User's role",
            "enum": [
              "DELEGATE",
              "MANAGER",
              "OPERATOR",
              "SUB_DELEGATE"
            ]
          },
          "roles": {
            "type": "array",
            "description": "User's roles in product",
            "items": {
              "type": "string"
            }
          },
          "surname": {
            "type": "string",
            "description": "User's surname"
          }
        }
      },
      "Attribute": {
        "title": "Attribute",
        "type": "object",
        "properties": {
          "code": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "origin": {
            "type": "string"
          }
        }
      },
      "BackOfficeConfigurationsResource": {
        "title": "BackOfficeConfigurationsResource",
        "type": "object",
        "properties": {
          "environment": {
            "type": "string",
            "description": "Back Office environment"
          },
          "url": {
            "type": "string",
            "description": "URL that redirects to the back-office section, where is possible to manage the product"
          }
        }
      },
      "BrokerResource": {
        "title": "BrokerResource",
        "type": "object",
        "properties": {
          "code": {
            "type": "string",
            "description": "Partner's code"
          },
          "description": {
            "type": "string",
            "description": "Partner's description"
          },
          "enabled": {
            "type": "boolean",
            "description": "Partner's enabling",
            "example": false
          }
        }
      },
      "CertifiedFieldResourceOfstring": {
        "title": "CertifiedFieldResourceOfstring",
        "type": "object",
        "properties": {
          "certified": {
            "type": "boolean",
            "description": "Indicates whether the value comes from a certified information source",
            "example": false
          },
          "value": {
            "type": "string",
            "description": "Field value"
          }
        }
      },
      "CreateUserDto": {
        "title": "CreateUserDto",
        "required": [
          "productRoles",
          "taxCode"
        ],
        "type": "object",
        "properties": {
          "email": {
            "type": "string",
            "description": "User's personal email",
            "format": "email",
            "example": "email@example.com"
          },
          "name": {
            "type": "string",
            "description": "User's name"
          },
          "productRoles": {
            "uniqueItems": true,
            "type": "array",
            "description": "User's roles in product",
            "items": {
              "type": "string"
            }
          },
          "surname": {
            "type": "string",
            "description": "User's surname"
          },
          "taxCode": {
            "type": "string",
            "description": "User's fiscal code"
          }
        }
      },
      "CreateUserGroupDto": {
        "title": "CreateUserGroupDto",
        "required": [
          "description",
          "institutionId",
          "members",
          "name",
          "productId"
        ],
        "type": "object",
        "properties": {
          "description": {
            "type": "string",
            "description": "Users group's description"
          },
          "institutionId": {
            "type": "string",
            "description": "Users group's institutionId"
          },
          "members": {
            "uniqueItems": true,
            "type": "array",
            "description": "List of all the members of the group",
            "items": {
              "type": "string",
              "format": "uuid"
            }
          },
          "name": {
            "type": "string",
            "description": "Users group's name"
          },
          "productId": {
            "type": "string",
            "description": "Users group's productId"
          }
        }
      },
      "DelegationIdResource": {
        "title": "DelegationIdResource",
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "Delegation's unique identifier"
          }
        }
      },
      "DelegationRequestDto": {
        "title": "DelegationRequestDto",
        "required": [
          "from",
          "institutionFromName",
          "institutionToName",
          "productId",
          "to",
          "type"
        ],
        "type": "object",
        "properties": {
          "from": {
            "type": "string",
            "description": "Institution's identifier"
          },
          "institutionFromName": {
            "type": "string",
            "description": "Institution's name"
          },
          "institutionToName": {
            "type": "string",
            "description": "Partner's name"
          },
          "productId": {
            "type": "string",
            "description": "Product's identifier"
          },
          "to": {
            "type": "string",
            "description": "Technical partner's identifier"
          },
          "type": {
            "type": "string",
            "description": "Delegation type",
            "enum": [
              "AOO",
              "PT",
              "UO"
            ]
          }
        }
      },
      "DelegationResource": {
        "title": "DelegationResource",
        "type": "object",
        "properties": {
          "brokerId": {
            "type": "string"
          },
          "brokerName": {
            "type": "string"
          },
          "id": {
            "type": "string"
          },
          "institutionId": {
            "type": "string"
          },
          "institutionName": {
            "type": "string"
          },
          "institutionRootName": {
            "type": "string"
          },
          "productId": {
            "type": "string"
          },
          "type": {
            "type": "string",
            "enum": [
              "AOO",
              "PT",
              "UO"
            ]
          }
        }
      },
      "DpoData": {
        "title": "DpoData",
        "required": [
          "address",
          "email",
          "pec"
        ],
        "type": "object",
        "properties": {
          "address": {
            "type": "string",
            "description": "DPO's address"
          },
          "email": {
            "type": "string",
            "description": "DPO's email",
            "format": "email",
            "example": "email@example.com"
          },
          "pec": {
            "type": "string",
            "description": "DPO's PEC",
            "format": "email",
            "example": "email@example.com"
          }
        }
      },
      "GeographicTaxonomy": {
        "title": "GeographicTaxonomy",
        "type": "object",
        "properties": {
          "code": {
            "type": "string"
          },
          "desc": {
            "type": "string"
          }
        }
      },
      "GeographicTaxonomyListDto": {
        "title": "GeographicTaxonomyListDto",
        "required": [
          "geographicTaxonomyDtoList"
        ],
        "type": "object",
        "properties": {
          "geographicTaxonomyDtoList": {
            "type": "array",
            "description": "List of institution's geographic taxonomies  ",
            "items": {
              "$ref": "#/components/schemas/GeographicTaxonomyDto"
            }
          }
        }
      },
      "IdentityTokenResource": {
        "title": "IdentityTokenResource",
        "required": [
          "token"
        ],
        "type": "object",
        "properties": {
          "token": {
            "type": "string",
            "description": "The Identity Token"
          }
        }
      },
      "Institution1": {
        "title": "Institution",
        "type": "object",
        "properties": {
          "address": {
            "type": "string"
          },
          "aooParentCode": {
            "type": "string"
          },
          "attributes": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Attribute"
            }
          },
          "billing": {
            "$ref": "#/components/schemas/Billing"
          },
          "category": {
            "type": "string"
          },
          "city": {
            "type": "string"
          },
          "country": {
            "type": "string"
          },
          "county": {
            "type": "string"
          },
          "dataProtectionOfficer": {
            "$ref": "#/components/schemas/DataProtectionOfficer"
          },
          "description": {
            "type": "string"
          },
          "digitalAddress": {
            "type": "string"
          },
          "externalId": {
            "type": "string"
          },
          "geographicTaxonomies": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/GeographicTaxonomy"
            }
          },
          "id": {
            "type": "string"
          },
          "institutionType": {
            "type": "string",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "onboarding": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/OnboardedProduct1"
            }
          },
          "origin": {
            "type": "string"
          },
          "originId": {
            "type": "string"
          },
          "paymentServiceProvider": {
            "$ref": "#/components/schemas/PaymentServiceProvider"
          },
          "rootParent": {
            "$ref": "#/components/schemas/RootParentResponse"
          },
          "subunitCode": {
            "type": "string"
          },
          "subunitType": {
            "type": "string"
          },
          "supportContact": {
            "$ref": "#/components/schemas/SupportContact"
          },
          "taxCode": {
            "type": "string"
          },
          "zipCode": {
            "type": "string"
          }
        }
      },
      "InstitutionBaseResource": {
        "title": "InstitutionBaseResource",
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "Institution's unique internal identifier"
          },
          "name": {
            "type": "string",
            "description": "Institution's name"
          },
          "parentDescription": {
            "type": "string",
            "description": "Sub unit institution parent Description"
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
      "InstitutionInfo": {
        "title": "InstitutionInfo",
        "required": [
          "address",
          "fiscalCode",
          "id",
          "institutionType",
          "mailAddress",
          "name",
          "recipientCode",
          "vatNumber",
          "zipCode"
        ],
        "type": "object",
        "properties": {
          "address": {
            "type": "string",
            "description": "Institution's physical address"
          },
          "city": {
            "type": "string",
            "description": "Institution's city"
          },
          "country": {
            "type": "string",
            "description": "Institution's country"
          },
          "county": {
            "type": "string",
            "description": "Institution's county"
          },
          "dpoData": {
            "description": "Data Protection Officer (DPO) specific data",
            "$ref": "#/components/schemas/DpoData"
          },
          "fiscalCode": {
            "type": "string",
            "description": "Fiscal code corresponding to the institution"
          },
          "id": {
            "type": "string",
            "description": "Institution's unique internal identifier"
          },
          "institutionType": {
            "type": "string",
            "description": "Institution's type",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "mailAddress": {
            "type": "string",
            "description": "Institution's email address"
          },
          "name": {
            "type": "string",
            "description": "Institution's name"
          },
          "pspData": {
            "description": "Payment Service Provider (PSP) specific data",
            "$ref": "#/components/schemas/PspData"
          },
          "recipientCode": {
            "type": "string",
            "description": "Billing recipient code"
          },
          "vatNumber": {
            "type": "string",
            "description": "Institution's VAT number"
          },
          "zipCode": {
            "type": "string",
            "description": "Institution's zipCode"
          }
        }
      },
      "InstitutionResource1": {
        "title": "InstitutionResource",
        "type": "object",
        "properties": {
          "address": {
            "type": "string",
            "description": "Institution's physical address"
          },
          "aooParentCode": {
            "type": "string",
            "description": "UO's parent AOO code"
          },
          "category": {
            "type": "string",
            "description": "Institution's category"
          },
          "city": {
            "type": "string",
            "description": "Institution's city"
          },
          "country": {
            "type": "string",
            "description": "Institution's country"
          },
          "county": {
            "type": "string",
            "description": "Institution's county"
          },
          "externalId": {
            "type": "string",
            "description": "Institution's unique external identifier"
          },
          "fiscalCode": {
            "type": "string",
            "description": "Fiscal code corresponding to the institution"
          },
          "geographicTaxonomies": {
            "type": "array",
            "description": "Institution's geographic taxonomy",
            "items": {
              "$ref": "#/components/schemas/GeographicTaxonomyResource"
            }
          },
          "id": {
            "type": "string",
            "description": "Institution's unique internal identifier"
          },
          "institutionType": {
            "type": "string",
            "description": "Institution's type",
            "enum": [
              "AS",
              "GSP",
              "PA",
              "PG",
              "PSP",
              "PT",
              "SA",
              "SCP"
            ]
          },
          "mailAddress": {
            "type": "string",
            "description": "Institution's email address"
          },
          "name": {
            "type": "string",
            "description": "Institution's name"
          },
          "origin": {
            "type": "string",
            "description": "Institution's data origin"
          },
          "originId": {
            "type": "string",
            "description": "Institution's identifier related to origin"
          },
          "parentDescription": {
            "type": "string",
            "description": "Sub unit institution parent Description"
          },
          "products": {
            "type": "array",
            "description": "${swagger.dashboard.institutions.model.products}",
            "items": {
              "$ref": "#/components/schemas/OnboardedProductResource1"
            }
          },
          "recipientCode": {
            "type": "string",
            "description": "Billing recipient code"
          },
          "status": {
            "type": "string",
            "description": "Institution's status"
          },
          "subunitCode": {
            "type": "string",
            "description": "AOO o UO unique code"
          },
          "subunitType": {
            "type": "string",
            "description": "Institution's subunit type"
          },
          "supportContact": {
            "description": "'Institution's assistance contacts'",
            "$ref": "#/components/schemas/SupportContactResource"
          },
          "userRole": {
            "type": "string",
            "description": "Logged user's role"
          },
          "vatNumber": {
            "type": "string",
            "description": "Institution's VAT number"
          },
          "vatNumberGroup": {
            "type": "boolean",
            "description": "PSP's Vat Number group",
            "example": false
          },
          "zipCode": {
            "type": "string",
            "description": "Institution's zipCode"
          }
        }
      },
      "InstitutionUserDetailsResource": {
        "title": "InstitutionUserDetailsResource",
        "type": "object",
        "properties": {
          "email": {
            "type": "string",
            "description": "User's personal email"
          },
          "fiscalCode": {
            "type": "string",
            "description": "User's fiscal code"
          },
          "id": {
            "type": "string",
            "description": "User's unique identifier",
            "format": "uuid"
          },
          "name": {
            "type": "string",
            "description": "User's name"
          },
          "products": {
            "type": "array",
            "description": "Authorized user products",
            "items": {
              "$ref": "#/components/schemas/ProductInfoResource"
            }
          },
          "role": {
            "type": "string",
            "description": "User's role",
            "enum": [
              "ADMIN",
              "LIMITED"
            ]
          },
          "status": {
            "type": "string",
            "description": "User's status"
          },
          "surname": {
            "type": "string",
            "description": "User's surname"
          }
        }
      },
      "InstitutionUserResource": {
        "title": "InstitutionUserResource",
        "type": "object",
        "properties": {
          "email": {
            "type": "string",
            "description": "User's personal email"
          },
          "id": {
            "type": "string",
            "description": "User's unique identifier",
            "format": "uuid"
          },
          "name": {
            "type": "string",
            "description": "User's name"
          },
          "products": {
            "type": "array",
            "description": "Authorized user products",
            "items": {
              "$ref": "#/components/schemas/ProductInfoResource"
            }
          },
          "role": {
            "type": "string",
            "description": "User's role",
            "enum": [
              "ADMIN",
              "LIMITED"
            ]
          },
          "status": {
            "type": "string",
            "description": "User's status"
          },
          "surname": {
            "type": "string",
            "description": "User's surname"
          }
        }
      },
      "OnboardedProduct1": {
        "title": "OnboardedProduct",
        "type": "object",
        "properties": {
          "authorized": {
            "type": "boolean"
          },
          "billing": {
            "$ref": "#/components/schemas/Billing"
          },
          "productId": {
            "type": "string"
          },
          "status": {
            "type": "string",
            "enum": [
              "ACTIVE",
              "DELETED",
              "PENDING",
              "REJECTED",
              "SUSPENDED",
              "TOBEVALIDATED"
            ]
          },
          "userRole": {
            "type": "string"
          }
        }
      },
      "OnboardedProductResource1": {
        "title": "OnboardedProductResource",
        "type": "object",
        "properties": {
          "authorized": {
            "type": "boolean"
          },
          "billing": {
            "$ref": "#/components/schemas/Billing"
          },
          "productId": {
            "type": "string"
          },
          "productOnBoardingStatus": {
            "type": "string",
            "enum": [
              "ACTIVE",
              "DELETED",
              "PENDING",
              "REJECTED",
              "SUSPENDED",
              "TOBEVALIDATED"
            ]
          },
          "userRole": {
            "type": "string"
          }
        }
      },
      "OnboardingRequestResource": {
        "title": "OnboardingRequestResource",
        "required": [
          "institutionInfo",
          "manager",
          "status"
        ],
        "type": "object",
        "properties": {
          "admins": {
            "type": "array",
            "description": "Administrators specific data",
            "items": {
              "$ref": "#/components/schemas/UserInfo"
            }
          },
          "institutionInfo": {
            "description": "Institution specific data",
            "$ref": "#/components/schemas/InstitutionInfo"
          },
          "manager": {
            "description": "Manager specific data. It's required when institutionType is not PT",
            "$ref": "#/components/schemas/UserInfo"
          },
          "status": {
            "type": "string",
            "description": "Onboarding request's status",
            "enum": [
              "ACTIVE",
              "DELETED",
              "PENDING",
              "REJECTED",
              "SUSPENDED",
              "TOBEVALIDATED"
            ]
          }
        }
      },
      "PageOfUserGroupPlainResource": {
        "title": "PageOfUserGroupPlainResource",
        "required": [
          "content",
          "number",
          "size",
          "totalElements",
          "totalPages"
        ],
        "type": "object",
        "properties": {
          "content": {
            "type": "array",
            "description": "The page content",
            "items": {
              "$ref": "#/components/schemas/UserGroupPlainResource"
            }
          },
          "number": {
            "type": "integer",
            "description": "The number of the current page",
            "format": "int32"
          },
          "size": {
            "type": "integer",
            "description": "The size of the page",
            "format": "int32"
          },
          "totalElements": {
            "type": "integer",
            "description": "The total amount of elements",
            "format": "int64"
          },
          "totalPages": {
            "type": "integer",
            "description": "The number of total pages",
            "format": "int32"
          }
        }
      },
      "PartyProduct": {
        "title": "PartyProduct",
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "onBoardingStatus": {
            "type": "string",
            "enum": [
              "ACTIVE",
              "INACTIVE",
              "PENDING"
            ]
          }
        }
      },
      "PlainUserResource": {
        "title": "PlainUserResource",
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "User's unique identifier",
            "format": "uuid"
          },
          "name": {
            "type": "string",
            "description": "User's name"
          },
          "surname": {
            "type": "string",
            "description": "User's surname"
          }
        }
      },
      "Problem2": {
        "title": "Problem",
        "required": [
          "status",
          "title"
        ],
        "type": "object",
        "properties": {
          "detail": {
            "type": "string",
            "description": "Human-readable description of this specific problem."
          },
          "instance": {
            "type": "string",
            "description": "A URI that describes where the problem occurred."
          },
          "invalidParams": {
            "type": "array",
            "description": "A list of invalid parameters details.",
            "items": {
              "$ref": "#/components/schemas/InvalidParam"
            }
          },
          "status": {
            "type": "integer",
            "description": "The HTTP status code.",
            "format": "int32",
            "example": 500
          },
          "title": {
            "type": "string",
            "description": "Short human-readable summary of the problem."
          },
          "type": {
            "type": "string",
            "description": "A URL to a page with more details regarding the problem."
          }
        },
        "description": "A \"problem detail\" as a way to carry machine-readable details of errors (https://datatracker.ietf.org/doc/html/rfc7807)"
      },
      "ProductInfoResource": {
        "title": "ProductInfoResource",
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "Product's unique identifier"
          },
          "roleInfos": {
            "type": "array",
            "description": "User's role infos in product",
            "items": {
              "$ref": "#/components/schemas/ProductRoleInfoResource"
            }
          },
          "title": {
            "type": "string",
            "description": "Product's title"
          }
        }
      },
      "ProductRoleInfoResource": {
        "title": "ProductRoleInfoResource",
        "type": "object",
        "properties": {
          "relationshipId": {
            "type": "string",
            "description": "Unique relationship identifier between User and Product"
          },
          "role": {
            "type": "string",
            "description": "User's role in product"
          },
          "selcRole": {
            "type": "string",
            "description": "User's role",
            "enum": [
              "ADMIN",
              "LIMITED"
            ]
          },
          "status": {
            "type": "string",
            "description": "User's status"
          }
        }
      },
      "ProductRoleMappingsResource": {
        "title": "ProductRoleMappingsResource",
        "type": "object",
        "properties": {
          "multiroleAllowed": {
            "type": "boolean",
            "description": "Indicates if an User can have more than one product role",
            "example": false
          },
          "partyRole": {
            "type": "string",
            "description": "Party role",
            "enum": [
              "DELEGATE",
              "MANAGER",
              "OPERATOR",
              "SUB_DELEGATE"
            ]
          },
          "productRoles": {
            "type": "array",
            "description": "Available product roles",
            "items": {
              "$ref": "#/components/schemas/ProductRoleResource"
            }
          },
          "selcRole": {
            "type": "string",
            "description": "Self Care role",
            "enum": [
              "ADMIN",
              "LIMITED"
            ]
          }
        }
      },
      "ProductRoleResource": {
        "title": "ProductRoleResource",
        "type": "object",
        "properties": {
          "code": {
            "type": "string",
            "description": "Product role internal code"
          },
          "description": {
            "type": "string",
            "description": "Product role description"
          },
          "label": {
            "type": "string",
            "description": "Product role label"
          }
        }
      },
      "ProductUserResource": {
        "title": "ProductUserResource",
        "type": "object",
        "properties": {
          "email": {
            "type": "string",
            "description": "User's personal email"
          },
          "id": {
            "type": "string",
            "description": "User's unique identifier",
            "format": "uuid"
          },
          "name": {
            "type": "string",
            "description": "User's name"
          },
          "product": {
            "description": "Authorized user product",
            "$ref": "#/components/schemas/ProductInfoResource"
          },
          "role": {
            "type": "string",
            "description": "User's role",
            "enum": [
              "ADMIN",
              "LIMITED"
            ]
          },
          "status": {
            "type": "string",
            "description": "User's status"
          },
          "surname": {
            "type": "string",
            "description": "User's surname"
          }
        }
      },
      "ProductsResource": {
        "title": "ProductsResource",
        "type": "object",
        "properties": {
          "activatedAt": {
            "type": "string",
            "description": "Date the products was activated",
            "format": "date-time"
          },
          "authorized": {
            "type": "boolean",
            "description": "flag indicating whether the logged user has the authorization to manage the product",
            "example": false
          },
          "backOfficeEnvironmentConfigurations": {
            "type": "array",
            "description": "Environment-specific configurations for back-office redirection with Token Exchange",
            "items": {
              "$ref": "#/components/schemas/BackOfficeConfigurationsResource"
            }
          },
          "children": {
            "type": "array",
            "description": "Product's sub products list",
            "items": {
              "$ref": "#/components/schemas/SubProductResource"
            }
          },
          "delegable": {
            "type": "boolean",
            "description": "If a product is delegable to a technical partner",
            "example": false
          },
          "description": {
            "type": "string",
            "description": "Product's description"
          },
          "id": {
            "type": "string",
            "description": "Product's unique identifier"
          },
          "imageUrl": {
            "type": "string",
            "description": "Product's depict image"
          },
          "invoiceable": {
            "type": "boolean",
            "description": "If a product is invoiceable",
            "example": false
          },
          "logo": {
            "type": "string",
            "description": "Product's logo"
          },
          "logoBgColor": {
            "type": "string",
            "description": "Product logo's background color"
          },
          "productOnBoardingStatus": {
            "type": "string",
            "description": "Product's onBoarding status",
            "enum": [
              "ACTIVE",
              "INACTIVE",
              "PENDING"
            ]
          },
          "status": {
            "type": "string",
            "description": "Product's status",
            "enum": [
              "ACTIVE",
              "INACTIVE",
              "PHASE_OUT",
              "TESTING"
            ]
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
          },
          "userRole": {
            "type": "string",
            "description": "Logged user's role"
          }
        }
      },
      "PspData": {
        "title": "PspData",
        "required": [
          "abiCode",
          "businessRegisterNumber",
          "legalRegisterName",
          "legalRegisterNumber",
          "vatNumberGroup"
        ],
        "type": "object",
        "properties": {
          "abiCode": {
            "type": "string",
            "description": "PSP's ABI code"
          },
          "businessRegisterNumber": {
            "type": "string",
            "description": "PSP's Business Register number"
          },
          "legalRegisterName": {
            "type": "string",
            "description": "PSP's legal register name"
          },
          "legalRegisterNumber": {
            "type": "string",
            "description": "PSP's legal register number"
          },
          "vatNumberGroup": {
            "type": "boolean",
            "description": "PSP's Vat Number group",
            "example": false
          }
        }
      },
      "SearchUserDto1": {
        "title": "SearchUserDto",
        "required": [
          "fiscalCode"
        ],
        "type": "object",
        "properties": {
          "fiscalCode": {
            "type": "string",
            "description": "User's fiscal code"
          }
        }
      },
      "SubProductResource": {
        "title": "SubProductResource",
        "type": "object",
        "properties": {
          "delegable": {
            "type": "boolean",
            "description": "If a product is delegable to a technical partner",
            "example": false
          },
          "description": {
            "type": "string",
            "description": "Product's description"
          },
          "id": {
            "type": "string",
            "description": "Product's unique identifier"
          },
          "imageUrl": {
            "type": "string",
            "description": "Product's depict image"
          },
          "invoiceable": {
            "type": "boolean",
            "description": "If a product is invoiceable",
            "example": false
          },
          "logo": {
            "type": "string",
            "description": "Product's logo"
          },
          "logoBgColor": {
            "type": "string",
            "description": "Product logo's background color"
          },
          "productOnBoardingStatus": {
            "type": "string",
            "description": "Product's onBoarding status",
            "enum": [
              "ACTIVE",
              "INACTIVE",
              "PENDING"
            ]
          },
          "status": {
            "type": "string",
            "description": "Product's status",
            "enum": [
              "ACTIVE",
              "INACTIVE",
              "PHASE_OUT",
              "TESTING"
            ]
          },
          "title": {
            "type": "string",
            "description": "Product's title"
          },
          "urlPublic": {
            "type": "string",
            "description": "URL that redirects to the public information webpage of the product"
          }
        }
      },
      "SupportContactResource": {
        "title": "SupportContactResource",
        "type": "object",
        "properties": {
          "supportEmail": {
            "type": "string",
            "description": "Institution's support email contact"
          },
          "supportPhone": {
            "type": "string",
            "description": "Institution's support phone contact"
          }
        }
      },
      "SupportRequestDto": {
        "title": "SupportRequestDto",
        "required": [
          "email"
        ],
        "type": "object",
        "properties": {
          "email": {
            "type": "string",
            "description": "User's email",
            "format": "email",
            "example": "email@example.com"
          },
          "productId": {
            "type": "string",
            "description": "Product's identifier"
          }
        }
      },
      "SupportResponse": {
        "title": "SupportResponse",
        "type": "object",
        "properties": {
          "redirectUrl": {
            "type": "string"
          }
        }
      },
      "UpdateInstitutionDto": {
        "title": "UpdateInstitutionDto",
        "type": "object",
        "properties": {
          "description": {
            "type": "string",
            "description": "Institution's description"
          },
          "digitalAddress": {
            "type": "string",
            "description": "Institution's email address"
          }
        }
      },
      "UpdateUserDto": {
        "title": "UpdateUserDto",
        "type": "object",
        "properties": {
          "email": {
            "type": "string",
            "description": "User's institutional email",
            "format": "email",
            "example": "email@example.com"
          },
          "name": {
            "type": "string",
            "description": "User's name"
          },
          "surname": {
            "type": "string",
            "description": "User's surname"
          }
        }
      },
      "UpdateUserGroupDto": {
        "title": "UpdateUserGroupDto",
        "required": [
          "description",
          "members",
          "name"
        ],
        "type": "object",
        "properties": {
          "description": {
            "type": "string",
            "description": "Users group's description"
          },
          "members": {
            "uniqueItems": true,
            "type": "array",
            "description": "List of all the members of the group",
            "items": {
              "type": "string",
              "format": "uuid"
            }
          },
          "name": {
            "type": "string",
            "description": "Users group's name"
          }
        }
      },
      "UserDto1": {
        "title": "UserDto",
        "required": [
          "email",
          "fiscalCode",
          "name",
          "surname"
        ],
        "type": "object",
        "properties": {
          "email": {
            "type": "string",
            "description": "User's institutional email",
            "format": "email",
            "example": "email@example.com"
          },
          "fiscalCode": {
            "type": "string",
            "description": "User's fiscal code"
          },
          "name": {
            "type": "string",
            "description": "User's name"
          },
          "surname": {
            "type": "string",
            "description": "User's surname"
          }
        }
      },
      "UserGroupIdResource": {
        "title": "UserGroupIdResource",
        "required": [
          "id"
        ],
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "Users group's unique identifier"
          }
        }
      },
      "UserGroupPlainResource": {
        "title": "UserGroupPlainResource",
        "type": "object",
        "properties": {
          "createdAt": {
            "type": "string",
            "description": "Date on which the group was created",
            "format": "date-time"
          },
          "createdBy": {
            "type": "string",
            "description": "User by which the group was created",
            "format": "uuid"
          },
          "description": {
            "type": "string",
            "description": "Users group's description"
          },
          "id": {
            "type": "string",
            "description": "Users group's unique identifier"
          },
          "institutionId": {
            "type": "string",
            "description": "Users group's institutionId"
          },
          "membersCount": {
            "type": "integer",
            "description": "Number all the members of the group",
            "format": "int32"
          },
          "modifiedAt": {
            "type": "string",
            "description": "Date on which the group was modified",
            "format": "date-time"
          },
          "modifiedBy": {
            "type": "string",
            "description": "User by which the group was modified",
            "format": "uuid"
          },
          "name": {
            "type": "string",
            "description": "Users group's name"
          },
          "productId": {
            "type": "string",
            "description": "Users group's productId"
          },
          "status": {
            "type": "string",
            "description": "Users group's status",
            "enum": [
              "ACTIVE",
              "DELETED",
              "SUSPENDED"
            ]
          }
        }
      },
      "UserGroupResource": {
        "title": "UserGroupResource",
        "type": "object",
        "properties": {
          "createdAt": {
            "type": "string",
            "description": "Date on which the group was created",
            "format": "date-time"
          },
          "createdBy": {
            "description": "User by which the group was created",
            "$ref": "#/components/schemas/PlainUserResource"
          },
          "description": {
            "type": "string",
            "description": "Users group's description"
          },
          "id": {
            "type": "string",
            "description": "Users group's unique identifier"
          },
          "institutionId": {
            "type": "string",
            "description": "Users group's institutionId"
          },
          "members": {
            "type": "array",
            "description": "List of all the members of the group",
            "items": {
              "$ref": "#/components/schemas/ProductUserResource"
            }
          },
          "modifiedAt": {
            "type": "string",
            "description": "Date on which the group was modified",
            "format": "date-time"
          },
          "modifiedBy": {
            "description": "User by which the group was modified",
            "$ref": "#/components/schemas/PlainUserResource"
          },
          "name": {
            "type": "string",
            "description": "Users group's name"
          },
          "productId": {
            "type": "string",
            "description": "Users group's productId"
          },
          "status": {
            "type": "string",
            "description": "Users group's status",
            "enum": [
              "ACTIVE",
              "DELETED",
              "SUSPENDED"
            ]
          }
        }
      },
      "UserIdResource": {
        "title": "UserIdResource",
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "User's unique identifier",
            "format": "uuid"
          }
        }
      },
      "UserInfo": {
        "title": "UserInfo",
        "required": [
          "email",
          "fiscalCode",
          "id",
          "name",
          "surname"
        ],
        "type": "object",
        "properties": {
          "email": {
            "type": "string",
            "description": "User's institutional email"
          },
          "fiscalCode": {
            "type": "string",
            "description": "User's fiscal code"
          },
          "id": {
            "type": "string",
            "description": "User's unique identifier",
            "format": "uuid"
          },
          "name": {
            "type": "string",
            "description": "User's name"
          },
          "surname": {
            "type": "string",
            "description": "User's surname"
          }
        }
      },
      "UserProductRoles": {
        "title": "UserProductRoles",
        "type": "object",
        "properties": {
          "productRoles": {
            "uniqueItems": true,
            "type": "array",
            "items": {
              "type": "string"
            }
          }
        }
      },
      "UserResource1": {
        "title": "UserResource",
        "type": "object",
        "properties": {
          "email": {
            "description": "User's institutional email",
            "$ref": "#/components/schemas/CertifiedFieldResourceOfstring"
          },
          "familyName": {
            "description": "User's surname",
            "$ref": "#/components/schemas/CertifiedFieldResourceOfstring"
          },
          "fiscalCode": {
            "type": "string",
            "description": "User's fiscal code"
          },
          "id": {
            "type": "string",
            "description": "User's unique identifier",
            "format": "uuid"
          },
          "name": {
            "description": "User's name",
            "$ref": "#/components/schemas/CertifiedFieldResourceOfstring"
          }
        }
      },
      "CreateUserGroupDto1": {
        "title": "CreateUserGroupDto",
        "required": [
          "description",
          "institutionId",
          "members",
          "name",
          "productId",
          "status"
        ],
        "type": "object",
        "properties": {
          "description": {
            "type": "string",
            "description": "Users group's description"
          },
          "institutionId": {
            "type": "string",
            "description": "Users group's institutionId"
          },
          "members": {
            "uniqueItems": true,
            "type": "array",
            "description": "List of all the members of the group",
            "items": {
              "type": "string",
              "format": "uuid"
            }
          },
          "name": {
            "type": "string",
            "description": "Users group's name"
          },
          "productId": {
            "type": "string",
            "description": "Users group's productId"
          },
          "status": {
            "type": "string",
            "description": "Users group's status",
            "enum": [
              "ACTIVE",
              "DELETED",
              "SUSPENDED"
            ]
          }
        }
      },
      "PageOfUserGroupResource": {
        "title": "PageOfUserGroupResource",
        "required": [
          "content",
          "number",
          "size",
          "totalElements",
          "totalPages"
        ],
        "type": "object",
        "properties": {
          "content": {
            "type": "array",
            "description": "The page content",
            "items": {
              "$ref": "#/components/schemas/UserGroupResource1"
            }
          },
          "number": {
            "type": "integer",
            "description": "The number of the current page",
            "format": "int32"
          },
          "size": {
            "type": "integer",
            "description": "The size of the page",
            "format": "int32"
          },
          "totalElements": {
            "type": "integer",
            "description": "The total amount of elements",
            "format": "int64"
          },
          "totalPages": {
            "type": "integer",
            "description": "The number of total pages",
            "format": "int32"
          }
        }
      },
      "Problem3": {
        "title": "Problem",
        "required": [
          "status",
          "title"
        ],
        "type": "object",
        "properties": {
          "detail": {
            "type": "string",
            "description": "Human-readable description of this specific problem."
          },
          "instance": {
            "type": "string",
            "description": "A URI that describes where the problem occurred."
          },
          "invalidParams": {
            "type": "array",
            "description": "A list of invalid parameters details.",
            "items": {
              "$ref": "#/components/schemas/InvalidParam"
            }
          },
          "status": {
            "type": "integer",
            "description": "The HTTP status code.",
            "format": "int32",
            "example": 500
          },
          "title": {
            "type": "string",
            "description": "Short human-readable summary of the problem."
          },
          "type": {
            "type": "string",
            "description": "A URL to a page with more details regarding the problem."
          }
        },
        "description": "A \"problem detail\" as a way to carry machine-readable details of errors (https://datatracker.ietf.org/doc/html/rfc7807)"
      },
      "UserGroupResource1": {
        "title": "UserGroupResource",
        "type": "object",
        "properties": {
          "createdAt": {
            "type": "string",
            "description": "Date on which the group was created",
            "format": "date-time"
          },
          "createdBy": {
            "type": "string",
            "description": "User by which the group was created"
          },
          "description": {
            "type": "string",
            "description": "Users group's description"
          },
          "id": {
            "type": "string",
            "description": "Users group's unique identifier"
          },
          "institutionId": {
            "type": "string",
            "description": "Users group's institutionId"
          },
          "members": {
            "type": "array",
            "description": "List of all the members of the group",
            "items": {
              "type": "string",
              "format": "uuid"
            }
          },
          "modifiedAt": {
            "type": "string",
            "description": "Date on which the group was modified",
            "format": "date-time"
          },
          "modifiedBy": {
            "type": "string",
            "description": "User by which the group was modified"
          },
          "name": {
            "type": "string",
            "description": "Users group's name"
          },
          "productId": {
            "type": "string",
            "description": "Users group's productId"
          },
          "status": {
            "type": "string",
            "description": "Users group's status",
            "enum": [
              "ACTIVE",
              "DELETED",
              "SUSPENDED"
            ]
          }
        }
      },
      "BackOfficeConfigurations": {
        "title": "BackOfficeConfigurations",
        "type": "object",
        "properties": {
          "identityTokenAudience": {
            "type": "string"
          },
          "url": {
            "type": "string"
          }
        }
      },
      "BackOfficeConfigurationsResource1": {
        "title": "BackOfficeConfigurationsResource",
        "required": [
          "identityTokenAudience",
          "url"
        ],
        "type": "object",
        "properties": {
          "identityTokenAudience": {
            "type": "string",
            "description": "Product's identity token audience"
          },
          "url": {
            "type": "string",
            "description": "URL that redirects to the back-office section, where is possible to manage the product"
          }
        }
      },
      "ContractOperations": {
        "title": "ContractOperations",
        "type": "object",
        "properties": {
          "contractTemplatePath": {
            "type": "string"
          },
          "contractTemplateUpdatedAt": {
            "type": "string",
            "format": "date-time"
          },
          "contractTemplateVersion": {
            "type": "string"
          }
        }
      },
      "ContractResource": {
        "title": "ContractResource",
        "type": "object",
        "properties": {
          "contractTemplatePath": {
            "type": "string",
            "description": "The path of contract"
          },
          "contractTemplateUpdatedAt": {
            "type": "string",
            "description": "Date the contract was postponed",
            "format": "date-time"
          },
          "contractTemplateVersion": {
            "type": "string",
            "description": "Version of the contract"
          }
        }
      },
      "CreateProductDto": {
        "title": "CreateProductDto",
        "required": [
          "contractTemplatePath",
          "contractTemplateVersion",
          "description",
          "id",
          "identityTokenAudience",
          "roleMappings",
          "title",
          "urlBO",
          "urlPublic"
        ],
        "type": "object",
        "properties": {
          "backOfficeEnvironmentConfigurations": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/BackOfficeConfigurationsResource1"
            },
            "description": "Environment-specific configurations for back-office redirection with Token Exchange"
          },
          "contractTemplatePath": {
            "type": "string",
            "description": "The path of contract"
          },
          "contractTemplateVersion": {
            "type": "string",
            "description": "Version of the contract"
          },
          "description": {
            "type": "string",
            "description": "Product's description"
          },
          "id": {
            "type": "string",
            "description": "Product's unique identifier"
          },
          "identityTokenAudience": {
            "type": "string",
            "description": "Product's identity token audience"
          },
          "institutionContractMappings": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/ContractResource"
            },
            "description": "Product contract based on institutionType"
          },
          "logoBgColor": {
            "pattern": "^#[0-9A-F]{6}$",
            "type": "string",
            "description": "Product logo's background color",
            "example": "#000000"
          },
          "roleMappings": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/ProductRoleInfoReq"
            },
            "description": "Mappings between Party's and Product's role"
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
      },
      "CreateSubProductDto": {
        "title": "CreateSubProductDto",
        "required": [
          "contractTemplatePath",
          "contractTemplateVersion",
          "id",
          "title"
        ],
        "type": "object",
        "properties": {
          "contractTemplatePath": {
            "type": "string",
            "description": "The path of contract"
          },
          "contractTemplateVersion": {
            "type": "string",
            "description": "Version of the contract"
          },
          "id": {
            "type": "string",
            "description": "Product's unique identifier"
          },
          "institutionContractMappings": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/ContractResource"
            },
            "description": "Product contract based on institutionType"
          },
          "title": {
            "type": "string",
            "description": "Product's title"
          }
        }
      },
      "Problem4": {
        "title": "Problem",
        "required": [
          "status",
          "title"
        ],
        "type": "object",
        "properties": {
          "detail": {
            "type": "string",
            "description": "Human-readable description of this specific problem."
          },
          "instance": {
            "type": "string",
            "description": "A URI that describes where the problem occurred."
          },
          "invalidParams": {
            "type": "array",
            "description": "A list of invalid parameters details.",
            "items": {
              "$ref": "#/components/schemas/InvalidParam"
            }
          },
          "status": {
            "type": "integer",
            "description": "The HTTP status code.",
            "format": "int32",
            "example": 500
          },
          "title": {
            "type": "string",
            "description": "Short human-readable summary of the problem."
          },
          "type": {
            "type": "string",
            "description": "A URL to a page with more details regarding the problem."
          }
        },
        "description": "A \"problem detail\" as a way to carry machine-readable details of errors (https://datatracker.ietf.org/doc/html/rfc7807)"
      },
      "ProductOperations": {
        "title": "ProductOperations",
        "type": "object",
        "properties": {
          "backOfficeEnvironmentConfigurations": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/BackOfficeConfigurations"
            }
          },
          "contractTemplatePath": {
            "type": "string"
          },
          "contractTemplateUpdatedAt": {
            "type": "string",
            "format": "date-time"
          },
          "contractTemplateVersion": {
            "type": "string"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "createdBy": {
            "type": "string"
          },
          "delegable": {
            "type": "boolean"
          },
          "depictImageUrl": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "enabled": {
            "type": "boolean"
          },
          "id": {
            "type": "string"
          },
          "identityTokenAudience": {
            "type": "string"
          },
          "institutionContractMappings": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/ContractOperations"
            }
          },
          "invoiceable": {
            "type": "boolean"
          },
          "logo": {
            "type": "string"
          },
          "logoBgColor": {
            "type": "string"
          },
          "modifiedAt": {
            "type": "string",
            "format": "date-time"
          },
          "modifiedBy": {
            "type": "string"
          },
          "parentId": {
            "type": "string"
          },
          "productOperations": {
            "$ref": "#/components/schemas/ProductOperations"
          },
          "roleManagementURL": {
            "type": "string"
          },
          "roleMappings": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/ProductRoleInfoOperations"
            }
          },
          "status": {
            "type": "string",
            "enum": [
              "ACTIVE",
              "INACTIVE",
              "PHASE_OUT",
              "TESTING"
            ]
          },
          "title": {
            "type": "string"
          },
          "urlBO": {
            "type": "string"
          },
          "urlPublic": {
            "type": "string"
          }
        }
      },
      "ProductResource1": {
        "title": "ProductResource",
        "type": "object",
        "properties": {
          "backOfficeEnvironmentConfigurations": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/BackOfficeConfigurationsResource1"
            },
            "description": "Environment-specific configurations for back-office redirection with Token Exchange"
          },
          "contractTemplatePath": {
            "type": "string",
            "description": "The path of contract"
          },
          "contractTemplateUpdatedAt": {
            "type": "string",
            "description": "Date the contract was postponed",
            "format": "date-time"
          },
          "contractTemplateVersion": {
            "type": "string",
            "description": "Version of the contract"
          },
          "createdAt": {
            "type": "string",
            "description": "Creation/activation date and time",
            "format": "date-time"
          },
          "createdBy": {
            "type": "string",
            "description": "User who created/activated the resource",
            "format": "uuid"
          },
          "delegable": {
            "type": "boolean",
            "description": "If a product is delegable to a technical partner ",
            "example": false
          },
          "depictImageUrl": {
            "type": "string",
            "description": "Product's depiction image url"
          },
          "description": {
            "type": "string",
            "description": "Product's description"
          },
          "id": {
            "type": "string",
            "description": "Product's unique identifier"
          },
          "identityTokenAudience": {
            "type": "string",
            "description": "Product's identity token audience"
          },
          "invoiceable": {
            "type": "boolean",
            "description": "If a product is invoiceable",
            "example": false
          },
          "logo": {
            "type": "string",
            "description": "Product's logo url"
          },
          "logoBgColor": {
            "type": "string",
            "description": "Product logo's background color",
            "example": "#000000"
          },
          "modifiedAt": {
            "type": "string",
            "description": "Last modified date and time",
            "format": "date-time"
          },
          "modifiedBy": {
            "type": "string",
            "description": "User who modified the resource",
            "format": "uuid"
          },
          "parentId": {
            "type": "string",
            "description": "Root parent of the sub product"
          },
          "productOperations": {
            "$ref": "#/components/schemas/ProductOperations"
          },
          "roleManagementURL": {
            "type": "string",
            "description": "Url of the utilities management"
          },
          "roleMappings": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/ProductRoleInfoRes"
            },
            "description": "Mappings between Party's and Product's role"
          },
          "status": {
            "type": "string",
            "description": "Product's status",
            "enum": [
              "ACTIVE",
              "INACTIVE",
              "PHASE_OUT",
              "TESTING"
            ]
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
      },
      "ProductRoleInfoOperations": {
        "title": "ProductRoleInfoOperations",
        "type": "object",
        "properties": {
          "multiroleAllowed": {
            "type": "boolean"
          },
          "roles": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/ProductRoleOperations"
            }
          }
        }
      },
      "ProductRoleInfoReq": {
        "title": "ProductRoleInfoReq",
        "required": [
          "multiroleAllowed",
          "roles"
        ],
        "type": "object",
        "properties": {
          "multiroleAllowed": {
            "type": "boolean",
            "description": "Flag indicating if a User can have more than one product role",
            "example": false
          },
          "roles": {
            "type": "array",
            "description": "Available product roles",
            "items": {
              "$ref": "#/components/schemas/ProductRoleOperations"
            }
          }
        }
      },
      "ProductRoleInfoRes": {
        "title": "ProductRoleInfoRes",
        "required": [
          "multiroleAllowed",
          "roles"
        ],
        "type": "object",
        "properties": {
          "multiroleAllowed": {
            "type": "boolean",
            "description": "Flag indicating if a User can have more than one product role",
            "example": false
          },
          "roles": {
            "type": "array",
            "description": "Available product roles",
            "items": {
              "$ref": "#/components/schemas/ProductRole"
            }
          }
        }
      },
      "ProductRoleOperations": {
        "title": "ProductRoleOperations",
        "type": "object",
        "properties": {
          "code": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "label": {
            "type": "string"
          }
        }
      },
      "ProductTreeResource": {
        "title": "ProductTreeResource",
        "type": "object",
        "properties": {
          "children": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/ProductResource1"
            }
          },
          "node": {
            "$ref": "#/components/schemas/ProductResource1"
          }
        }
      },
      "UpdateProductDto": {
        "title": "UpdateProductDto",
        "required": [
          "contractTemplatePath",
          "contractTemplateVersion",
          "description",
          "identityTokenAudience",
          "roleMappings",
          "title",
          "urlBO",
          "urlPublic"
        ],
        "type": "object",
        "properties": {
          "backOfficeEnvironmentConfigurations": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/BackOfficeConfigurationsResource1"
            },
            "description": "Environment-specific configurations for back-office redirection with Token Exchange"
          },
          "contractTemplatePath": {
            "type": "string",
            "description": "The path of contract"
          },
          "contractTemplateVersion": {
            "type": "string",
            "description": "Version of the contract"
          },
          "description": {
            "type": "string",
            "description": "Product's description"
          },
          "identityTokenAudience": {
            "type": "string",
            "description": "Product's identity token audience"
          },
          "institutionContractMappings": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/ContractResource"
            },
            "description": "Product contract based on institutionType"
          },
          "logoBgColor": {
            "pattern": "^#[0-9A-F]{6}$",
            "type": "string",
            "description": "Product logo's background color",
            "example": "#000000"
          },
          "roleMappings": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/ProductRoleInfoReq"
            },
            "description": "Mappings between Party's and Product's role"
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
      },
      "UpdateSubProductDto": {
        "title": "UpdateSubProductDto",
        "required": [
          "contractTemplatePath",
          "contractTemplateVersion",
          "title"
        ],
        "type": "object",
        "properties": {
          "contractTemplatePath": {
            "type": "string",
            "description": "The path of contract"
          },
          "contractTemplateVersion": {
            "type": "string",
            "description": "Version of the contract"
          },
          "institutionContractMappings": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/ContractResource"
            },
            "description": "Product contract based on institutionType"
          },
          "title": {
            "type": "string",
            "description": "Product's title"
          }
        }
      },
      "AckPayloadRequest": {
        "title": "AckPayloadRequest",
        "required": [
          "message"
        ],
        "type": "object",
        "properties": {
          "message": {
            "type": "string",
            "description": "Acknowledgment request payload message"
          }
        }
      },
      "Problem5": {
        "title": "Problem",
        "required": [
          "status",
          "title"
        ],
        "type": "object",
        "properties": {
          "detail": {
            "type": "string",
            "description": "Human-readable description of this specific problem."
          },
          "instance": {
            "type": "string",
            "description": "A URI that describes where the problem occurred."
          },
          "invalidParams": {
            "type": "array",
            "description": "A list of invalid parameters details.",
            "items": {
              "$ref": "#/components/schemas/InvalidParam"
            }
          },
          "status": {
            "type": "integer",
            "description": "The HTTP status code.",
            "format": "int32",
            "example": 500
          },
          "title": {
            "type": "string",
            "description": "Short human-readable summary of the problem."
          },
          "type": {
            "type": "string",
            "description": "A URL to a page with more details regarding the problem."
          }
        },
        "description": "A \"problem detail\" as a way to carry machine-readable details of errors (https://datatracker.ietf.org/doc/html/rfc7807)"
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