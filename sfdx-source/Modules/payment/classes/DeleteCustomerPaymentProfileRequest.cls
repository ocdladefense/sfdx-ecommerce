public class DeleteCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    //no merchant info needed
    private final String DELETE_ENDPOINT = 'https://appdev.ocdla.org/customer/905372692/cards';
    
    public DeleteCustomerPaymentProfileRequest(CustomerPaymentProfile profile, String customerProfileId) {
        this.setMethod('POST');
        this.setEndpoint(DELETE_ENDPOINT);

        Map<String, Object> bodyTmp = new Map<String, Object>{
            'deleteCustomerPaymentProfileRequest'=>new Map<String,Object>{
                'customerProfileId'=> customerProfileId,
                'customerPaymentProfileId'=>profile.getCustomerPaymentProfileId()
            }
        };

        this.body = JSON.serialize(bodyTmp, true);
    }
  
}