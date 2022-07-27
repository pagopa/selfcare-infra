openapi: 3.0.3
info:
  title: selc-external-api
  description: This service acts as an orchestrator for information coming from different services
    and as a proxy
  version: 0.0.1-SNAPSHOT
servers:
  - url: 'https://${host}/${basePath}'
tags:
  - name: institutions
    description: Institution Controller
paths:
  '/institutions':
    get:
      tags:
        - institutions
      summary: getInstitutions
      description: >-
        The service retrieves all the onboarded institutions related to the
        logged user
      operationId: getInstitutionsUsingGET
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/InstitutionResource'
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
    InstitutionResource:
      title: InstitutionResource
      required:
        - address
        - description
        - digitalAddress
        - externalId
        - id
        - institutionType
        - origin
        - originId
        - status
        - taxCode
        - userRole
        - zipCode
      type: object
      properties:
        address:
          type: string
          description: Institution's physical address
        description:
          type: string
          description: Institution's legal name
        digitalAddress:
          type: string
          description: Institution's digitalAddress
        externalId:
          type: string
          description: Institution's unique external identifier
        id:
          type: string
          description: Institution's unique internal Id
          format: uuid
        institutionType:
          type: string
          description: Institution's type
          enum:
            - GSP
            - PA
            - PT
            - SCP
        origin:
          type: string
          description: Institution data origin
        originId:
          type: string
          description: Institution's details origin Id
        status:
          type: string
          description: Institution onboarding status
        taxCode:
          type: string
          description: Institution's taxCode
        userRole:
          type: string
          description: Logged user's role
          enum:
            - ADMIN
            - LIMITED
        zipCode:
          type: string
          description: Institution's zipCode
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
      description: >-
        A "problem detail" as a way to carry machine-readable details of errors
        (https://datatracker.ietf.org/doc/html/rfc7807)
  securitySchemes:
    bearerAuth:
      type: http
      description: >-
        A bearer token in the format of a JWS and conformed to the
        specifications included in
        [RFC8725](https://tools.ietf.org/html/RFC8725)
      scheme: bearer
      bearerFormat: JWT
