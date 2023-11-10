public class DeleteCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    //no merchant info needed
    private String customerProfileId;

    private String customerPaymentProfileId;



    public DeleteCustomerPaymentProfileRequest() {
        super();
        requestType = 'deleteCustomerPaymentProfile';
    }



    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }
    public String getCustomerProfileId() {
        return this.customerProfileId;
    }
    public void setCustomerPaymentProfileId(String customerPaymentProfileId) {
        this.customerPaymentProfileId = customerPaymentProfileId;
    }
    public String getCustomerPaymentProfileId() {
        return this.customerPaymentProfileId;
    }

    // System.JSONGenerator.


    public override String getBody() {

        
        JSONGenerator gen = super.getJsonGenerator();

        // Continue processing the JSON for the request.

        // Use the generator to create one or more objects for the payload json,
        // *in the exact order as required by the Authorize.net documentation.
        return gen.getAsString();

    }

    
}