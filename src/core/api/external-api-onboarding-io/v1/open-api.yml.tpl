openapi: 3.0.3
info:
  title: selc-external-api
  description: Self Care External Api Documentation
  version: 0.0.1-SNAPSHOT
servers:
  - url: '{url}:{port}{basePath}'
    variables:
      url:
        default: http://localhost
      port:
        default: '80'
      basePath:
        default: ''
tags:
  - name: onboarding
    description: Onboarding operations
paths:
  /onboarding/{externalInstitutionId}:
    post:
      tags:
        - onboarding
      summary: contractOnboarding
      description: The service allows the import of old institutions' contracts
      operationId: contractOnboardingUsingPOST
      parameters:
        - name: externalInstitutionId
          in: path
          description: Institution's unique external identifier
          required: true
          style: simple
          schema:
            type: string
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OnboardingImportDto'
      responses:
        '201':
          description: Created
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
        '403':
          description: Forbidden
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '409':
          description: Conflict
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
    ImportContractDto:
      title: ImportContractDto
      required:
        - contractType
        - fileName
        - filePath
      type: object
      properties:
        contractType:
          type: string
          description: Institution's old contract version
        fileName:
          type: string
          description: Institution's old contract file name
        filePath:
          type: string
          description: Institution's old contract file path
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
    OnboardingImportDto:
      title: OnboardingImportDto
      required:
        - importContract
        - users
      type: object
      properties:
        importContract:
          description: Institution's old contract information
          $ref: '#/components/schemas/ImportContractDto'
        users:
          type: array
          description: List of onboarding users
          items:
            $ref: '#/components/schemas/UserDto'
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
    UserDto:
      title: UserDto
      required:
        - email
        - name
        - role
        - surname
        - taxCode
      type: object
      properties:
        email:
          type: string
          description: User's email
          format: email
          example: email@example.com
        name:
          type: string
          description: User's name
        role:
          type: string
          description: User's role
          enum:
            - DELEGATE
            - MANAGER
            - OPERATOR
            - SUB_DELEGATE
        surname:
          type: string
          description: User's surname
        taxCode:
          type: string
          description: User's fiscal code
  securitySchemes:
    bearerAuth:
      type: http
      description: A bearer token in the format of a JWS and conformed to the specifications included in [RFC8725](https://tools.ietf.org/html/RFC8725)
      scheme: bearer
      bearerFormat: JWT
