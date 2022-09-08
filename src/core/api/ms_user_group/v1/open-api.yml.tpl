---
openapi: 3.0.3
info:
  title: selc-user-group
  description: The services described in this section deal with the management of
    UserGroup entity, providing the necessary  methods for its creation, consultation
    and activation.
  version: 1.0-SNAPSHOT
servers:
- url: 'https://${host}/${basePath}'
tags:
- name: user-group
  description: User group endpoint CRUD operations
paths:
  "/":
    get:
      tags:
      - user-group
      summary: getUserGroups
      description: Service that allows to get a list of UserGroup entities
      operationId: getUserGroupsUsingGET
      parameters:
      - name: x-selfcare-uid
        in: header
        description: Logged user's unique identifier
        required: true
        schema:
          type: string
      - name: institutionId
        in: query
        description: Users group's institutionId
        required: false
        style: form
        schema:
          type: string
      - name: page
        in: query
        description: The page number to access (0 indexed, defaults to 0)
        required: false
        style: form
        allowReserved: true
        schema:
          type: integer
          format: int32
      - name: size
        in: query
        description: Number of records per page (defaults to 20, max 2000)
        required: false
        style: form
        allowReserved: true
        schema:
          type: integer
          format: int32
      - name: sort
        in: query
        description: 'Sorting criteria in the format: property(,asc|desc). Default sort order is ascending. Multiple sort criteria are supported.'
        required: false
        style: form
        allowReserved: true
        schema:
          type: array
          items:
            type: string
      - name: productId
        in: query
        description: Users group's productId
        required: false
        style: form
        schema:
          type: string
      - name: userId
        in: query
        description: Member's unique identifier
        required: false
        style: form
        schema:
          type: string
          format: uuid
      - name: status
        in: query
        description: If filter on status is present, it must be used with at least
          one of the other filters
        required: false
        style: form
        schema:
          type: string
          enum:
          - ACTIVE
          - SUSPENDED
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                "$ref": "#/components/schemas/PageOfUserGroupResource"
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                "$ref": "#/components/schemas/Problem"
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                "$ref": "#/components/schemas/Problem"
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                "$ref": "#/components/schemas/Problem"
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                "$ref": "#/components/schemas/Problem"
      deprecated: true
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
    PageOfUserGroupResource:
      title: PageOfUserGroupResource
      required:
        - content
        - number
        - size
        - totalElements
        - totalPages
      type: object
      properties:
        content:
          type: array
          description: The page content
          items:
            "$ref": "#/components/schemas/UserGroupResource"
        number:
          type: integer
          description: The number of the current page
          format: int32
        size:
          type: integer
          description: The size of the page
          format: int32
        totalElements:
          type: integer
          description: The total amount of elements
          format: int64
        totalPages:
          type: integer
          description: The number of total pages
          format: int32
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
            "$ref": "#/components/schemas/InvalidParam"
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
      description: A "problem detail" as a way to carry machine-readable details of
        errors (https://datatracker.ietf.org/doc/html/rfc7807)
    UserGroupResource:
      title: UserGroupResource
      required:
      - description
      - id
      - institutionId
      - name
      - productId
      - status
      type: object
      properties:
        description:
          type: string
          description: Users group's description
        id:
          type: string
          description: Users group's unique identifier
        institutionId:
          type: string
          description: Users group's institutionId
        name:
          type: string
          description: Users group's name
        productId:
          type: string
          description: Users group's productId
        status:
          type: string
          description: Users group's status
          enum:
          - ACTIVE
          - SUSPENDED
  securitySchemes:
    bearerAuth:
      type: http
      description: A bearer token in the format of a JWS and conformed to the specifications
        included in [RFC8725](https://tools.ietf.org/html/RFC8725)
      scheme: bearer
      bearerFormat: JWT
