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
paths:
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
components:
  schemas:
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
