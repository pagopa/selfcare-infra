openapi: 3.0.3
info:
  title: Party Process Micro Service
  description: This service is the party process
  version: 'v1'
  contact:
    name: API Support
    url: 'http://www.example.com/support'
    email: support@example.com
  termsOfService: 'http://swagger.io/terms/'
  x-api-id: an x-api-id
  x-summary: an x-summary
servers:
  - url: 'https://${host}/${basePath}'
    description: This service is the party process
security:
  - bearerAuth: [ ]
tags:
  - name: process
    description: Implements party process
    externalDocs:
      description: Find out more
      url: 'http://swagger.io'
  - name: platform
    description: Implements platform endpoints
    externalDocs:
      description: Find out more
      url: 'http://swagger.io'
  - name: health
    description: Verify service status
    externalDocs:
      description: Find out more
      url: 'http://swagger.io'
paths:
  '/onboarding/info/':
    get:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: get on boarding info
      description: Return ok
      operationId: getOnBoardingInfo
      parameters:
        - name: institutionId
          description: UUID of an institution you can filter the retrieval with
          in: query
          schema:
            type: string
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OnBoardingInfo'
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /onboarding/organization:
    post:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: Organization onboarding on the platform
      description: it performs the onboarding of a new organization on the platform
      operationId: onboardingOrganization
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OnBoardingRequest'
      responses:
        '201':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OnBoardingResponse'
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /onboarding/legals:
    post:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: legals onboarding
      description: creates legals entries on already onboarded institution
      operationId: onboardingLegalsOnOrganization
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OnBoardingRequest'
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OnBoardingResponse'
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'

  /onboarding/operators:
    post:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: operators onboarding
      description: performs operators onboarding on an already existing organization
      operationId: onboardingOperators
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OnBoardingRequest'
      responses:
        '201':
          description: successful operation
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /institutions/{institutionId}/relationships:
    get:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: returns the relationships related to the institution
      description: Return ok
      operationId: getUserInstitutionRelationships
      parameters:
        - name: institutionId
          in: path
          description: The identifier of the institution
          required: true
          schema:
            type: string
            format: uuid
        - name: products
          description: comma separated sequence of products to filter the response with
          in: query
          schema:
            type: string
        - name: productRoles
          description: comma separated sequence of product roles to filter the response with
          in: query
          schema:
            type: string
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/RelationshipsResponse'
        '400':
          description: Invalid institution id supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /institutions/{institutionId}/products:
    post:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: institution products replacement
      description: replaces institution's products with the set passed as payload
      operationId: replaceInstitutionProducts
      parameters:
        - name: institutionId
          in: path
          description: The identifier of the institution
          required: true
          schema:
            type: string
            format: uuid
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Products'
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Institution'
        '404':
          description: Institution not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
    get:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: institution products retrieval
      description: retrieves the products this institution is related to.
      operationId: retrieveInstitutionProducts
      parameters:
        - name: institutionId
          in: path
          description: The identifier of the institution
          required: true
          schema:
            type: string
            format: uuid
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Products'
        '404':
          description: Institution not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /relationships/{relationshipId}:
    get:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: Gets the corresponding relationship
      description: Gets relationship
      operationId: getRelationship
      parameters:
        - name: relationshipId
          in: path
          description: The identifier of the relationship
          required: true
          schema:
            type: string
            format: uuid
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/RelationshipInfo'
        '400':
          description: Invalid id supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
    delete:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: Relationship deletion
      description: Given a relationship identifier, it deletes the corresponding relationship.
      operationId: deleteRelationshipById
      parameters:
        - name: relationshipId
          description: the identifier of the relationship to be deleted
          required: true
          in: path
          schema:
            type: string
            format: uuid
      responses:
        '204':
          description: relationship deleted
        '400':
          description: Bad request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Relationship not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /relationships/{relationshipId}/activate:
    post:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: Activate the relationship
      description: Activate relationship
      operationId: activateRelationship
      parameters:
        - name: relationshipId
          in: path
          description: The identifier of the relationship
          required: true
          schema:
            type: string
            format: uuid
      responses:
        '204':
          description: Successful operation
        '400':
          description: Invalid id supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /relationships/{relationshipId}/suspend:
    post:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: Suspend the relationship
      description: Suspend relationship
      operationId: suspendRelationship
      parameters:
        - name: relationshipId
          in: path
          description: The identifier of the relationship
          required: true
          schema:
            type: string
            format: uuid
      responses:
        '204':
          description: Successful operation
        '400':
          description: Invalid id supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /relationships/{relationshipId}/products:
    post:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: relationship products replacement
      description: replaces relationships's products with the set passed as payload
      operationId: replaceRelationshipProducts
      parameters:
        - name: relationshipId
          in: path
          description: The identifier of the relationship
          required: true
          schema:
            type: string
            format: uuid
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Products'
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/RelationshipInfo'
        '404':
          description: Relationship not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  '/onboarding/complete/{token}':
    post:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: create an onboarding entry
      description: Return ok
      operationId: confirmOnBoarding
      parameters:
        - name: token
          in: path
          description: the token containing the onboardind information
          required: true
          schema:
            type: string
      requestBody:
        description: A E-Service seed
        content:
          multipart/form-data:
            schema:
              type: object
              required:
                - contract
              properties:
                contract:
                  type: string
                  format: binary
            encoding:
              contract:
                contentType: application/octet-stream
        required: true
      responses:
        '200':
          description: successful operation
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
    delete:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: invalidate an onboarding request
      description: Return ok
      operationId: invalidateOnboarding
      parameters:
        - name: token
          in: path
          description: The token to invalidate
          required: true
          schema:
            type: string
      responses:
        '200':
          description: successful operation
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /onboarding/relationship/{relationshipId}/document:
    get:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: Get an onboarding document
      operationId: getOnboardingDocument
      parameters:
        - name: relationshipId
          in: path
          description: the relationship id
          required: true
          schema:
            type: string
      responses:
        "200":
          description: Signed onboarding document retrieved
          content:
            application/octet-stream:
              schema:
                type: string
                format: binary
        "404":
          description: Document not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        "400":
          description: Bad request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /status:
    get:
      security:
        - bearerAuth: [ ]
      tags:
        - health
      summary: Health status endpoint
      description: Return ok
      operationId: getStatus
      responses:
        '200':
          description: successful operation
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /platform/roles:
    get:
      summary: Get Platform Roles
      tags:
        - platform
      responses:
        '200':
          description: Available platform roles' bindings.
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProductRolesResponse'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      operationId: getProductRoles
      description: Returns all the available bindings between roles and platform roles.
