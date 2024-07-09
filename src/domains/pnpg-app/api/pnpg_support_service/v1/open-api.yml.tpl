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
  '/users':
    post:
      tags:
        - users
      summary: getUserInfo
      description: Service to retrieve user info including institutions and products linked to him
      operationId: getUserInfoUsingPOST
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/SearchUserDto'
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/UserInfoResource'
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
  '/institutions/{institutionId}/users':
    get:
      tags:
        - institutions
      summary: Get users given institutionId
      description: Retrieve institution's users
      operationId: getUsersByInstitution
      parameters:
        - name: institutionId
          in: path
          description: Institution's unique identifier
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/UserInfoResponse'
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
  '/institutions':
    get:
      tags:
        - institutions
      summary: Gets institution by taxCode
      description: Gets institutions filtering by taxCode
      operationId: getInstitutionByTaxCode
      parameters:
        - name: taxCode
          in: query
          description: Institution's tax code
          required: false
          style: form
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/InstitutionsResponse'
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
  '/institutions/{institutionId}/groups':
    get:
      tags:
        - institutions
      summary: getUserGroups
      description: Service that allows to get a list of UserGroup entities filtered by the product related to Subscription Key
      operationId: getUserGroupsUsingGET
      parameters:
        - name: institutionId
          in: path
          description: Institution's unique identifier
          required: true
          style: simple
          schema:
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
          description: If filter on status is present, it must be used with at least one of the other filters
          required: false
          style: form
          explode: true
          schema:
            type: string
            enum:
              - ACTIVE
              - DELETED
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
      security:
        - bearerAuth:
            - global
  '/national-registries/legal-tax/verification':
    post:
      tags:
        - national-registry
      summary: Perform operations on national registry
      description:  verify if given taxId is legal of given institution identified with vatNumber
      operationId: verifyLegalByPOST
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/VerifyRequestDto'
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                "$ref": "#/components/schemas/LegalVerificationResource"
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
    SearchUserDto:
      title: SearchUserDto
      required:
        - fiscalCode
      type: object
      properties:
        fiscalCode:
          type: string
          description: User's fiscal code
        statuses:
          type: array
          description: User's statuses
          items:
            type: string
            enum:
              - ACTIVE
              - DELETED
              - PENDING
              - REJECTED
              - SUSPENDED
              - TOBEVALIDATED
    UserInfoResource:
      title: UserInfoResource
      type: object
      properties:
        onboardedInstitutions:
          type: array
          description: Object that includes all info about onboarded institutions linked to a user
          items:
            $ref: '#/components/schemas/OnboardedInstitutionResource'
        user:
          description: Object that includes all info about a user
          $ref: '#/components/schemas/UserResource'
    UserResource:
      title: UserResource
      type: object
      properties:
        email:
          type: string
          description: User's institutional email
        id:
          type: string
          description: User's unique identifier
          format: uuid
        name:
          type: string
          description: User's name
        roles:
          type: array
          description: User's roles in product
          items:
            type: string
        surname:
          type: string
          description: User's surname
        fiscalCode:
          type: string
          description: User's fiscal code
    OnboardedInstitutionResource:
      title: OnboardedInstitutionResource
      type: object
      properties:
        address:
          type: string
          description: Institution's address
        description:
          type: string
          description: Institution's description
        digitalAddress:
          type: string
          description: Institution's digital address
        id:
          type: string
          description: Institution's Id
        institutionType:
          type: string
          description: Institution's type
          enum:
            - GSP
            - PA
            - PG
            - PSP
            - PT
            - SCP
            - SA
            - AS
            - REC
            - CON
        productInfo:
          description: Products' info of onboardings
          $ref: '#/components/schemas/ProductInfo'
        state:
          type: string
          description: Onboarding's state
        taxCode:
          type: string
          description: Institution's tax code
        userEmail:
          type: string
          description: User's email linked to the institution
        zipCode:
          type: string
          description: Institution's zip code
    ProductInfo:
      title: ProductInfo
      type: object
      properties:
        createdAt:
          type: string
          format: date-time
        id:
          type: string
        productRole:
          type: string
        role:
          type: string
        status:
          type: string
    LegalVerificationResource:
      title: LegalVerificationResource
      type: object
      properties:
        resultCode:
          type: string
        resultDetail:
          type: string
        verificationResult:
          type: boolean
    VerifyRequestDto:
      title: VerifyRequestDto
      required:
        - taxId
        - vatNumber
      type: object
      properties:
        taxId:
          type: string
        vatNumber:
          type: string
    PageOfUserGroupResource:
      title: PageOfUserGroupResource
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
    UserGroupResource:
      title: UserGroupResource
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
    InstitutionsResponse:
      title: InstitutionsResponse
      type: object
      properties:
        institutions:
          type: array
          items:
            $ref: '#/components/schemas/InstitutionResponse'
    InstitutionResponse:
      title: InstitutionResponse
      type: object
      properties:
        address:
          type: string
        aooParentCode:
          type: string
        attributes:
          type: array
          items:
            $ref: '#/components/schemas/AttributesResponse'
        businessRegisterPlace:
          type: string
        createdAt:
          type: string
          format: date-time
        dataProtectionOfficer:
          $ref: '#/components/schemas/DataProtectionOfficerResponse'
        description:
          type: string
        digitalAddress:
          type: string
        externalId:
          type: string
        geographicTaxonomies:
          type: array
          items:
            $ref: '#/components/schemas/GeoTaxonomies'
        id:
          type: string
        imported:
          type: boolean
        institutionType:
          type: string
          enum:
            - GSP
            - PA
            - PG
            - PSP
            - PT
            - SCP
            - SA
            - AS
            - REC
            - CON
        origin:
          type: string
        originId:
          type: string
        parentDescription:
          type: string
        paymentServiceProvider:
          $ref: '#/components/schemas/PaymentServiceProviderResponse'
        rea:
          type: string
        shareCapital:
          type: string
        subunitCode:
          type: string
        subunitType:
          type: string
        supportEmail:
          type: string
        supportPhone:
          type: string
        taxCode:
          type: string
        updatedAt:
          type: string
          format: date-time
        zipCode:
          type: string
        onboarding:
          type: array
          items:
            $ref: '#/components/schemas/OnboardedProductResponse'
    OnboardedProductResponse:
      title: OnboardedProductResponse
      type: object
      properties:
        billing:
          $ref: '#/components/schemas/BillingResponse'
        createdAt:
          type: string
          format: date-time
        productId:
          type: string
        status:
          type: string
          enum:
            - ACTIVE
            - DELETED
            - PENDING
            - REJECTED
            - SUSPENDED
            - TOBEVALIDATED
        updatedAt:
          type: string
          format: date-time
    AttributesResponse:
      title: AttributesResponse
      type: object
      properties:
        code:
          type: string
        description:
          type: string
        origin:
          type: string
    DataProtectionOfficerResponse:
      title: DataProtectionOfficerResponse
      type: object
      properties:
        address:
          type: string
        email:
          type: string
        pec:
          type: string
    GeoTaxonomies:
      title: GeoTaxonomies
      type: object
      properties:
        code:
          type: string
        desc:
          type: string
    PaymentServiceProviderResponse:
      title: PaymentServiceProviderResponse
      type: object
      properties:
        abiCode:
          type: string
        businessRegisterNumber:
          type: string
        legalRegisterName:
          type: string
        legalRegisterNumber:
          type: string
        vatNumberGroup:
          type: boolean
    BillingResponse:
      title: BillingResponse
      type: object
      properties:
        publicServices:
          type: boolean
        recipientCode:
          type: string
        vatNumber:
          type: string
    UserInfoResponse:
      title: UserInfoResponse
      type: object
      properties:
        email:
          type: string
        id:
          type: string
        name:
          type: string
        products:
          type: array
          items:
            $ref: '#/components/schemas/OnboardedProduct'
        surname:
          type: string
        taxCode:
          type: string
    OnboardedProduct:
      title: OnboardedProduct
      type: object
      properties:
        contract:
          type: string
        createdAt:
          type: string
          format: date-time
        env:
          type: string
          enum:
            - COLL
            - DEV
            - PROD
            - ROOT
        productId:
          type: string
        productRole:
          type: string
        relationshipId:
          type: string
        role:
          type: string
          enum:
            - DELEGATE
            - MANAGER
            - OPERATOR
            - SUB_DELEGATE
        status:
          type: string
          enum:
            - ACTIVE
            - DELETED
            - PENDING
            - REJECTED
            - SUSPENDED
            - TOBEVALIDATED
        tokenId:
          type: string
        updatedAt:
          type: string
          format: date-time
  securitySchemes:
    bearerAuth:
      type: http
      description: >-
        A bearer token in the format of a JWS and conformed to the
        specifications included in
        [RFC8725](https://tools.ietf.org/html/RFC8725)
      scheme: bearer
      bearerFormat: JWT
