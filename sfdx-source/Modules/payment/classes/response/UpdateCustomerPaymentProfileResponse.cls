public class UpdateCustomerPaymentProfileResponse extends AuthorizeDotNetResponse {
    private String validationDirectResponse;
    // possible eventual class we make, comment out for now.
    // private Messages messages;
    // Optional instance variable
    private String refId;

    public UpdateCustomerPaymentProfileResponse() {
        super();
    }

    public override void deserialize() {
        super.deserialize();

        Map<String, Object> updateBody = (Map<String,Object>)JSON.deserializeUntyped(this.getBody());
        String validResp = (String)updateBody.get('validationDirectResponse');
        // Eventual getter and setting of messages once class is made.
        String refId = (String)updateBody.get('refId');
    }

    public String getValidationResponse() {
        return this.validationDirectResponse;
    }
}