public class DeleteCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    //no merchant info needed
    private String customerProfileId;
    private String customerPaymentProfileId;
    private CustomerPaymentProfile profile;
   

    public DeleteCustomerPaymentProfileRequest() {
        super();
    }
    public DeleteCustomerPaymentProfileRequest(CustomerPaymentProfile profile, String customerPaymentProfile){

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
        this.customerProfileId = profile.getCustomerProfileId();
        this.profile = profile;
        this.requestType = 'DeleteCustomerPaymentProfile';
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

    public override Map<String,Object> getBodyAsNativeObject(){
        Map<String,Object> obj = new Map<String,Object>();

        obj.put('customerProfileId', this.customerProfileId);
        obj.put('customerPaymentProfileId', this.profile.getCustomerPaymentProfileId());
        return obj;
    }

    //for running unit tests
    //response payload does not include customerProfileId or PaymentProfileId
    
}