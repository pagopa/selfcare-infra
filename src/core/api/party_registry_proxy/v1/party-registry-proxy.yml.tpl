openapi: 3.0.3
info:
  title: Party Registry Proxy Server
  description: This service is the proxy to the party registry
  version: 'v1'
  contact:
    name: API Support
    url: http://www.example.com/support
    email: support@example.com
  termsOfService: http://localhost/terms
  x-api-id: an x-api-id
  x-summary: an x-summary
servers:
  - url: 'https://${host}/${basePath}'
    description: This service is the proxy to the party registry
tags:
  - name: institution
    description: Retrieve information about institution
    externalDocs:
      description: Find out more
      url: http://swagger.io
  - name: health
    description: Verify service status
    externalDocs:
      description: Find out more
      url: http://swagger.io

paths:
  /institutions/{institutionId}:
    get:
      tags:
        - institution
      summary: Find institution by ID
      description: Returns a single institution
      operationId: getInstitutionById
      parameters:
        - name: institutionId
          in: path
          description: ID of institution to return
          required: true
          schema:
            type: string
            maxLength: 32
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Institution'
        '400':
          description: Invalid ID supplied
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
  /institutions:
    get:
      tags:
        - institution
      summary: Find institution by ID
      description: Returns a single institution
      operationId: searchInstitution
      parameters:
        - in: query
          name: search
          required: true
          schema:
            type: string
        - in: query
          name: page
          required: true
          schema:
            type: integer
            format: int32
        - in: query
          name: limit
          required: true
          schema:
            type: integer
            format: int32
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Institutions'
        '400':
          description: Invalid ID supplied
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
  /categories:
    get:
      tags:
        - institution
      summary: Get all ipa categories
      description: Returns the ipa categories list
      operationId: getCategories
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Categories'
        '404':
          description: Categories not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  /status:
    get:
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
    Institution:
      type: object
      additionalProperties: false
      properties:
        id:
          type: string
          description: iPA code
          example: age
          pattern: '^[a-z]{1,12}$'
          maxLength: 12
        o:
          type: string
          description: o
          example: age
          pattern: '^[a-z]{1,12}$'
          maxLength: 12
        ou:
          type: string
          description: ou
          example: age
          pattern: '^[a-z]{1,12}$'
          maxLength: 12
        aoo:
          type: string
          description: aoo
          example: age
          pattern: '^[a-z]{1,12}$'
          maxLength: 12
        taxCode:
          type: string
          description: institution fiscal code
          example: '00000000000'
          pattern: '[\d]{10,13}'
          maxLength: 13
        category:
          type: string
          description: institution category
          example: 'c7'
          pattern: '[a-zA-Z\d]{1,12}'
          maxLength: 13
        manager:
          $ref: '#/components/schemas/Manager'
        description:
          type: string
          description: institution description
          example: AGENCY X
          format: '^[A-Za-z èàòùìÈÀÒÙÌ]{2,30}$'
          maxLength: 30
        digitalAddress:
          type: string
          description: digital institution address
          example: mail@pec.mail.org
          format: mail
          maxLength: 20
      required:
        - id
        - category
        - taxCode
        - digitalAddress
        - description
        - manager
    Institutions:
      properties:
        items:
          type: array
          items:
            $ref: '#/components/schemas/Institution'
        count:
          type: integer
          format: int64
      required:
        - items
        - count
    Category:
      type: object
      additionalProperties: false
      properties:
        code:
          type: string
        name:
          type: string
        kind:
          type: string
      required:
        - code
        - kind
        - name
    Categories:
      properties:
        items:
          type: array
          items:
            $ref: '#/components/schemas/Category'
      required:
        - items
    Manager:
      type: object
      additionalProperties: false
      properties:
        givenName:
          type: string
          description: manager name
          example: Mario
          format: '^[A-Za-z èàòùìÈÀÒÙÌ]{2,30}$'
          maxLength: 30
        familyName:
          type: string
          description: manager surname
          example: Rossi
          format: '^[A-Za-z èàòùìÈÀÒÙÌ]{2,30}$'
          maxLength: 30
      required:
        - givenName
        - familyName
    Problem:
      properties:
        detail:
          description:
            A human readable explanation specific to this occurrence of the problem.
          example: Request took too long to complete.
          maxLength: 4096
          pattern: '^.{0,1024}$'
          type: string
        status:
          description:
            The HTTP status code generated by the origin server for this occurrence
            of the problem.
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
          maxLength: 64
          pattern: '^[ -~]{0,64}$'
          type: string
      additionalProperties: false
      required:
        - status
        - title
