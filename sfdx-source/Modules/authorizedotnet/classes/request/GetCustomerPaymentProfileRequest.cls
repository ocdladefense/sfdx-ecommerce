public class GetCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    public String customerProfileId;
    public String customerPaymentProfileId;
    public String DEFAULT_PROFILE_ID = '905372692';

    public GetCustomerPaymentProfileRequest() {
        super('getCustomerPaymentProfile');
    }

    public override Set<String> keySet() {
        return new Set<String>{'customerProfileId', 'customerPaymentProfileId'};
    }

    public override String getPrimaryKeyField() {
        return 'customerPaymentProfileId';
    }

    public override String getPrimaryKeyValue() {
        return this.customerPaymentProfileId;
    }

    public GetCustomerPaymentProfileRequest(CustomerPaymentProfile profile) {
        this();
        // We can now dynamically instantiate the AuthorizeDotNetResponse *and
        // the AuthorizeDotNetMockResponse.
        
        // Currently we have no way to get ProfileID so for now it's gonna be a CONST
        this.customerProfileId = DEFAULT_PROFILE_ID;
        this.customerPaymentProfileId = profile.getCustomerPaymentProfileId();
        this.requestType = 'getCustomerPaymentProfile';
        
    }

    

    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }

    public void setCustomerPaymentProfileId(String customerPaymentProfileId) {
        this.customerPaymentProfileId = customerPaymentProfileId;
    }


}