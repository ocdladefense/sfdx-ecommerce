public class UpdatePaymentProfileResponse extends AuthorizeDotNetResponse {
    private Boolean defaultPaymentProfile;
    private String validationDirectResponse;
    // Optional instance variable
    private String refId;

    public UpdatePaymentProfileResponse() {

    }

    public override void deserialize() {
        super.deserialize();

        Map<String, Object> updateBody = this.temp;

        String validResp = (String)updateBody.get('validationDirectResponse');
        Boolean isDefault = (Boolean)updateBody.get('defaultPaymentProfile');
        String refId = (String)updateBody.get('refId');

    }

    public String getValidationResponse() {
        return this.validationDirectResponse;
    }

    public Boolean isDefault() {
        return this.defaultPaymentProfile != null ? this.defaultPaymentProfile : false;
    }

    public String getRefId() {
        return this.refId;
    }
}