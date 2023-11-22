public class DeleteCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    //no merchant info needed
    private String customerProfileId;

    private String customerPaymentProfileId;



    public DeleteCustomerPaymentProfileRequest() {
        super('deleteCustomerPaymentProfile');
    }

    public override Set<String> keySet() {
        return new Set<String>{'customerProfileId', 'customerPaymentProfileId'};
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


    
}