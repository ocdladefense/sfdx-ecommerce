public class CreateCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {


    public CreateCustomerPaymentProfileRequest() {
        super();
    }

    public CreateCustomerPaymentProfileRequest(CustomerPaymentProfile profile) {
        this();
        // We can now dynamically instantiate the AuthorizeDotNetResponse *and
        // the AuthorizeDotNetMockResponse.
        // String respTypeName = req.requestType + 'Response'; // e.g., CreateCustomerPaymentProfileResponse
        // String respMockName = req.requestType + 'MockResponse'; //e.g., CreateCustomerPaymentProfileMockResponse
        // System.Type t = Type.forName(req.requestType);
        // AuthorizeDotNetResponse resp = t.newInstance();
        // 
        this.requestType = 'CreateCustomerPaymentProfile';
        this.body = JSON.serialize(profile, true);
    }
}