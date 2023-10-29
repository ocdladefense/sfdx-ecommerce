public class DeleteCustomerPaymentProfileRequest extends HttpRequestMessage {
    //no merchant info needed
    private Map<String, Object> deleteBody;
    private final String DELETE_ENDPOINT = 'https://appdev.ocdla.org/customer/905372692/cards';
    private PaymentGatewayRequestType requestType;

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

    public PaymentGatewayRequestType getRequestType(){
        return this.requestType;
    }

    //call this method in tests to set the requesttype to control what the body will be set to 
    //default is set to DELETE_CUSTOMER_PAYMENT_PROFILE_SUCCESS so the request type will be set when called through the method on CustomerPaymentProfile
    //or is it better to keep there?
    public void setRequestType(PaymentGatewayRequestType requestType){
        this.requestType = requestType;
    } 

    public PaymentGatewayRequestType addRequestTypeForTest(Integer customerPaymentProfileId){
        //
        if (this.requestType ==null){
            List<Integer> samplePaymentProfileIds = AuthorizeDotNetMockResponse.samplePaymentProfileIds();
            //default set to error
            this.requestType=PaymentGatewayRequestType.DELETE_CUSTOMER_PAYMENT_PROFILE_ERROR;

            //if matching profile id is found set request type to success
            for (Integer sampleId : samplePaymentProfileIds){
                Integer index;
                if (sampleId==customerPaymentProfileId){
                    this.requestType = PaymentGatewayRequestType.DELETE_CUSTOMER_PAYMENT_PROFILE_SUCCESS;
                }
            }
        }
        return;
    }
  
}