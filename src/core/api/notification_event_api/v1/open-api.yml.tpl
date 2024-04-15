openapi: 3.0.3
info:
  title: selc-notification-event-api
  description: This service acts as an orchestrator for information coming from different services and as a proxy
  version: 0.0.1-SNAPSHOT
servers:
  - url: 'https://${host}/${basePath}'
tags:
  - name: notification-event
    description: Notification Event Controller
paths:
  '/notification-event/contracts':
    post:
      tags:
        - kafka
      summary: resendContracts
      description: Service to resend contract notifications on SC-Contracts topic
      operationId: resendContractsUsingPOST
      parameters:
        - name: size
          in: query
          description: size
          required: false
          style: form
          schema:
            type: integer
            format: int32
        - name: productsFilter
          in: query
          description: productsFilter
          required: true
          style: form
          explode: true
          schema:
            type: string
      responses:
        '200':
          description: OK
        '400':
          description: Bad Request
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
        '409':
          description: Conflict
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  '/notification-event/users':
    post:
      tags:
        - kafka
      summary: resendUsers
      description: >-
        Service to resend old user onboardings to the SCUsers kafka queue, it
        can send the onboardings of a single user or also retrieve all the users
        for a given set of products in a paged manner by passing page and size
      operationId: resendUsersUsingPOST
      parameters:
        - name: size
          in: query
          description: size
          required: false
          style: form
          schema:
            type: integer
            format: int32
        - name: page
          in: query
          description: page
          required: false
          style: form
          schema:
            type: integer
            format: int32
        - name: productsFilter
          in: query
          description: productsFilter
          required: true
          style: form
          explode: true
          schema:
            type: string
        - name: userId
          in: query
          description: userId
          required: false
          style: form
          schema:
            type: string
      responses:
        '200':
          description: OK
        '400':
          description: Bad Request
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
        '409':
          description: Conflict
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  '/notification-event/users/count':
    get:
      tags:
        - kafka
      summary: countUsers
      description: Users' Count for single product
      operationId: countUsersUsingGET
      responses:
        '200':
          description: OK
          content:
            '*/*':
              schema:
                $ref: '#/components/schemas/ProductCountResponse'
        '400':
          description: Bad Request
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
      security:
        - bearerAuth:
            - global
components:
  schemas:
    Problem:
      title: Problem
      type: object
      properties:
        errors:
          type: array
          items:
            $ref: '#/components/schemas/ProblemError'
        status:
          type: integer
          format: int32
    ProblemError:
      title: ProblemError
      type: object
    ProductCount:
      title: ProductCount
      type: object
      properties:
        count:
          type: integer
          format: int32
        productId:
          type: string
    ProductCountResponse:
      title: ProductCountResponse
      type: object
      properties:
        products:
          type: array
          items:
            $ref: '#/components/schemas/ProductCount'
  securitySchemes:
    bearerAuth:
      type: http
      description: >-
        A bearer token in the format of a JWS and conformed to the
        specifications included in
        [RFC8725](https://tools.ietf.org/html/RFC8725)
      scheme: bearer
      bearerFormat: JWT
