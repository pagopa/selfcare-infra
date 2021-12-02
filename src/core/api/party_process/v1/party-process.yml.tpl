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
  - name: health
    description: Verify service status
    externalDocs:
      description: Find out more
      url: 'http://swagger.io'
paths:
  '/onboarding/info':
    get:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: get on boarding info
      description: Return ok
      operationId: getOnboardingInfo
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
                $ref: '#/components/schemas/OnboardingInfo'
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
              $ref: '#/components/schemas/OnboardingRequest'
      responses:
        '201':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OnboardingResponse'
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
              $ref: '#/components/schemas/OnboardingRequest'
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OnboardingResponse'
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /onboarding/subdelegates:
    post:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: subdelegates onboarding
      description: creates subdelegates entries on already onboarded institution
      operationId: onboardingSubDelegatesOnOrganization
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OnboardingRequest'
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OnboardingResponse'
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
              $ref: '#/components/schemas/OnboardingRequest'
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
        - in: query
          name: roles
          description: comma separated sequence of role to filter the response with
          schema:
            type: array
            items:
              $ref: '#/components/schemas/PartyRole'
            default: [ ]
          explode: false
        - in: query
          name: states
          description: comma separated sequence of states to filter the response with
          schema:
            type: array
            items:
              $ref: '#/components/schemas/RelationshipState'
            default: [ ]
          explode: false
        - in: query
          name: products
          description: comma separated sequence of products to filter the response with
          schema:
            type: array
            items:
              type: string
            default: [ ]
          explode: false
        - in: query
          name: productRoles
          description: comma separated sequence of product roles to filter the response with
          schema:
            type: array
            items:
              type: string
            default: [ ]
          explode: false
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
  '/onboarding/complete/{token}':
    post:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: create an onboarding entry
      description: Return ok
      operationId: confirmOnboarding
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
        '409':
          description: Document validation failed
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
components:
  schemas:
    OnboardingRequest:
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
    OnboardingResponse:
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
        name:
          type: string
        surname:
          type: string
        email:
          type: string
        role:
          $ref: '#/components/schemas/PartyRole'
        product:
          $ref: '#/components/schemas/ProductInfo'
        state:
          $ref: '#/components/schemas/RelationshipState'
        createdAt:
          type: string
          format: date-time
        updatedAt:
          type: string
          format: date-time
      additionalProperties: false
      required:
        - id
        - from
        - name
        - surname
        - role
        - product
        - state
        - createdAt
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
        product:
          type: string
        productRole:
          type: string
      additionalProperties: false
      required:
        - name
        - surname
        - taxCode
        - role
        - product
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
    ProductInfo:
      type: object
      properties:
        id:
          type: string
        role:
          type: string
        createdAt:
          type: string
          format: date-time
      required:
        - id
        - role
        - createdAt
    OnboardingData:
      properties:
        institutionId:
          type: string
        description:
          type: string
        taxCode:
          type: string
        digitalAddress:
          type: string
        state:
          $ref: '#/components/schemas/RelationshipState'
        role:
          $ref: '#/components/schemas/PartyRole'
        productInfo:
          $ref: '#/components/schemas/ProductInfo'
        attributes:
          type: array
          description: certified attributes bound to this institution
          items:
            $ref: '#/components/schemas/Attribute'
      additionalProperties: false
      required:
        - institutionId
        - taxCode
        - description
        - digitalAddress
        - state
        - role
        - productInfo
        - attributes
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
    OnboardingInfo:
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
    Products:
      type: object
      properties:
        products:
          type: array
          items:
            $ref: '#/components/schemas/ProductInfo'
      required:
        - products
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
        - SUB_DELEGATE
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