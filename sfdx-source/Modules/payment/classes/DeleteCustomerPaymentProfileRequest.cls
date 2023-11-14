public class DeleteCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    //no merchant info needed
    private String customerProfileId;

    private String customerPaymentProfileId;



    public DeleteCustomerPaymentProfileRequest() {
        super('deleteCustomerPaymentProfile');
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


    public override String getBody() {

        if(this.customerPaymentProfileId!=null && this.customerProfileId!=null){
            JSONGenerator gen = super.getJsonGenerator();

            // Continue processing the JSON for the request.
            gen.writeStringField('customerProfileId', this.customerProfileId);
            gen.writeStringField('customerPaymentProfileId', this.customerPaymentProfileId);
            gen.writeEndObject();
            gen.writeEndObject();
            // Use the generator to create one or more objects for the payload json,
            // *in the exact order as required by the Authorize.net documentation.
            return gen.getAsString();
        }
        else{
            return '';
        }
       
    }

    
}