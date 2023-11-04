public class DeleteCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    //no merchant info needed
    private final String DELETE_ENDPOINT = 'https://appdev.ocdla.org/customer/905372692/cards';

    public DeleteCustomerPaymentProfileRequest() {
        super();
    }
    public DeleteCustomerPaymentProfileRequest(CustomerPaymentProfile profile) {
        this();
        // We can now dynamically instantiate the AuthorizeDotNetResponse *and
        // the AuthorizeDotNetMockResponse.
        // String respTypeName = req.requestType + 'Response'; // e.g., CreateCustomerPaymentProfileResponse
        // String respMockName = req.requestType + 'MockResponse'; //e.g., CreateCustomerPaymentProfileMockResponse
        // System.Type t = Type.forName(req.requestType);
        // AuthorizeDotNetResponse resp = t.newInstance();
        // 
        this.requestType = 'DeleteCustomerPaymentProfile';
        this.body = JSON.serialize(profile, true);
    }
    public DeleteCustomerPaymentProfileRequest(CustomerPaymentProfile profile, String customerProfileId) {
        this.setMethod('POST');
        this.setEndpoint(DELETE_ENDPOINT);
        //this is not current
        Map<String, Object> bodyTmp = new Map<String, Object>{
            'deleteCustomerPaymentProfileRequest'=>new Map<String,Object>{
                'customerProfileId'=> customerProfileId,
                'customerPaymentProfileId'=>profile.getCustomerPaymentProfileId()
            }
        };

        this.body = JSON.serialize(bodyTmp, true);
    }
    
    /*
    public override getBodyAsNativeObject(){
        return 
    }
    */
}