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
  - name: health
    description: Verify service status
    externalDocs:
      description: Find out more
      url: 'http://swagger.io'
paths:
  '/persons/{id}':
    get:
      summary: Retrieves Person by ID
      tags:
        - party
      operationId: getPersonById
      description: 'returns the identified person, if any.'
      parameters:
        - name: id
          in: path
          schema:
            type: string
            format: uuid
          required: true
          description: Person ID
      responses:
        '200':
          description: Person
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Person'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Person not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
    head:
      tags:
        - party
      summary: Verify if a Person exists for a given ID
      description: Return ok
      operationId: existsPersonById
      parameters:
        - name: id
          in: path
          description: The ID of the Person to check
          required: true
          schema:
            description: The Person ID.
            type: string
            format: uuid
            example: e72dd279-5f52-4039-afbe-2b7e432c490e
      responses:
        '200':
          description: Person exists
        '404':
          description: Person not found
  /persons:
    post:
      #      security:
      #        - bearerAuth: [ ]
      tags:
        - party
      summary: Create a new person
      description: Return ok
      operationId: createPerson
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/PersonSeed'
      responses:
        '201':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Person'
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /organizations:
    post:
      #      security:
      #        - bearerAuth: [ ]
      tags:
        - party
      summary: Create an organization
      description: Return ok
      operationId: createOrganization
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OrganizationSeed'
      responses:
        '201':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Organization'
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /organizations/{id}:
    get:
      summary: Retrieves Organization by ID
      tags:
        - party
      operationId: getOrganizationById
      description: 'returns the identified organization, if any.'
      parameters:
        - schema:
            type: string
            format: uuid
          name: id
          in: path
          required: true
          description: Organization ID
      responses:
        '200':
          description: Organization
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Organization'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Organization not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
    head:
      #      security:
      #        - bearerAuth: [ ]
      tags:
        - party
      summary: Verify if an organization exists for a given organizationId
      description: Return ok
      operationId: existsOrganizationById
      parameters:
        - name: id
          in: path
          description: The ID of the Organization to check
          required: true
          schema:
            description: to be defined
            type: string
            format: uuid
            example: e72dd279-5f52-4039-afbe-2b7e432c490e
      responses:
        '200':
          description: successful operation
        '404':
          description: Organization not found
  /organizations/{id}/attributes:
    parameters:
      - schema:
          type: string
          format: uuid
          example: e72dd279-5f52-4039-afbe-2b7e432c490e
        name: id
        in: path
        required: true
        description: Organization ID
    get:
      summary: Retrieves attributes
      tags:
        - party
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
      operationId: getPartyAttributes
      description: 'returns the attributes of the identified party, if any.'
    patch:
      #      security:
      #        - bearerAuth: [ ]
      tags:
        - party
      summary: Retrieve the organization attributes for the given organizationId
      description: Return ok
      operationId: addOrganizationAttributes
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Attributes'
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Organization'
        '404':
          description: Organization not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /relationships:
    post:
      #      security:
      #        - bearerAuth: [ ]
      tags:
        - party
      summary: Create a new relationship between a Person and an Organization
      description: Return ok
      operationId: createRelationship
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/RelationshipSeed'
      responses:
        '201':
          description: Created Relationship
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Relationship'
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
    get:
      #      security:
      #        - bearerAuth: [ ]
      tags:
        - party
      summary: Return a list of relationships
      description: Return ok
      operationId: getRelationships
      parameters:
        - in: query
          name: from
          schema:
            type: string
        - in: query
          name: to
          schema:
            type: string
        - in: query
          name: platformRole
          schema:
            type: string
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
  '/relationships/{relationshipId}/suspend':
    parameters:
      - schema:
          type: string
          format: uuid
        name: relationshipId
        in: path
        required: true
        description: Relationship ID
    post:
      summary: Suspend Relationship by ID
      tags:
        - party
      responses:
        '204':
          description: Relationship suspended
        '404':
          description: Relationship not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      operationId: suspendPartyRelationshipById
      description: 'Suspend relationship by ID'
  '/relationships/{relationshipId}/activate':
    parameters:
      - schema:
          type: string
          format: uuid
        name: relationshipId
        in: path
        required: true
        description: Relationship ID
    post:
      summary: Activate Relationship by plaftorm ID
      tags:
        - party
      responses:
        '204':
          description: Relationship activated
        '404':
          description: Relationship not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      operationId: activatePartyRelationshipById
      description: 'Activate Relationship by ID'
  /tokens:
    post:
      #      security:
      #        - bearerAuth: [ ]
      tags:
        - party
      summary: Create a new token
      description: Return ok
      operationId: createToken
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/TokenSeed'
      responses:
        '201':
          description: successful operation
          content:
            application/octet-stream:
              schema:
                $ref: '#/components/schemas/TokenText'
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /tokens/{token}:
    head:
      #      security:
      #        - bearerAuth: [ ]
      tags:
        - party
      summary: Retrieve token info
      description: Return ok
      operationId: verifyToken
      parameters:
        - name: token
          in: path
          description: The token to verify
          required: true
          schema:
            description: to be defined
            type: string
      responses:
        '200':
          description: successful operation
        '404':
          description: Token not found
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
    post:
      #      security:
      #        - bearerAuth: [ ]
      tags:
        - party
      summary: Consume a token
      description: Return ok
      operationId: consumeToken
      parameters:
        - name: token
          in: path
          description: The token to consume
          required: true
          schema:
            description: to be defined
            type: string
      requestBody:
        description: onboarding signed document
        content:
          multipart/form-data:
            schema:
              type: object
              required:
                - doc
              properties:
                doc:
                  type: string
                  format: binary
        required: true
      responses:
        '201':
          description: successful operation
        '400':
          description: Invalid ID supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
    delete:
      #      security:
      #        - bearerAuth: [ ]
      tags:
        - party
      summary: Invalidate a token
      description: Return ok
      operationId: invalidateToken
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
  /status:
    get:
      #      security:
      #        - bearerAuth: [ ]
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
  '/bulk/organizations':
    post:
      summary: Retrieves a collection of organizations
      tags:
        - party
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/BulkPartiesSeed'
      responses:
        '200':
          description: collection of organizations
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/BulkOrganizations'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Organizations not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      operationId: bulkOrganizations
      description: 'returns a collection of all the parties for the corresponding identifiers.'
