openapi: 3.0.3
info:
  title: Party Management Micro Service
  description: This service is the party manager
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
    description: This service is the party manager
tags:
  - name: party
    description: Manipulate party information
    externalDocs:
      description: Find out more
      url: 'http://swagger.io'
  - name: external
    description: External id endpoints
    externalDocs:
      description: Find out more
      url: 'http://swagger.io'
security:
  - bearerAuth: [ ]
paths:
  /institutions/{id}:
    get:
      summary: Retrieves Institution by ID
      tags:
        - party
      operationId: getInstitutionById
      description: 'returns the identified institution, if any.'
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - schema:
            type: string
            format: uuid
          name: id
          in: path
          required: true
          description: Institution ID
      responses:
        '200':
          description: Institution
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Institution'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Institution not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /institutions/{id}/attributes:
    get:
      summary: Retrieves attributes
      tags:
        - party
      operationId: getPartyAttributes
      description: 'returns the attributes of the identified party, if any.'
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - schema:
            type: string
            format: uuid
            example: e72dd279-5f52-4039-afbe-2b7e432c490e
          name: id
          in: path
          required: true
          description: Institution ID
      responses:
        '200':
          description: Party Attributes
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Attributes'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Party not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /external/institutions/{externalId}:
    get:
      summary: Retrieves Institution by ID
      tags:
        - external
      operationId: getInstitutionByExternalId
      description: 'returns the identified institution, if any.'
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - schema:
            type: string
          name: externalId
          in: path
          required: true
          description: External Institution ID
      responses:
        '200':
          description: Institution
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Institution'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Institution not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /relationships:
    get:
      tags:
        - party
      summary: Return a list of relationships
      description: Return ok
      operationId: getRelationships
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - in: query
          name: from
          schema:
            type: string
            format: uuid
        - in: query
          name: to
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
                $ref: '#/components/schemas/Relationships'
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /relationships/{relationshipId}:
    get:
      tags:
        - party
      summary: Retrieve the relationship for the given relationshipId
      description: Return relationship
      operationId: getRelationshipById
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: relationshipId
          in: path
          description: The ID of the Relationship to retrieve
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
                $ref: '#/components/schemas/Relationship'
        '400':
          description: Bad Request
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
  '/bulk/institutions':
    post:
      summary: Retrieves a collection of institutions
      tags:
        - party
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
              $ref: '#/components/schemas/BulkPartiesSeed'
      responses:
        '200':
          description: collection of institutions
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/BulkInstitutions'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Institutions not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      operationId: bulkInstitutions
      description: 'returns a collection of all the parties for the corresponding identifiers.'
components:
  schemas:
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
        products:
            type: object
            additionalProperties:
              $ref: '#/components/schemas/InstitutionProduct'
            description: Institution products info
        attributes:
          $ref: '#/components/schemas/Attributes'
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
        - products
      additionalProperties: false
    BulkInstitutions:
      type: object
      required:
        - found
        - notFound
      properties:
        found:
          type: array
          description: the collection of institutions found.
          items:
            $ref: '#/components/schemas/Institution'
        notFound:
          type: array
          items:
            type: string
          description: the identifiers of institutions not found.
    BulkPartiesSeed:
      type: object
      required:
        - partyIdentifiers
      properties:
        partyIdentifiers:
          type: array
          items:
            type: string
            format: uuid
          description: the identifiers of party
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
    Attributes:
      type: array
      items:
        $ref: '#/components/schemas/Attribute'
    Attribute:
      type: object
      additionalProperties: false
      properties:
        origin:
          type: string
          description: 'origin of the certified attribute, e.g.: IPA'
        code:
          type: string
          description: 'original identifier as defined at origin side, e.g.: IPA attribute code'
        description:
          type: string
          description: 'human readable description of the attribute'
      required:
        - origin
        - code
        - description
    RelationshipProduct:
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
    Relationship:
      type: object
      properties:
        id:
          type: string
          format: uuid
        from:
          type: string
          format: uuid
          description: person ID
        to:
          type: string
          format: uuid
          description: institution ID
        filePath:
          type: string
          description: path of the file containing the signed onboarding document
        fileName:
          type: string
          description: name of the file containing the signed onboarding document
        contentType:
          type: string
          description: content type of the file containing the signed onboarding document
        tokenId:
          type: string
          format: uuid
          description: confirmation token identifier
        role:
          $ref: '#/components/schemas/PartyRole'
        product:
          $ref: '#/components/schemas/RelationshipProduct'
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
    Relationships:
      type: object
      properties:
        items:
          type: array
          items:
            $ref: '#/components/schemas/Relationship'
      additionalProperties: false
      required:
        - items
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
    InstitutionProduct:
      type: object
      properties:
        product:
          type: string
        pricingPlan:
          type: string
          description: pricing plan
        billing:
          $ref: '#/components/schemas/Billing'
      additionalProperties: false
      required:
        - product
        - billing
  securitySchemes:
    bearerAuth:
      type: http
      description: 'A bearer token in the format of a JWS and comformed to the specifications included in [RFC8725](https://tools.ietf.org/html/RFC8725).'
      scheme: bearer
      bearerFormat: JWT
