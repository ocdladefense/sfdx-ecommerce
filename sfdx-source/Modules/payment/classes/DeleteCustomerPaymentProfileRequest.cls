public class DeleteCustomerPaymentProfileRequest extends HttpRequestMessage {
    //no merchant info needed
    private Map<String, Object> deleteBody;
    private final String DELETE_ENDPOINT = 'https://appdev.ocdla.org/customer/905372692/cards';

    //is there a way to keep the value 'deleteCustomerPaymentProfileRequest' accessible without deserializing later?

    public DeleteCustomerPaymentProfileRequest(CustomerPaymentProfile profile, String customerProfileId) {
        this.setMethod('POST');
        this.setEndpoint(DELETE_ENDPOINT);
        this.deleteBody = new Map<String, Object>{
            'deleteCustomerPaymentProfileRequest'=>new Map<String,Object>{
                'merchantAuthentication'=> new Map<String, Object>{
                    'customerProfileId'=> customerProfileId,
                    'customerPaymentProfileId'=>profile.getCustomerPaymentProfileId()
                }
            }
        };
        this.body = JSON.serialize(this.deleteBody, true);

        
    }

  
}