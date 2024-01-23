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
  /onboarding/{externalInstitutionId}/products/{productId}:
    post:
      tags:
        - onboarding
      summary: autoApprovalOnboarding
      description: The service allows the onboarding of institutions with auto approval
      operationId: autoApprovalOnboardingUsingPOST
      parameters:
        - name: externalInstitutionId
          in: path
          description: Institution's unique external identifier
          required: true
          style: simple
          schema:
            type: string
        - name: productId
          in: path
          description: Product's unique identifier
          required: true
          style: simple
          schema:
            type: string
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OnboardingDto'
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
    AssistanceContactsDto:
      title: AssistanceContactsDto
      type: object
      properties:
        supportEmail:
          type: string
          description: Institution's support email contact
          format: email
          example: email@example.com
        supportPhone:
          type: string
          description: Institution's support phone contact
    BillingDataDto:
      title: BillingDataDto
      required:
        - businessName
        - digitalAddress
        - recipientCode
        - registeredOffice
        - taxCode
        - vatNumber
        - zipCode
      type: object
      properties:
        businessName:
          type: string
          description: Institution's legal name
        digitalAddress:
          type: string
          description: Institution's digitalAddress
        publicServices:
          type: boolean
          description: Institution's service type
          example: false
        recipientCode:
          type: string
          description: Billing recipient code
        registeredOffice:
          type: string
          description: Institution's physical address
        taxCode:
          type: string
          description: Institution's taxCode
        vatNumber:
          type: string
          description: Institution's VAT number
        zipCode:
          type: string
          description: Institution's zipCode
    CompanyInformationsDto:
      title: CompanyInformationsDto
      type: object
      properties:
        businessRegisterPlace:
          type: string
          description: Institution's business register place
        rea:
          type: string
          description: Institution's REA
        shareCapital:
          type: string
          description: Institution's share capital value
    DpoDataDto:
      title: DpoDataDto
      required:
        - address
        - email
        - pec
      type: object
      properties:
        address:
          type: string
          description: DPO's address
        email:
          type: string
          description: DPO's email
          format: email
          example: email@example.com
        pec:
          type: string
          description: DPO's PEC
          format: email
          example: email@example.com
    GeographicTaxonomyDto:
      title: GeographicTaxonomyDto
      required:
        - code
        - desc
      type: object
      properties:
        code:
          type: string
          description: Institution's geographic taxonomy ISTAT code
        desc:
          type: string
          description: Institution's geographic taxonomy extended name
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
    OnboardingDto:
      title: OnboardingDto
      required:
        - billingData
        - geographicTaxonomies
        - institutionType
        - users
      type: object
      properties:
        assistanceContacts:
          description: Institution's assistance contacts
          $ref: '#/components/schemas/AssistanceContactsDto'
        billingData:
          description: Institution's billing information
          $ref: '#/components/schemas/BillingDataDto'
        companyInformations:
          description: GPS, SCP, PT optional data
          $ref: '#/components/schemas/CompanyInformationsDto'
        geographicTaxonomies:
          type: array
          description: Institution's geographic taxonomy list
          items:
            $ref: '#/components/schemas/GeographicTaxonomyDto'
        institutionType:
          type: string
          description: Institution's type
          enum:
            - GSP
            - PA
            - PSP
            - PT
            - SCP
            - SA
            - REC
            - CON
        origin:
          type: string
          description: Institution data origin
        pricingPlan:
          type: string
          description: Product's pricing plan
        pspData:
          description: Payment Service Provider (PSP) specific data
          $ref: '#/components/schemas/PspDataDto'
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
    PspDataDto:
      title: PspDataDto
      required:
        - abiCode
        - businessRegisterNumber
        - dpoData
        - legalRegisterName
        - legalRegisterNumber
        - vatNumberGroup
      type: object
      properties:
        abiCode:
          type: string
          description: PSP's ABI code
        businessRegisterNumber:
          type: string
          description: PSP's Business Register number
        dpoData:
          description: Data Protection Officer (DPO) specific data
          $ref: '#/components/schemas/DpoDataDto'
        legalRegisterName:
          type: string
          description: PSP's legal register name
        legalRegisterNumber:
          type: string
          description: PSP's legal register number
        vatNumberGroup:
          type: boolean
          description: PSP's Vat Number group
          example: false
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
