openapi: 3.0.1
info:
  title: Party Registry Proxy
  description: Party Registry Proxy API documentation
  version: 'v1'
servers:
  - url: 'https://${host}/${basePath}'
    description: This service is the party process
paths:
  /v1/categories:
    get:
      tags:
        - category
      summary: Get all categories
      description: Returns the categories list
      operationId: findCategoriesUsingGET
      parameters:
        - name: origin
          in: query
          description: Describes which is the source of data
          schema:
            enum:
              - INFOCAMERE
              - IPA
            type: string
        - name: page
          in: query
          description: Format - int32. page
          schema:
            type: integer
            format: int32
        - name: limit
          in: query
          description: Format - int32. limit
          schema:
            type: integer
            format: int32
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/CategoriesResource'
              example:
                items:
                  - code: string
                    id: string
                    kind: string
                    name: string
                    origin: INFOCAMERE
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
              example:
                detail: string
                instance: string
                invalidParams:
                  - name: string
                    reason: string
                status: 500
                title: string
                type: string
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
              example:
                detail: string
                instance: string
                invalidParams:
                  - name: string
                    reason: string
                status: 500
                title: string
                type: string
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
              example:
                detail: string
                instance: string
                invalidParams:
                  - name: string
                    reason: string
                status: 500
                title: string
                type: string
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
              example:
                detail: string
                instance: string
                invalidParams:
                  - name: string
                    reason: string
                status: 500
                title: string
                type: string
  '/v1/origins/{origin}/categories/{code}':
    get:
      tags:
        - category
      summary: Get a category
      description: Returns a category
      operationId: findCategoryUsingGET
      parameters:
        - name: origin
          in: path
          description: Describes which is the source of data
          required: true
          schema:
            enum:
              - INFOCAMERE
              - IPA
            type: string
        - name: code
          in: path
          description: code
          required: true
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/CategoryResource'
              example:
                code: string
                id: string
                kind: string
                name: string
                origin: INFOCAMERE
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
              example:
                detail: string
                instance: string
                invalidParams:
                  - name: string
                    reason: string
                status: 500
                title: string
                type: string
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
              example:
                detail: string
                instance: string
                invalidParams:
                  - name: string
                    reason: string
                status: 500
                title: string
                type: string
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
              example:
                detail: string
                instance: string
                invalidParams:
                  - name: string
                    reason: string
                status: 500
                title: string
                type: string
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
              example:
                detail: string
                instance: string
                invalidParams:
                  - name: string
                    reason: string
                status: 500
                title: string
                type: string
  /v1/institutions/:
    get:
      tags:
        - institution
      summary: Search institutions
      description: Returns a list of Institutions.
      operationId: searchUsingGET
      parameters:
        - name: search
          in: query
          description: 'if passed, the result is filtered based on the contained value.'
          schema:
            type: string
        - name: page
          in: query
          description: Format - int32. page
          schema:
            type: integer
            format: int32
        - name: limit
          in: query
          description: Format - int32. limit
          schema:
            type: integer
            format: int32
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/InstitutionsResource'
              example:
                count: 0
                items:
                  - address: string
                    aoo: string
                    category: string
                    description: string
                    digitalAddress: email@example.com
                    id: string
                    o: string
                    origin: INFOCAMERE
                    originId: string
                    ou: string
                    taxCode: string
                    zipCode: string
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
              example:
                detail: string
                instance: string
                invalidParams:
                  - name: string
                    reason: string
                status: 500
                title: string
                type: string
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
              example:
                detail: string
                instance: string
                invalidParams:
                  - name: string
                    reason: string
                status: 500
                title: string
                type: string
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
              example:
                detail: string
                instance: string
                invalidParams:
                  - name: string
                    reason: string
                status: 500
                title: string
                type: string
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
              example:
                detail: string
                instance: string
                invalidParams:
                  - name: string
                    reason: string
                status: 500
                title: string
                type: string
  /v1/institutions/{id}:
    get:
      tags:
        - institution
      summary: Find institution by ID
      description: 'Returns a single institution. If ''origin'' param is filled, the ID to find is treated as ''originId'' ($ref: ''#/components/schemas/Institution''); otherwise is treated as ''id'' ($ref: ''#/components/schemas/Institution'') '
      operationId: findInstitutionUsingGET
      parameters:
        - name: id
          in: path
          description: The institution ID. It change semantic based on the origin param value (see notes)
          required: true
          schema:
            type: string
        - name: origin
          in: query
          description: Describes which is the source of data
          schema:
            enum:
              - INFOCAMERE
              - IPA
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/InstitutionResource'
              example:
                address: string
                aoo: string
                category: string
                description: string
                digitalAddress: email@example.com
                id: string
                o: string
                origin: INFOCAMERE
                originId: string
                ou: string
                taxCode: string
                zipCode: string
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
              example:
                detail: string
                instance: string
                invalidParams:
                  - name: string
                    reason: string
                status: 500
                title: string
                type: string
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
              example:
                detail: string
                instance: string
                invalidParams:
                  - name: string
                    reason: string
                status: 500
                title: string
                type: string
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
              example:
                detail: string
                instance: string
                invalidParams:
                  - name: string
                    reason: string
                status: 500
                title: string
                type: string
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
              example:
                detail: string
                instance: string
                invalidParams:
                  - name: string
                    reason: string
                status: 500
                title: string
                type: string
  /v1/national-registries/legal-address:
    get:
      tags:
        - nationalRegistries
      summary: Retrieve legalAddress
      description: Get the legal address of the business
      operationId: legalAddressUsingGET
      parameters:
        - name: taxId
          in: query
          description: taxId
          required: true
          style: form
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/LegalAddressResponse'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
components:
  schemas:
    CategoriesResource:
      title: CategoriesResource
      required:
        - items
      type: object
      properties:
        items:
          type: array
          items:
            $ref: '#/components/schemas/CategoryResource'
    CategoryResource:
      title: CategoryResource
      required:
        - code
        - kind
        - name
        - origin
      type: object
      properties:
        code:
          type: string
        id:
          type: string
        kind:
          type: string
        name:
          type: string
        origin:
          enum:
            - INFOCAMERE
            - IPA
          type: string
          description: Describes which is the source of data
    InstitutionResource:
      title: InstitutionResource
      required:
        - address
        - description
        - digitalAddress
        - id
        - origin
        - originId
        - taxCode
        - zipCode
      type: object
      properties:
        address:
          type: string
          description: Institution address
        aoo:
          type: string
          description: aoo
        category:
          type: string
          description: Institution category
        description:
          type: string
          description: Institution description
        digitalAddress:
          type: string
          description: Digital institution address
          format: email
          example: email@example.com
        id:
          type: string
          description: Semantic id to recognize a party between origins (or externalId)
        o:
          type: string
          description: o
        origin:
          enum:
            - INFOCAMERE
            - IPA
          type: string
          description: Describes which is the source of data
        originId:
          type: string
          description: Id of the institution from its origin
        ou:
          type: string
          description: ou
        taxCode:
          type: string
          description: Institution fiscal code
        zipCode:
          type: string
          description: Institution zipCode
    InstitutionsResource:
      title: InstitutionsResource
      required:
        - count
        - items
      type: object
      properties:
        count:
          type: integer
          format: int64
        items:
          type: array
          items:
            $ref: '#/components/schemas/InstitutionResource'
    LegalAddressResponse:
      title: LegalAddressResponse
      type: object
      properties:
        address:
          type: string
        zipCode:
          type: string
    InvalidParam:
      title: InvalidParam
      required:
        - name
        - reason
      type: object
      properties:
        name:
          type: string
          description: Invalid parameter name.
        reason:
          type: string
          description: Invalid parameter reason.
    Problem:
      title: Problem
      required:
        - status
        - title
      type: object
      properties:
        detail:
          type: string
          description: Human-readable description of this specific problem.
        instance:
          type: string
          description: A URI that describes where the problem occurred.
        invalidParams:
          type: array
          items:
            $ref: '#/components/schemas/InvalidParam'
          description: A list of invalid parameters details.
        status:
          type: integer
          description: The HTTP status code.
          format: int32
          example: 500
        title:
          type: string
          description: Short human-readable summary of the problem.
        type:
          type: string
          description: A URL to a page with more details regarding the problem.
      description: A "problem detail" as a way to carry machine-readable details of errors (https://datatracker.ietf.org/doc/html/rfc7807)
  securitySchemes:
    apiKeyHeader:
      type: apiKey
      name: Ocp-Apim-Subscription-Key
      in: header
    apiKeyQuery:
      type: apiKey
      name: subscription-key
      in: query
security:
  - apiKeyHeader: [ ]
  - apiKeyQuery: [ ]
tags:
  - name: category
    description: Category operations
  - name: institution
    description: Institution operations
