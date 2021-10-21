openapi: 3.0.3
info:
  title: Party Registry Proxy Server
  description: This service is the proxy to the party registry
  contact:
    name: API Support
    url: http://www.example.com/support
    email: support@example.com
  termsOfService: http://localhost/terms
  x-api-id: an x-api-id
  x-summary: an x-summary
servers:
  - url: https://${host}/pdnd-interop-uservice-party-registry-proxy/v1
    description: This service is the proxy to the party registry
tags:
  - name: organization
    description: Retrieve information about organization
    externalDocs:
      description: Find out more
      url: http://swagger.io
paths:
  /organizations/{orgId}:
    get:
      tags:
        - organization
      summary: Find organization by ID
      description: Returns a single organization
      operationId: getOrganizationById
      parameters:
        - name: orgId
          in: path
          description: ID of organization to return
          required: true
          schema:
            type: string
      responses:
        '200':
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
                $ref: '#/components/schemas/OrganizationError'
        '404':
          description: Organization not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/OrganizationError'
components:
  schemas:
    Organization:
      required:
        - id
        - dn
        - description
        - pec
      type: object
      properties:
        id:
          type: string
          example: age
        dn:
          type: string
          example: aoo=agd_DG,o=agd,c=it
        description:
          type: string
          example: AGENCY X
        pec:
          type: string
          example: mail@pec.mail.org
    OrganizationError:
      required:
        - detail
        - type
        - title
        - status
      type: object
      properties:
        detail:
          type: string
        type:
          type: string
        title:
          type: string
        status:
          type: string