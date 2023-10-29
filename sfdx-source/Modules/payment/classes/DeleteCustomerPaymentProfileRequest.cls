public class DeleteCustomerPaymentProfileRequest extends HttpRequestMessage {
    //no merchant info needed
    private Map<String, Object> deleteBody;

    public DeleteCustomerPaymentProfileRequest(CustomerPaymentProfile profile, String customerProfileId) {
        
        this.deleteBody = new Map<String, Object>{
            'merchantAuthentication'=> new Map<String, Object>{
                'customerProfileId'=> customerProfileId,
                'customerPaymentProfileId'=>profile.getCustomerPaymentProfileId()
            }
        };
        this.body = JSON.serialize(this.deleteBody, true);
    }

  
}