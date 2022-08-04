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
  - name: external
    description: Implements external endpoints
    externalDocs:
      description: Find out more
      url: 'http://swagger.io'
  - name: public
    description: Public endpoints
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
      tags:
        - process
      summary: get on boarding info
      description: Return ok
      operationId: getOnboardingInfo
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: institutionId
          description: The internal identifier of the institution
          in: query
          schema:
            type: string
            format: uuid
        - name: institutionExternalId
          description: The external Id of an institution you can filter the retrieval with
          in: query
          schema:
            type: string
        - name: states
          in: query
          description: comma separated sequence of states to filter the response with
          schema:
            type: array
            items:
              $ref: '#/components/schemas/RelationshipState'
            default: [ ]
          explode: false
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OnboardingInfo'
        '404':
          description: Not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /onboarding/institution:
    post:
      tags:
        - process
      summary: Institution onboarding on the platform
      description: it performs the onboarding of a new institution on the platform
      operationId: onboardingInstitution
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OnboardingInstitutionRequest'
      responses:
        '204':
          description: successful operation
        '404':
          description: Not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  '/onboarding/institution/{externalId}/products/{productId}':
    head:
      tags:
        - process
      summary: verify onboarding info
      description: Checks if the specified institution has been onboarded on the specified product.
      operationId: verifyOnboarding
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: externalId
          in: path
          description: The external identifier of the institution
          required: true
          schema:
            type: string
        - name: productId
          in: path
          description: The identifier of the product
          required: true
          schema:
            type: string
      responses:
        '204':
          description: successful operation
        '400':
          description: Invalid ID supplied
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
  /onboarding/legals:
    post:
      tags:
        - process
      summary: legals onboarding
      description: creates legals entries on already onboarded institution
      operationId: onboardingLegalsOnInstitution
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OnboardingLegalUsersRequest'
      responses:
        '204':
          description: successful operation
        '404':
          description: Not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /onboarding/subdelegates:
    post:
      tags:
        - process
      summary: subdelegates onboarding
      description: creates subdelegates entries on already onboarded institution
      operationId: onboardingSubDelegatesOnInstitution
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OnboardingUsersRequest'
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/RelationshipsResponse'
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /onboarding/operators:
    post:
      tags:
        - process
      summary: operators onboarding
      description: performs operators onboarding on an already existing institution
      operationId: onboardingOperators
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OnboardingUsersRequest'
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/RelationshipsResponse'
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /institutions/{id}/relationships:
    get:
      tags:
        - process
      summary: returns the relationships related to the institution
      description: Return ok
      operationId: getUserInstitutionRelationships
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: id
          in: path
          description: The internal identifier of the institution
          required: true
          schema:
            type: string
            format: uuid
        - in: query
          name: personId
          description: the person identifier
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
  /external/institutions/{externalId}/relationships:
    get:
      tags:
        - external
      summary: returns the relationships related to the institution
      description: Return ok
      operationId: getUserInstitutionRelationshipsByExternalId
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: externalId
          in: path
          description: The external identifier of the institution
          required: true
          schema:
            type: string
        - in: query
          name: personId
          description: the person identifier
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
  /external/institutions/{externalId}/products/{productId}/manager:
    get:
      tags:
        - external
      summary: returns the manager related to the institution even if the current user is not related to the institution/product
      description: Return ok
      operationId: getManagerInstitutionByExternalId
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: externalId
          in: path
          description: The external identifier of the institution
          required: true
          schema:
            type: string
        - name: productId
          in: path
          description: The id of the product
          required: true
          schema:
            type: string
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/RelationshipInfo'
        '404':
          description: There is not a relationship between an ACTIVE manager and the institution/product
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '400':
          description: Invalid institution id supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /institutions/{id}/products:
    get:
      tags:
        - process
      summary: institution products retrieval
      description: retrieves the products this institution is related to.
      operationId: retrieveInstitutionProducts
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: id
          in: path
          description: The internal identifier of the institution
          required: true
          schema:
            type: string
            format: uuid
        - name: states
          in: query
          description: comma separated sequence of states to filter the response with
          schema:
            type: array
            items:
              $ref: '#/components/schemas/ProductState'
            default: [ ]
          explode: false
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
  /external/institutions/{externalId}/products:
    get:
      tags:
        - external
      summary: institution products retrieval
      description: retrieves the products this institution is related to.
      operationId: retrieveInstitutionProductsByExternalId
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: externalId
          in: path
          description: The external identifier of the institution
          required: true
          schema:
            type: string
        - name: states
          in: query
          description: comma separated sequence of states to filter the response with
          schema:
            type: array
            items:
              $ref: '#/components/schemas/ProductState'
            default: [ ]
          explode: false
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
      tags:
        - process
      summary: Gets the corresponding relationship
      description: Gets relationship
      operationId: getRelationship
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
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
      tags:
        - process
      summary: Relationship deletion
      description: Given a relationship identifier, it deletes the corresponding relationship.
      operationId: deleteRelationshipById
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
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
      tags:
        - process
      summary: Activate the relationship
      description: Activate relationship
      operationId: activateRelationship
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
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
      tags:
        - process
      summary: Suspend the relationship
      description: Suspend relationship
      operationId: suspendRelationship
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
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
  '/institutions/{id}':
    get:
      security: [ { } ]
      tags:
        - process
      summary: Gets the corresponding institution using internal institution id
      description: Gets institution using internal institution id
      operationId: getInstitution
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: id
          in: path
          description: The internal identifier of the institution
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
                $ref: '#/components/schemas/Institution'
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
  '/institutions/{externalId}':
    post:
      tags:
        - process
      summary: Create an institution using external institution id fetching data from user-registry
      description: Create an institution using external institution id fetching data from user-registry
      operationId: createInstitution
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: externalId
          in: path
          description: The externalId of the institution
          required: true
          schema:
            type: string
      responses:
        '201':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Institution'
        '404':
          description: Invalid externalId supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '409':
          description: institution having externalId already exists
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  '/external/institutions/{externalId}':
    get:
      security: [{}]
      tags:
        - external
      summary: Gets the corresponding institution using external institution id
      description: Gets institution using external institution id
      operationId: getInstitutionByExternalId
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: externalId
          in: path
          description: The external identifier of the institution
          required: true
          schema:
            type: string
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Institution'
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
  '/onboarding/complete/{tokenId}':
    post:
      security: [{}]
      tags:
        - public
      summary: create an onboarding entry
      description: Return ok
      operationId: confirmOnboarding
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: tokenId
          in: path
          description: the token id containing the onboardind information
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
        '204':
          description: successful operation
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '409':
          description: |
            Document validation failed

            These are the error code used in the document validation process:

            * 002-100: document validation fails

            * 002-101: original document digest differs from incoming document digest

            * 002-102: signature is invalid

            * 002-103: signature form is not CAdES

            * 002-104: signature tax code is not equal to tax code in document

            * 002-105: signature tax code has an invalid format

            * 002-106: missing signature tax code

          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
    delete:
      security: [{}]
      tags:
        - public
      summary: invalidate an onboarding request
      description: Return ok
      operationId: invalidateOnboarding
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: tokenId
          in: path
          description: The token id to invalidate
          required: true
          schema:
            type: string
      responses:
        '204':
          description: successful operation
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /onboarding/relationship/{relationshipId}/document:
    get:
      tags:
        - process
      summary: Get an onboarding document
      operationId: getOnboardingDocument
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
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
  /status:
    get:
      security:
        - bearerAuth: [ ]
      tags:
        - health
      summary: Health status endpoint
      description: Return ok
      operationId: getStatus
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
      responses:
        '200':
          description: successful operation
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
components:
  schemas:
    OnboardingInstitutionRequest:
      properties:
        users:
          type: array
          items:
            $ref: '#/components/schemas/User'
        institutionExternalId:
          type: string
        institutionUpdate:
          $ref: '#/components/schemas/InstitutionUpdate'
        pricingPlan:
          type: string
          description: pricing plan
        billing:
          $ref: '#/components/schemas/Billing'
        contract:
          $ref: '#/components/schemas/OnboardingContract'
      additionalProperties: false
      required:
        - users
        - institutionExternalId
        - billing
        - contract
    OnboardingLegalUsersRequest:
      properties:
        users:
          type: array
          items:
            $ref: '#/components/schemas/User'
        institutionId:
          type: string
          description: institution id
          format: uuid
          example: 97c0f418-bcb3-48d4-825a-fe8b29ae68e5
        institutionExternalId:
          type: string
        contract:
          $ref: '#/components/schemas/OnboardingContract'
      additionalProperties: false
      required:
        - users
        - contract
    OnboardingUsersRequest:
      properties:
        users:
          type: array
          items:
            $ref: '#/components/schemas/User'
        institutionId:
          type: string
          description: institution id
          format: uuid
          example: 97c0f418-bcb3-48d4-825a-fe8b29ae68e5
      additionalProperties: false
      required:
        - users
        - institutionId
    OnboardingContract:
      properties:
        version:
          type: string
        path:
          type: string
      additionalProperties: false
      required:
        - version
        - path
    RelationshipInfo:
      type: object
      properties:
        id:
          type: string
          format: uuid
        from:
          type: string
          format: uuid
        to:
          type: string
          format: uuid
        role:
          $ref: '#/components/schemas/PartyRole'
        product:
          $ref: '#/components/schemas/ProductInfo'
        state:
          $ref: '#/components/schemas/RelationshipState'
        pricingPlan:
          type: string
          description: pricing plan
        institutionUpdate:
          $ref: '#/components/schemas/InstitutionUpdate'
        billing:
          $ref: '#/components/schemas/Billing'
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
        - to
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
        id:
          type: string
          description: User internal id
          format: uuid
        taxCode:
          type: string
        name:
          type: string
        surname:
          type: string
        email:
          type: string
        role:
          $ref: '#/components/schemas/PartyRole'
        product:
          type: string
        productRole:
          type: string
      additionalProperties: false
      required:
        - id
        - taxCode
        - name
        - surname
        - role
        - product
        - productRole
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
        id:
          type: string
          format: uuid
        externalId:
          type: string
        originId:
          type: string
        description:
          type: string
        taxCode:
          type: string
        digitalAddress:
          type: string
        address:
          type: string
        zipCode:
          type: string
        state:
          $ref: '#/components/schemas/RelationshipState'
        role:
          $ref: '#/components/schemas/PartyRole'
        productInfo:
          $ref: '#/components/schemas/ProductInfo'
        institutionType:
          type: string
          description: institution type
          example: PA
        pricingPlan:
          type: string
          description: pricing plan
        billing:
          $ref: '#/components/schemas/Billing'
        origin:
          type: string
          description: The origin form which the institution has been retrieved
          example: IPA
        attributes:
          type: array
          description: certified attributes bound to this institution
          items:
            $ref: '#/components/schemas/Attribute'
      additionalProperties: false
      required:
        - id
        - externalId
        - originId
        - origin
        - taxCode
        - description
        - digitalAddress
        - address
        - zipCode
        - state
        - role
        - productInfo
        - attributes
    Attribute:
      type: object
      properties:
        origin:
          type: string
        code:
          type: string
        description:
          type: string
      required:
        - origin
        - code
        - description
    Attributes:
      type: array
      items:
        $ref: '#/components/schemas/Attribute'
    OnboardingInfo:
      properties:
        userId:
          type: string
          description: User internal id
          format: uuid
        institutions:
          type: array
          items:
            $ref: '#/components/schemas/OnboardingData'
      additionalProperties: false
      required:
        - person
        - institutions
    Product:
      type: object
      properties:
        id:
          type: string
        state:
          $ref: '#/components/schemas/ProductState'
      required:
        - id
        - state
    Products:
      type: object
      properties:
        products:
          type: array
          items:
            $ref: '#/components/schemas/Product'
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
    ProductState:
      type: string
      description: Represents the product state
      enum:
        - PENDING
        - ACTIVE
    Institution:
      type: object
      properties:
        id:
          type: string
          format: uuid
          example: 97c0f418-bcb3-48d4-825a-fe8b29ae68e5
        externalId:
          description: external institution id
          example: 'c_f205'
          type: string
        originId:
          description: origin institution id (e.g iPA code)
          example: 'c_f205'
          type: string
        description:
          type: string
          example: AGENCY X
        digitalAddress:
          example: email@pec.mail.org
          format: email
          type: string
        address:
          example: via del campo
          type: string
        zipCode:
          example: 20100
          type: string
        taxCode:
          description: institution tax code
          type: string
        origin:
          type: string
          description: The origin form which the institution has been retrieved
          example: IPA
        institutionType:
          type: string
          description: institution type
          example: PA
        attributes:
          $ref: '#/components/schemas/Attributes'
        logo:
          description: URL to institution logo
          format: url
          type: string
      required:
        - id
        - externalId
        - originId
        - description
        - digitalAddress
        - address
        - zipCode
        - taxCode
        - attributes
        - origin
      additionalProperties: false
    Problem:
      properties:
        type:
          description: URI reference of type definition
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
          description: A short, summary of the problem type. Written in english and readable
          example: Service Unavailable
          maxLength: 64
          pattern: '^[ -~]{0,64}$'
          type: string
        detail:
          description: A human readable explanation of the problem.
          example: Request took too long to complete.
          maxLength: 4096
          pattern: '^.{0,1024}$'
          type: string
        errors:
          type: array
          minItems: 1
          items:
            $ref: '#/components/schemas/ProblemError'
      additionalProperties: false
      required:
        - type
        - status
        - title
        - errors
    ProblemError:
      properties:
        code:
          description: Internal code of the error
          example: 123-4567
          minLength: 8
          maxLength: 8
          pattern: '^[0-9]{3}-[0-9]{4}$'
          type: string
        detail:
          description: A human readable explanation specific to this occurrence of the problem.
          example: Parameter not valid
          maxLength: 4096
          pattern: '^.{0,1024}$'
          type: string
      required:
        - code
        - detail
    InstitutionUpdate:
      type: object
      properties:
        institutionType:
          type: string
          example: PA
          description: The type of the institution
        description:
          type: string
          example: AGENCY X
        digitalAddress:
          example: email@pec.mail.org
          format: email
          type: string
        address:
          example: via del campo
          type: string
        zipCode:
          example: 20100
          type: string
        taxCode:
          description: institution tax code
          type: string
    Billing:
      type: object
      properties:
        vatNumber:
          description: institution vat number
          type: string
        recipientCode:
          description: institution recipient code
          type: string
        publicServices:
          description: institution recipient code
          type: boolean
      required:
        - vatNumber
        - recipientCode
      additionalProperties: false
  securitySchemes:
    bearerAuth:
      type: http
      description: 'A bearer token in the format of a JWS and conformed to the specifications included in [RFC8725](https://tools.ietf.org/html/RFC8725).'
      scheme: bearer
      bearerFormat: JWT
