openapi: 3.0.3
info:
  title: Party Process Micro Service
  description: This service is the party process
  contact:
    name: API Support
    url: 'http://www.example.com/support'
    email: support@example.com
  termsOfService: 'http://swagger.io/terms/'
  x-api-id: an x-api-id
  x-summary: an x-summary
servers:
  - url: 'https://${host}/pdnd-interop-uservice-party-process/v1'
    description: This service is the party process
security:
  - bearerAuth: []
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
  '/onboarding/info/{taxCode}':
    get:
      security:
        - bearerAuth: []
      tags:
        - process
      summary: get on boarding info
      description: Return ok
      operationId: getOnBoardingInfo
      parameters:
        - name: taxCode
          in: path
          description: The tax code to get onboarding info
          required: true
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
  /onboarding/legals:
    post:
      security:
        - bearerAuth: []
      tags:
        - process
      summary: create an onboarding entry
      description: Return ok
      operationId: createLegals
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
  /onboarding/operators:
    post:
      security:
        - bearerAuth: []
      tags:
        - process
      summary: create an onboarding entry
      description: Return ok
      operationId: createOperators
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
      operationId: getInstitutionRelationships
      parameters:
        - name: institutionId
          in: path
          description: The identifier of the institution
          required: true
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
  /institutions/{institutionId}/relationships/{taxCode}:
    get:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: returns the relationship related to the institution and tax code
      description: Return ok
      operationId: getInstitutionTaxCodeRelationship
      parameters:
        - name: institutionId
          in: path
          description: The identifier of the institution
          required: true
          schema:
            type: string
        - name: taxCode
          in: path
          description: The identifier of the operator
          required: true
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
  /institutions/{institutionId}/relationships/{taxCode}/activate:
    post:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: Activate the relationship related to the institution and tax code
      description: Activate relationship
      operationId: activateRelationshipByInstitutionTaxCode
      parameters:
        - name: institutionId
          in: path
          description: The identifier of the institution
          required: true
          schema:
            type: string
        - name: taxCode
          in: path
          description: The identifier of the operator
          required: true
          schema:
            type: string
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/ActivationRequest'
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
  /institutions/{institutionId}/relationships/{taxCode}/suspend:
    post:
      security:
        - bearerAuth: [ ]
      tags:
        - process
      summary: Suspend the relationship related to the institution and tax code
      description: Suspend relationship
      operationId: suspendRelationshipByInstitutionTaxCode
      parameters:
        - name: institutionId
          in: path
          description: The identifier of the institution
          required: true
          schema:
            type: string
        - name: taxCode
          in: path
          description: The identifier of the operator
          required: true
          schema:
            type: string
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/ActivationRequest'
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
        - bearerAuth: []
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
        - bearerAuth: []
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
        - bearerAuth: []
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
                $ref: '#/components/schemas/PlatformRolesResponse'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      operationId: getPlatformRoles
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
    TokenRequest:
      properties:
        legals:
          type: array
          items:
            $ref: '#/components/schemas/User'
        institutionId:
          type: string
      additionalProperties: false
      required:
        - legals
        - institutionId
    RelationshipInfo:
      type: object
      properties:
        from:
          type: string
          description: tax code
        role:
          type: string
          description: represents the generic available role types for the relationship
          enum:
            - Manager
            - Delegate
            - Operator
        platformRole:
          type: string
          description: 'user role in the application context (e.g.: administrator, security user). This MUST belong to the configured set of application specific platform roles'
        status:
          type: string
          enum:
            - pending
            - active
            - inactive
      additionalProperties: false
      required:
        - from
        - role
        - platformRole
        - status
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
          type: string
          enum:
            - Manager
            - Delegate
            - Operator
        platformRole:
          type: string
      additionalProperties: false
      required:
        - name
        - surname
        - taxCode
        - role
        - platformRole
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
    InstitutionInfo:
      properties:
        institutionId:
          type: string
        description:
          type: string
        digitalAddress:
          type: string
        status:
          type: string
        role:
          type: string
        platformRole:
          type: string
        attributes:
          type: array
          description: certified attributes bound to this institution
          items:
            type: string
      additionalProperties: false
      required:
        - institutionId
        - description
        - digitalAddress
        - status
        - role
        - platformRole
        - attributes
    OnBoardingInfo:
      properties:
        person:
          $ref: '#/components/schemas/PersonInfo'
        institutions:
          type: array
          items:
            $ref: '#/components/schemas/InstitutionInfo'
      additionalProperties: false
      required:
        - person
        - institutions
    ActivationRequest:
      properties:
        platformRole:
          type: string
      required:
        - platformRole
    PlatformRolesResponse:
      title: PlatformRolesResponse
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
