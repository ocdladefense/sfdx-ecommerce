public class GetCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    public Integer customerProfileId;
    public Integer customerPaymentProfileId;
    public Boolean includeIssuerInfo;
    public Integer DEFAULT_PROFILE_ID = 905372692;

    public GetCustomerPaymentProfileRequest() {
        super();
        super.setMethod('GET');
    }

    public GetCustomerPaymentProfileRequest(CustomerPaymentProfile profile) {
        this();
        // We can now dynamically instantiate the AuthorizeDotNetResponse *and
        // the AuthorizeDotNetMockResponse.
        String respTypeName = req.requestType + 'Response'; // e.g., CreateCustomerPaymentProfileResponse
        String respMockName = req.requestType + 'MockResponse'; //e.g., CreateCustomerPaymentProfileMockResponse
        System.Type t = Type.forName(req.requestType);
        AuthorizeDotNetResponse resp = t.newInstance();
        
        // Currently we have no way to get ProfileID so for now it's gonna be a CONST
        this.customerProfileId = DEFAULT_PROFILE_ID;
        this.customerPaymentProfileId = profile.getCustomerPaymentProfileId();
        this.includeIssuerInfo = false;
        this.requestType = 'GetCustomerPaymentProfile';
        this.body = JSON.serialize(getBody());
    }

    public GetCustomerPaymentProfileRequest(CustomerPaymentProfile profile, Boolean includeIssuerInfo) {
        this();

        // Currently we have no way to get ProfileID so for now it's gonna be a CONST
        this.customerProfileId = DEFAULT_PROFILE_ID;
        this.customerPaymentProfileId = profile.getCustomerPaymentProfileId();
        this.includeIssuerInfo = includeIssuerInfo;
        this.requestType = 'GetCustomerPaymentProfile';
        this.body = JSON.serialize(profile, true);
    }

    public override String getBody() {
        List<String> reqBody = new String[]{'{"customerProfileId": "' + '123445' + '", "customerPaymentProfileId": "' + '838347374774' + '"'};
        this.includeIssuerInfo ? reqBody.add(', "includeIssuerInfo:" "' + 'Mhmm' +'"}') : reqBody.add('}');
        return String.join(reqBody, '');
    }
}