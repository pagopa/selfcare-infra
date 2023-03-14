openapi: 3.0.3
info:
  title: selc-external-api-pnpg
  description: Self Care External Api Documentation
  version: 0.0.1-SNAPSHOT
servers:
  - url: 'https://${host}/${basePath}'
tags:
  - name: pnpg
    description: PNPG Controller
paths:
 '/institutions/add':
     post:
       tags:
         - pnpg
       summary: addInstitution
       description: Checks if there is an institution with given externalId and returns its internalId if doesn't exists it creates it
       operationId: addInstitutionUsingPOST
       parameters:
           - name: x-selfcare-uid
             in: header
             description: Logged user's unique identifier
             required: true
             schema:
               type: string
       requestBody:
         content:
           application/json:
             schema:
               $ref: '#/components/schemas/SearchInstitutionDto'
       responses:
         '201':
           description: Created
           content:
             application/json:
               schema:
                 type: string
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
    SearchInstitutionDto:
          title: SearchInstitutionDto
          required:
            - externalId
          type: object
          properties:
            externalId:
              type: string
              description: Institution's unique external identifier
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
  securitySchemes:
    bearerAuth:
      type: http
      description: A bearer token in the format of a JWS and conformed to the specifications included in [RFC8725](https://tools.ietf.org/html/RFC8725)
      scheme: bearer
      bearerFormat: JWT
