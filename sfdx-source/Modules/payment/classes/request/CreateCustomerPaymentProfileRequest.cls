public class CreateCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    private String customerProfileId;
    private CustomerPaymentProfile profile;

    public CreateCustomerPaymentProfileRequest() {
        super();
    }

    public CreateCustomerPaymentProfileRequest(CustomerPaymentProfile profile) {
        this();
        this.profile = profile;
        this.requestType = 'createCustomerPaymentProfile';
    }

    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }


}