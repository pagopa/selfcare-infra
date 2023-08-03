openapi: 3.0.3
info:
  title: selc-external-api
  description: This service acts as an orchestrator for information coming from different services and as a proxy
  version: 0.0.1-SNAPSHOT
servers:
  - url: 'https://${host}/${basePath}'
tags:
  - name: institutions
    description: Institution Controller
paths:
  '/':
    post:
      tags:
        - support
      summary: sendSupportRequest
      description: Service to retrieve Support contact's form
      operationId: sendSupportRequestUsingPOST
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/SupportRequestDto'
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/SupportResponse'
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
  '/institutions/{institutionId}/contract':
    get:
      tags:
        - institutions
      summary: getContract
      description: Service to retrieve a contract given institutionId and productId
      operationId: getContractUsingGET
      parameters:
        - name: institutionId
          in: path
          description: Institution's unique internal Id
          required: true
          style: simple
          schema:
            type: string
        - name: productId
          in: query
          description: Product's unique identifier
          required: true
          style: form
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/octet-stream:
              schema:
                type: string
                format: byte
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
    SupportRequestDto:
      title: SupportRequestDto
      required:
        - email
      type: object
      properties:
        email:
          type: string
          description: User's email
          format: email
          example: email@example.com
        productId:
          type: string
          description: Product's identifier
    SupportResponse:
      title: SupportResponse
      type: object
      properties:
        redirectUrl:
          type: string
  securitySchemes:
    bearerAuth:
      type: http
      description: >-
        A bearer token in the format of a JWS and conformed to the
        specifications included in
        [RFC8725](https://tools.ietf.org/html/RFC8725)
      scheme: bearer
      bearerFormat: JWT
