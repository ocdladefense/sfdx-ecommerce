public class CreateCustomerPaymentProfileResponse extends AuthorizeDotNetRespose {
    public CreateCustomerPaymentProfileResponse() {

    }

    private String customerProfileId;
    private Boolean defaultPaymentProfile;
    private String validationDirectResponse;

    // Only displays if successful
    private String customerPaymentProfileId;

    // Optional
    private String refId;

    public CreatePaymentProfileResponse() {

    }

    public override void deserialize() {
        super.deserialize();

        Map<String, Object> createBody = this.temp;

        String validResp = (String)createBody.get('validationDirectResponse');
        Boolean isDefault = (Boolean)createBody.get('defaultPaymentProfile');
        String refId = (String)createBody.get('refId');
        String custProfileId = (String) createBody.get('customerProfileId');
        String custPaymentProfileId = (String) createBody.get('customerPaymentProfileId');

        this.validationDirectResponse = validResp;
        this.defaultPaymentProfile = isDefault;
        this.refId = refId;
        this.customerProfileId = custProfileId;
        this.customerPaymentProfileId = custPaymentProfileId;
    }

    public String getCustomerProfileId() {
        return this.customerPaymentProfileId;
    }

    public String getCustomerPaymentProfileId() {
        return this.customerPaymentProfileId;
    }

    public String getValidationResponse() {
        return this.validationDirectResponse;
    }

    public String getRefId() {
        return this.refId;
    }

    public Boolean isDefault() {
        return this.defaultPaymentProfile != null ? this.defaultPaymentProfile : false;
    }
}