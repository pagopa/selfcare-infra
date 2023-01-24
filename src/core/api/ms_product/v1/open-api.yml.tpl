openapi: 3.0.3
info:
  title: selc-product
  description: The services described in this section deal with the management of the Product entity, providing the necessary methods for its creation, consultation and activation.
  version: 0.0.1-SNAPSHOT
servers:
- url: 'https://${host}/${basePath}'
tags:
  - name: product
    description: Product's endpoints for CRUD operations
paths:
  "/products/{id}":
    get:
      tags:
        - product
      summary: getProduct
      description: Service that returns the information for a single product given its product id
      operationId: getProductUsingGET
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: id
          in: path
          description: Product's unique identifier
          required: true
          style: simple
          schema:
            type: string
        - name: institutionType
          in: query
          description: Institution's type
          required: false
          style: form
          schema:
            type: string
            enum:
              - GSP
              - PA
              - PSP
              - PT
              - SCP
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProductResource'
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
      security:
        - bearerAuth:
            - global
components:
  schemas:
    BackOfficeConfigurationsResource:
      title: BackOfficeConfigurationsResource
      required:
        - identityTokenAudience
        - url
      type: object
      properties:
        identityTokenAudience:
          type: string
          description: Product's identity token audience
        url:
          type: string
          description: URL that redirects to the back-office section, where is possible to manage the product
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
          description: A list of invalid parameters details.
          items:
            $ref: '#/components/schemas/InvalidParam'
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
    ProductResource:
      title: ProductResource
      required:
        - contractTemplatePath
        - contractTemplateUpdatedAt
        - contractTemplateVersion
        - createdAt
        - id
        - status
        - title
      type: object
      properties:
        backOfficeEnvironmentConfigurations:
          type: object
          additionalProperties:
            $ref: '#/components/schemas/BackOfficeConfigurationsResource'
          description: Environment-specific configurations for back-office redirection with Token Exchange
        contractTemplatePath:
          type: string
          description: The path of contract
        contractTemplateUpdatedAt:
          type: string
          description: Date the contract was postponed
          format: date-time
        contractTemplateVersion:
          type: string
          description: Version of the contract
        createdAt:
          type: string
          description: Creation/activation date and time
          format: date-time
        createdBy:
          type: string
          description: User who created/activated the resource
          format: uuid
        depictImageUrl:
          type: string
          description: Product's depiction image url
        description:
          type: string
          description: Product's description
        id:
          type: string
          description: Product's unique identifier
        identityTokenAudience:
          type: string
          description: Product's identity token audience
        logo:
          type: string
          description: Product's logo url
        logoBgColor:
          pattern: ^#[0-9A-F]{6}$
          type: string
          description: Product logo's background color
          example: '#000000'
        modifiedAt:
          type: string
          description: Last modified date and time
          format: date-time
        modifiedBy:
          type: string
          description: User who modified the resource
          format: uuid
        parentId:
          type: string
          description: Root parent of the sub product
        roleMappings:
          type: object
          additionalProperties:
            $ref: '#/components/schemas/ProductRoleInfo'
          description: Mappings between Party's and Product's role
        status:
          type: string
          description: Product's status
          enum:
            - ACTIVE
            - INACTIVE
            - PHASE_OUT
            - TESTING
        title:
          type: string
          description: Product's title
        urlBO:
          type: string
          description: URL that redirects to the back-office section, where is possible to manage the product
        urlPublic:
          type: string
          description: URL that redirects to the public information webpage of the product
    ProductRole:
      title: ProductRole
      required:
        - code
        - description
        - label
      type: object
      properties:
        code:
          type: string
          description: Product role internal code
        description:
          type: string
          description: Product role description
        label:
          type: string
          description: Product role label
    ProductRoleInfo:
      title: ProductRoleInfo
      required:
        - multiroleAllowed
        - roles
      type: object
      properties:
        multiroleAllowed:
          type: boolean
          description: Flag indicating if a User can have more than one product role
          example: false
        roles:
          type: array
          description: Available product roles
          items:
            $ref: '#/components/schemas/ProductRole'
  securitySchemes:
    bearerAuth:
      type: http
      description: A bearer token in the format of a JWS and conformed to the specifications included in [RFC8725](https://tools.ietf.org/html/RFC8725)
      scheme: bearer
      bearerFormat: JWT