components:
  schemas:
    PersonSeed:
      type: object
      properties:
        id:
          description: Internal id.
          type: string
          format: uuid
      required:
        - id
      additionalProperties: false
    Person:
      type: object
      properties:
        id:
          type: string
          format: uuid
          example: 97c0f418-bcb3-48d4-825a-fe8b29ae68e5
      required:
        - id
      additionalProperties: false
    OrganizationSeed:
      type: object
      properties:
        institutionId:
          description: DN
          example: 'aoo=c_f205,o=c_f205,c=it'
          type: string
        description:
          type: string
          example: AGENCY X
        digitalAddress:
          example: email@pec.mail.org
          format: email
          type: string
        attributes:
          $ref: '#/components/schemas/Attributes'
      required:
        - institutionId
        - description
        - digitalAddress
        - attributes
      additionalProperties: false
    Organization:
      type: object
      properties:
        id:
          type: string
          format: uuid
          example: 97c0f418-bcb3-48d4-825a-fe8b29ae68e5
        institutionId:
          description: DN
          example: 'aoo=c_f205,o=c_f205,c=it'
          type: string
        description:
          type: string
          example: AGENCY X
        digitalAddress:
          example: email@pec.mail.org
          format: email
          type: string
        attributes:
          $ref: '#/components/schemas/Attributes'
      required:
        - id
        - institutionId
        - description
        - digitalAddress
        - attributes
      additionalProperties: false
    BulkOrganizations:
      type: object
      required:
        - found
        - notFound
      properties:
        found:
          type: array
          description: the collection of organizations found.
          items:
            $ref: '#/components/schemas/Organization'
        notFound:
          type: array
          items:
            type: string
          description: the identifiers of organizations not found.
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
    Attributes:
      type: array
      items:
        type: string
    RelationshipSeed:
      type: object
      properties:
        from:
          type: string
          format: uuid
          description: person ID
        to:
          type: string
          format: uuid
          description: organization ID
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
      additionalProperties: false
      required:
        - from
        - to
        - role
        - platformRole
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
          description: organization ID
        filePath:
          type: string
          description: path of the file containing the signed onboarding document
        fileName:
          type: string
          description: name of the file containing the signed onboarding document
        contentType:
          type: string
          description: content type of the file containing the signed onboarding document
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
            - Pending
            - Active
            - Suspended
      additionalProperties: false
      required:
        - id
        - from
        - to
        - role
        - platformRole
        - status
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
    RelationshipsSeed:
      type: object
      properties:
        items:
          type: array
          items:
            $ref: '#/components/schemas/RelationshipSeed'
      additionalProperties: false
      required:
        - items
    TokenSeed:
      type: object
      properties:
        seed:
          type: string
          example: 97c0f418-bcb3-48d4-825a-fe8b29ae68e5
        relationships:
          $ref: '#/components/schemas/RelationshipsSeed'
        checksum:
          type: string
      additionalProperties: false
      required:
        - seed
        - relationships
        - checksum
    TokenText:
      properties:
        token:
          type: string
      additionalProperties: false
      required:
        - token
    Problem:
      properties:
        detail:
          description: A human readable explanation specific to this occurrence of the problem.
          example: Request took too long to complete.
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
          description:
            A short, summary of the problem type. Written in english and readable
          example: Service Unavailable
          type: string
      additionalProperties: false
      required:
        - status
        - title
#  securitySchemes:
#    bearerAuth:
#      type: http
#      description: A bearer token in the format of a JWS and comformed to the specifications included in [RFC8725](https://tools.ietf.org/html/RFC8725).
#      scheme: bearer
#      bearerFormat: JWTly in the editor.