components:
  schemas:
    OnBoardingRequest:
      properties:
        users:
          type: array
          items:
            $ref: '#/components/schemas/User'
        institutionId:
          type: string
      additionalProperties: false
      required:
        - users
        - institutionId
    OnBoardingResponse:
      properties:
        token:
          type: string
        document:
          type: string
          format: binary
      additionalProperties: false
      required:
        - token
        - document
    RelationshipInfo:
      type: object
      properties:
        id:
          type: string
          format: uuid
        from:
          type: string
          format: uuid
        role:
          $ref: '#/components/schemas/PartyRole'
        products:
          type: array
          description: set of products bound to this relationship
          uniqueItems: true
          items:
            type: string
        productRole:
          type: string
          description: 'user role in the application context (e.g.: administrator, security user). This MUST belong to the configured set of application specific platform roles'
        state:
          $ref: '#/components/schemas/RelationshipState'
      additionalProperties: false
      required:
        - id
        - from
        - role
        - products
        - productRole
        - state
    RelationshipsResponse:
      type: array
      items:
        $ref: '#/components/schemas/RelationshipInfo'
    User:
      properties:
        name:
          type: string
        surname:
          type: string
        taxCode:
          type: string
        role:
          $ref: '#/components/schemas/PartyRole'
        email:
          type: string
        products:
          type: array
          description: set of products bound to this user
          uniqueItems: true
          items:
            type: string
        productRole:
          type: string
      additionalProperties: false
      required:
        - name
        - surname
        - taxCode
        - role
        - products
        - productRole
    PersonInfo:
      properties:
        name:
          type: string
        surname:
          type: string
        taxCode:
          type: string
      additionalProperties: false
      required:
        - name
        - surname
        - taxCode
    OnboardingData:
      properties:
        institutionId:
          type: string
        description:
          type: string
        digitalAddress:
          type: string
        state:
          $ref: '#/components/schemas/RelationshipState'
        role:
          $ref: '#/components/schemas/PartyRole'
        relationshipProducts:
          type: array
          uniqueItems: true
          description: set of products bound to this relationship
          items:
            type: string
        productRole:
          type: string
        institutionProducts:
          type: array
          uniqueItems: true
          description: set of products bound to this institution
          items:
            type: string
        attributes:
          type: array
          description: certified attributes bound to this institution
          items:
            $ref: '#/components/schemas/Attribute'
      additionalProperties: false
      required:
        - institutionId
        - description
        - digitalAddress
        - state
        - role
        - relationshipProducts
        - productRole
        - attributes
        - institutionProducts
    Attribute:
      type: object
      properties:
        id:
          type: string
        name:
          type: string
        description:
          type: string
      required:
        - id
        - name
        - description
    OnBoardingInfo:
      properties:
        person:
          $ref: '#/components/schemas/PersonInfo'
        institutions:
          type: array
          items:
            $ref: '#/components/schemas/OnboardingData'
      additionalProperties: false
      required:
        - person
        - institutions
    Institution:
      type: object
      properties:
        id:
          type: string
          format: uuid
          example: 97c0f418-bcb3-48d4-825a-fe8b29ae68e5
        institutionId:
          description: organization id (e.g iPA code)
          example: 'c_f205'
          type: string
        description:
          type: string
          example: AGENCY X
        digitalAddress:
          example: email@pec.mail.org
          format: email
          type: string
        taxCode:
          description: organization tax code
          type: string
        attributes:
          type: array
          items:
            type: string
        products:
          type: array
          uniqueItems: true
          items:
            type: string
            description: product names associated to this organization
      required:
        - id
        - institutionId
        - description
        - digitalAddress
        - taxCode
        - attributes
        - products
      additionalProperties: false
    Products:
      type: object
      required:
        - products
      properties:
        products:
          type: array
          uniqueItems: true
          items:
            type: string
          description: set of products to define for this institution
    ProductRolesResponse:
      title: ProductRolesResponse
      type: object
      description: This payload contains the currently defined bindings between roles and platform roles.
      properties:
        managerRoles:
          type: array
          description: binding between manager and its platform roles
          items:
            type: string
        delegateRoles:
          type: array
          description: binding between delegate and its platform roles
          items:
            type: string
        operatorRoles:
          type: array
          description: binding between operator and its platform roles
          items:
            type: string
      required:
        - managerRoles
        - delegateRoles
        - operatorRoles
    PartyRole:
      type: string
      description: Represents the generic available role types for the relationship
      enum:
        - MANAGER
        - DELEGATE
        - OPERATOR
    RelationshipState:
      type: string
      description: Represents the party relationship state
      enum:
        - PENDING
        - ACTIVE
        - SUSPENDED
        - DELETED
        - REJECTED
    Problem:
      properties:
        detail:
          description: A human readable explanation specific to this occurrence of the problem.
          example: Request took too long to complete.
          maxLength: 4096
          pattern: '^.{0,1024}$'
          type: string
        status:
          description: The HTTP status code generated by the origin server for this occurrence of the problem.
          example: 503
          exclusiveMaximum: true
          format: int32
          maximum: 600
          minimum: 100
          type: integer
        title:
          description: 'A short, summary of the problem type. Written in english and readable'
          example: Service Unavailable
          maxLength: 64
          pattern: '^[ -~]{0,64}$'
          type: string
      additionalProperties: false
      required:
        - status
        - title
  securitySchemes:
    bearerAuth:
      type: http
      description: 'A bearer token in the format of a JWS and comformed to the specifications included in [RFC8725](https://tools.ietf.org/html/RFC8725).'
      scheme: bearer
      bearerFormat: JWT