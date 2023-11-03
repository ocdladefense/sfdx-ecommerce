public class CreateCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    private String customerProfileId;
    private CustomerPaymentProfile profile;

    public CreateCustomerPaymentProfileRequest() {
        super();
    }

    public CreateCustomerPaymentProfileRequest(CustomerPaymentProfile profile) {
        this();
        this.profile = profile;
        // We can now dynamically instantiate the AuthorizeDotNetResponse *and
        // the AuthorizeDotNetMockResponse.
        // String respTypeName = req.requestType + 'Response'; // e.g., CreateCustomerPaymentProfileResponse
        // String respMockName = req.requestType + 'MockResponse'; //e.g., CreateCustomerPaymentProfileMockResponse
        // System.Type t = Type.forName(req.requestType);
        // AuthorizeDotNetResponse resp = t.newInstance();
        // 
        this.requestType = 'CreateCustomerPaymentProfile';
        //this.body = JSON.serialize(profile, true);
    }

    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }

    public override Map<String,Object> getBodyAsNativeObject() {
        Map<String,Object> obj = new Map<String,Object>();

        obj.put('customerProfileId', this.customerProfileId);
        obj.put('paymentProfile', profile);
        return obj;
    }
}