public class GetCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    public String customerProfileId;
    public String customerPaymentProfileId;
    public Boolean includeIssuerInfo;
    public String DEFAULT_PROFILE_ID = '905372692';

    public GetCustomerPaymentProfileRequest() {
        super();
        super.setMethod('GET');
        this.requestType = 'GetCustomerPaymentProfile';
    }

    public GetCustomerPaymentProfileRequest(CustomerPaymentProfile profile) {
        this();
        // We can now dynamically instantiate the AuthorizeDotNetResponse *and
        // the AuthorizeDotNetMockResponse.
        
        // Currently we have no way to get ProfileID so for now it's gonna be a CONST
        this.customerProfileId = DEFAULT_PROFILE_ID;
        this.customerPaymentProfileId = profile.getCustomerPaymentProfileId();
        this.includeIssuerInfo = false;
        this.requestType = 'GetCustomerPaymentProfile';
        this.body = JSON.serialize(getBody());

        // Code from CreateCustomerPaymentProfileRequest BEFORE EDITS
        String respTypeName = this.getRequestType() + 'Response'; // e.g., CreateCustomerPaymentProfileResponse
        String respMockName = this.getRequestType() + 'MockResponse'; //e.g., CreateCustomerPaymentProfileMockResponse
        Type t = Type.forName(this.getRequestType());
        AuthorizeDotNetResponse resp = (AuthorizeDotNetResponse) t.newInstance();

        // Documentation's example of gettin and setting types, uses code from CreateCustomerPaymentProfileRequest - NOT WORKING
        /*
        CustomImplementation__c csResp = CustomImplementation__c.getInstance(this.getRequestType() + 'Response');
        CustomImplementation__c csMock = CustomImplementation__c.getInstance(this.getRequestType() + 'MockResponse');
        Type typeResp = Type.forName(csResp.className__c);
        Type typeMock = Type.forName(csMock.className__c);

        GetCustomerPaymentProfileResponse getResp = (GetCustomerPaymentProfileResponse)typeResp.newInstance();
        GetCustomerPaymentProfileMockResponse getResp = (GetCustomerPaymentProfileMockResponse)typeResp.newInstance();
        */
    }

    public GetCustomerPaymentProfileRequest(CustomerPaymentProfile profile, Boolean includeIssuerInfo) {
        this();
        
        this.customerProfileId = DEFAULT_PROFILE_ID;
        this.customerPaymentProfileId = profile.getCustomerPaymentProfileId();
        this.includeIssuerInfo = includeIssuerInfo;
        this.requestType = 'GetCustomerPaymentProfile';
        this.body = JSON.serialize(getBody());

        String respTypeName = this.getRequestType() + 'Response'; // e.g., CreateCustomerPaymentProfileResponse
        String respMockName = this.getRequestType() + 'MockResponse'; //e.g., CreateCustomerPaymentProfileMockResponse
        Type t = Type.forName(this.getRequestType());
        AuthorizeDotNetResponse resp = (AuthorizeDotNetResponse) t.newInstance();
    }
    /*
    public override String getBody() {
        List<String> reqBody = new String[]{'{"customerProfileId": "' + '123445' + '", "customerPaymentProfileId": "' + '838347374774' + '"'};
        if (this.includeIssuerInfo)
            reqBody.add(', "includeIssuerInfo:" "' + 'Mhmm' +'"}');
        else
            reqBody.add('}');
        //Boolean temp = this.includeIssuerInfo ? reqBody.add(', "includeIssuerInfo:" "' + 'Mhmm' +'"}') : reqBody.add('}');
        return String.join(reqBody, '');
    }
    */
}