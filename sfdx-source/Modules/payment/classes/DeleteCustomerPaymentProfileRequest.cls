public class DeleteCustomerPaymentProfileRequest extends HttpRequestMessage {
    //no merchant info needed
    private Map<String, Object> deleteBody;
    private final String DELETE_ENDPOINT = 'https://appdev.ocdla.org/customer/905372692/cards';
    
    public DeleteCustomerPaymentProfileRequest(CustomerPaymentProfile profile, String customerProfileId) {
        this.setMethod('POST');
        this.setEndpoint(DELETE_ENDPOINT);

        this.deleteBody = new Map<String, Object>{
            'deleteCustomerPaymentProfileRequest'=>new Map<String,Object>{
                'customerProfileId'=> customerProfileId,
                'customerPaymentProfileId'=>profile.getCustomerPaymentProfileId()
            }
        };
        this.body = JSON.serialize(this.deleteBody, true);
    }
  
}