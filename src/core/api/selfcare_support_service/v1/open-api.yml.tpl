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
  '/institutions/{institutionId}/users':
    get:
      tags:
        - institutions
      summary: getInstitutionUsers
      description: Retrieve institution's users
      operationId: getInstitutionUsersUsingGET
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
      summary: Gets institutions filtering by taxCode and/or subunitCode
      description: Gets institutions filtering by taxCode and/or subunitCode
      operationId: getInstitutionsByTaxCodeUsingGET
      parameters:
        - name: taxCode
          in: query
          description: Institution's tax code
          required: false
          style: form
          schema:
            type: string
        - name: subunitCode
          in: query
          description: Institution's subunit code
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
  '/users/{id}':
    get:
      tags:
        - users
      summary: getUserById
      description: Get user by Id
      operationId: getUserInfoUsingGET
      parameters:
        - name: id
          in: path
          description: User's unique identifier
          required: true
          style: simple
          schema:
            type: string
        - name: institutionId
          in: query
          description: The internal identifier of the institution
          required: false
          style: form
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            '*/*':
              schema:
                $ref: '#/components/schemas/UserResponse'
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
  '/delegations':
    get:
      tags:
        - Delegation
      summary: Retrieve institution's delegations
      description: Retrieve institution's delegations
      operationId: getDelegationsUsingGET
      parameters:
        - name: institutionId
          in: query
          description: The internal identifier of the institution
          required: false
          style: form
          schema:
            type: string
        - name: brokerId
          in: query
          description: The internal identifier of the institution
          required: false
          style: form
          schema:
            type: string
        - name: productId
          in: query
          description: Product's unique identifier
          required: false
          style: form
          schema:
            type: string
        - name: mode
          in: query
          description: Mode (full or normal) to retreieve institution's delegations
          required: false
          style: form
          schema:
            type: string
            enum:
              - FULL
              - NORMAL
        - name: page
          in: query
          description: page
          required: false
          style: form
          schema:
            type: integer
            format: int32
        - name: size
          in: query
          description: size
          required: false
          style: form
          schema:
            type: integer
            format: int32
        - name: search
          in: query
          description: Description institution
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
                type: array
                items:
                  $ref: '#/components/schemas/DelegationResponse'
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
  '/user-groups':
    get:
      tags:
      - user-group
      summary: getUserGroups
      description: Service that allows to get a list of UserGroup entities filtered by the product related to Subscription Key
      operationId: getUserGroupsUsingGET
      parameters:
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
      security:
      - bearerAuth:
        - global
  '/onboarding/users':
    post:
      tags:
        - Onboarding
      summary: The service adds users to the registry if they are not present and associates them with the institution and product contained in the body
      description: The service adds users to the registry if they are not present and associates them with the institution and product contained in the body
      operationId: onboardingInstitutionUsersUsingPOST
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OnboardingInstitutionUsersRequest'
      responses:
        '200':
          description: OK
          content:
            '*/*':
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/RelationshipResult'
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
  '/onboarding/institutionOnboardings':
    get:
      tags:
        - Onboarding Controller
      summary: Returns onboardings record by institution taxCode/subunitCode/origin/originId
      description: Returns onboardings record by institution taxCode/subunitCode/origin/originId
      operationId: onboardingInstitutionUsingGET
      parameters:
        - name: origin
          in: query
          schema:
            type: string
        - name: originId
          in: query
          schema:
            type: string
        - name: status
          in: query
          schema:
            $ref: '#/components/schemas/OnboardingStatus'
        - name: subunitCode
          in: query
          schema:
            type: string
        - name: taxCode
          in: query
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
                  $ref: '#/components/schemas/OnboardingResponse'
        '401':
          description: Not Authorized
        '403':
          description: Not Allowed
      security:
        - bearerAuth:
            - global
  '/onboarding/{onboardingId}/consume':
    put:
      tags:
        - Onboarding Controller
      summary: Perform complete operation of an onboarding request as /complete but without signature verification of the contract
      description: Perform complete operation of an onboarding request as /complete but without signature verification of the contract
      operationId: completeOnboardingTokenConsume
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: onboardingId
          in: path
          required: true
          schema:
            type: string
      requestBody:
        content:
          multipart/form-data:
            schema:
              type: object
              properties:
                contract:
                  format: binary
                  type: string
      responses:
        '200':
          description: OK
          content:
            application/json: {}
        '401':
          description: Not Authorized
        '403':
          description: Not Allowed
      security:
        - bearerAuth:
            - global
  '/onboarding/{onboardingId}/update':
    put:
      tags:
      - Onboarding
      operationId: updateOnboardiUsingPUT
      summary: 'Update onboarding request receiving onboarding id.Function can change
        some values. '
      parameters:
      - name: onboardingId
        in: path
        required: true
        schema:
          type: string
      - name: status
        in: query
        schema:
          $ref: '#/components/schemas/OnboardingStatus'
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OnboardingDefaultRequest'
      responses:
        "200":
          description: OK
          content:
            application/json: {}
        "403":
          description: Not Allowed
        "401":
          description: Not Authorized
      security:
        - bearerAuth:
            - global
  '/tokens/products/{productId}':
    get:
      tags:
        - Token
      summary: Service to retrieve tokens from product's identifier
      description: Service to retrieve tokens from product's identifier
      operationId: getTokensFromProductUsingGET
      parameters:
        - name: productId
          in: path
          description: Product's identifier
          required: true
          style: simple
          schema:
            type: string
        - name: page
          in: query
          description: Number of page
          required: false
          style: form
          schema:
            type: integer
            format: int32
        - name: size
          in: query
          description: Number of elements per page
          required: false
          style: form
          schema:
            type: integer
            format: int32
        - name: status
          in: query
          description: 'Token''s status. Available values: REQUEST, TOBEVALIDATED, PENDING, COMPLETED, FAILED, REJECTED, DELETED'
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
                $ref: '#/components/schemas/TokensResource'
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
    InstitutionType:
      enum:
      - PA
      - PG
      - GSP
      - SA
      - PT
      - SCP
      - PSP
      - AS
      - REC
      - CON
      type: string
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
    Origin:
      enum:
      - MOCK
      - IPA
      - SELC
      - ANAC
      - UNKNOWN
      - ADE
      - INFOCAMERE
      - IVASS
      type: string
    GeographicTaxonomies:
      title: GeographicTaxonomies
      type: object
      properties:
        code:
          type: string
        country:
          type: string
        country_abbreviation:
          type: string
        desc:
          type: string
        enabled:
          type: boolean
        istat_code:
          type: string
        province_abbreviation:
          type: string
        province_id:
          type: string
        region_id:
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
    DelegationResponse:
      title: DelegationResponse
      type: object
      properties:
        brokerId:
          type: string
        brokerName:
          type: string
        brokerTaxCode:
          type: string
        brokerType:
          type: string
        id:
          type: string
        institutionId:
          type: string
        institutionName:
          type: string
        institutionRootName:
          type: string
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
        productId:
          type: string
        taxCode:
          type: string
        type:
          type: string
          enum:
            - AOO
            - PT
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
    InstitutionUpdate:
      title: InstitutionUpdate
      type: object
      properties:
        address:
          type: string
        businessRegisterPlace:
          type: string
        dataProtectionOfficer:
          $ref: '#/components/schemas/DataProtectionOfficer'
        description:
          type: string
        digitalAddress:
          type: string
        geographicTaxonomies:
          type: array
          items:
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
            - SA
            - SCP
            - AS
            - REC
            - CON
        paymentServiceProvider:
          $ref: '#/components/schemas/PaymentServiceProvider'
        rea:
          type: string
        shareCapital:
          type: string
        supportEmail:
          type: string
        supportPhone:
          type: string
        taxCode:
          type: string
        zipCode:
          type: string
    LegalsResponse:
      title: LegalsResponse
      type: object
      properties:
        env:
          type: string
          enum:
            - COLL
            - DEV
            - PROD
            - ROOT
        partyId:
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
    DataProtectionOfficer:
      title: DataProtectionOfficer
      type: object
      properties:
        address:
          type: string
        email:
          type: string
        pec:
          type: string
    PaymentServiceProvider:
      title: PaymentServiceProvider
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
    OnboardingInstitutionUsersRequest:
      title: OnboardingInstitutionUsersRequest
      type: object
      properties:
        institutionSubunitCode:
          type: string
        institutionTaxCode:
          type: string
        productId:
          type: string
        sendCreateUserNotificationEmail:
          type: boolean
        users:
          type: array
          items:
            $ref: '#/components/schemas/Person'
    Person:
      title: Person
      type: object
      properties:
        email:
          type: string
        env:
          type: string
          enum:
            - COLL
            - DEV
            - PROD
            - ROOT
        id:
          type: string
        name:
          type: string
        productRole:
          type: string
        role:
          type: string
          enum:
            - DELEGATE
            - MANAGER
            - OPERATOR
            - SUB_DELEGATE
        roleLabel:
          type: string
        surname:
          type: string
        taxCode:
          type: string
    RelationshipResult:
      title: RelationshipResult
      type: object
      properties:
        billing:
          $ref: '#/components/schemas/BillingResponse'
        createdAt:
          type: string
          format: date-time
        from:
          type: string
        id:
          type: string
        institutionUpdate:
          $ref: '#/components/schemas/InstitutionUpdate'
        pricingPlan:
          type: string
        product:
          $ref: '#/components/schemas/ProductInfo'
        role:
          type: string
          enum:
            - DELEGATE
            - MANAGER
            - OPERATOR
            - SUB_DELEGATE
        state:
          type: string
          enum:
            - ACTIVE
            - DELETED
            - PENDING
            - REJECTED
            - SUSPENDED
            - TOBEVALIDATED
        to:
          type: string
        tokenId:
          type: string
        updatedAt:
          type: string
          format: date-time
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
    UserResponse:
      title: UserResponse
      type: object
      properties:
        email:
          type: string
        id:
          type: string
        name:
          type: string
        surname:
          type: string
        taxCode:
          type: string
    TokensResource:
      title: TokensResource
      type: object
      properties:
        items:
          type: array
          items:
            $ref: '#/components/schemas/TokenResource'
    TokenResource:
      title: TokenResource
      type: object
      properties:
        checksum:
          type: string
        closedAt:
          type: string
          format: date-time
        contentType:
          type: string
        contractSigned:
          type: string
        contractTemplate:
          type: string
        contractVersion:
          type: string
        createdAt:
          type: string
          format: date-time
        expiringDate:
          type: string
          format: date-time
        id:
          type: string
        institutionId:
          type: string
        institutionUpdate:
          $ref: '#/components/schemas/InstitutionUpdate'
        legals:
          type: array
          items:
            $ref: '#/components/schemas/LegalsResource'
        productId:
          type: string
        status:
          type: string
        updatedAt:
          type: string
          format: date-time
    LegalsResource:
      title: LegalsResource
      type: object
      properties:
        env:
          type: string
          enum:
            - COLL
            - DEV
            - PROD
            - ROOT
        partyId:
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
    OnboardingDefaultRequest:
      required:
      - productId
      - users
      - institution
      type: object
      properties:
        productId:
          minLength: 1
          type: string
        users:
          minItems: 1
          type: array
          items:
            $ref: '#/components/schemas/UserRequest'
        pricingPlan:
          type: string
        signContract:
          type: boolean
        institution:
          $ref: '#/components/schemas/InstitutionBaseRequest'
        billing:
          $ref: '#/components/schemas/BillingRequest'
        additionalInformations:
          $ref: '#/components/schemas/AdditionalInformationsDto'
    BillingRequest:
      type: object
      properties:
        vatNumber:
          type: string
        recipientCode:
          type: string
        publicServices:
          type: boolean
    UserRequest:
      type: object
      properties:
        taxCode:
          type: string
        name:
          type: string
        surname:
          type: string
        email:
          type: string
        role:
          $ref: '#/components/schemas/PartyRole'
    InstitutionBaseRequest:
      required:
      - institutionType
      - digitalAddress
      type: object
      properties:
        institutionType:
          $ref: '#/components/schemas/InstitutionType'
        taxCode:
          type: string
        subunitCode:
          type: string
        subunitType:
          $ref: '#/components/schemas/InstitutionPaSubunitType'
        origin:
          $ref: '#/components/schemas/Origin'
        originId:
          type: string
        city:
          type: string
        country:
          type: string
        county:
          type: string
        description:
          type: string
        digitalAddress:
          minLength: 1
          type: string
        address:
          type: string
        zipCode:
          type: string
        geographicTaxonomies:
          type: array
          items:
            $ref: '#/components/schemas/GeographicTaxonomyDto'
        rea:
          type: string
        shareCapital:
          type: string
        businessRegisterPlace:
          type: string
        supportEmail:
          type: string
        supportPhone:
          type: string
        imported:
          type: boolean
    GeographicTaxonomyDto:
      type: object
      properties:
        code:
          type: string
        desc:
          type: string
    OnboardingResponse:
      type: object
      properties:
        id:
          type: string
        productId:
          type: string
        workflowType:
          type: string
        institution:
          $ref: '#/components/schemas/InstitutionResponse'
        pricingPlan:
          type: string
        users:
          type: array
          items:
            $ref: '#/components/schemas/UserOnboardingResponse'
        billing:
          $ref: '#/components/schemas/BillingResponse'
        status:
          type: string
        additionalInformations:
          $ref: '#/components/schemas/AdditionalInformationsDto'
        userRequestUid:
          type: string
    InstitutionPaSubunitType:
      enum:
      - AOO
      - UO
      type: string
    UserOnboardingResponse:
      type: object
      properties:
        id:
          type: string
        role:
          $ref: '#/components/schemas/PartyRole'
        productRole:
          type: string
        userMailUuid:
          type: string
    AdditionalInformationsDto:
      type: object
      properties:
        belongRegulatedMarket:
          type: boolean
        regulatedMarketNote:
          type: string
        ipa:
          type: boolean
        ipaCode:
          type: string
        establishedByRegulatoryProvision:
          type: boolean
        establishedByRegulatoryProvisionNote:
          type: string
        agentOfPublicService:
          type: boolean
        agentOfPublicServiceNote:
          type: string
        otherNote:
          type: string
    PartyRole:
      enum:
        - MANAGER
        - DELEGATE
        - SUB_DELEGATE
        - OPERATOR
      type: string
    OnboardingStatus:
      enum:
        - REQUEST
        - TOBEVALIDATED
        - PENDING
        - COMPLETED
        - FAILED
        - REJECTED
        - DELETED
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
