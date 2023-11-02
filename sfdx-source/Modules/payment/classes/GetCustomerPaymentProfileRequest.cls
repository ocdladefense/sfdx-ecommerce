public class GetCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    public Integer customerProfileId;
    public Integer customerPaymentProfileId;
    public Boolean includeIssuerInfo;

    public GetCustomerPaymentProfileRequest() {
        super();
        super.setMethod('GET');
    }

    public GetCustomerPaymentProfileRequest(CustomerPaymentProfile profile) {
        this();
        // We can now dynamically instantiate the AuthorizeDotNetResponse *and
        // the AuthorizeDotNetMockResponse.
        // String respTypeName = req.requestType + 'Response'; // e.g., CreateCustomerPaymentProfileResponse
        // String respMockName = req.requestType + 'MockResponse'; //e.g., CreateCustomerPaymentProfileMockResponse
        // System.Type t = Type.forName(req.requestType);
        // AuthorizeDotNetResponse resp = t.newInstance();
        // 
        this.requestType = 'GetCustomerPaymentProfile';
        this.body = JSON.serialize(profile, true);
    }

    public override String getBody() {
        // body for request, look below method
        return '{"customerProfileId": "' + this.customerProfileId + '", "customerPaymentProfileId": "' + this.customerPaymentProfileId + '", "includeIssuerInfo": "' + this.includeIssuerInfo + '"}';
    }
}