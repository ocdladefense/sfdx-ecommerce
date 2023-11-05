public class DeleteCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    //no merchant info needed
    private String customerProfileId;
    private CustomerPaymentProfile profile;
    private final String DELETE_ENDPOINT = 'https://appdev.ocdla.org/customer/905372692/cards';

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
        return this.customerProfileId = customerProfileId;
    }
    public override Map<String,Object> getBodyAsNativeObject(){
        Map<String,Object> obj = new Map<String,Object>();

        obj.put('customerProfileId', this.customerProfileId);
        obj.put('customerPaymentProfileId', this.profile.getCustomerPaymentProfileId());
        return obj;
    }
}