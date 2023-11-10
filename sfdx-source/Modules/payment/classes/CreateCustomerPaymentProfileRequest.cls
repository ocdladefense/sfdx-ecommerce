public class CreateCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    private String customerProfileId;
    private CustomerPaymentProfile profile;

    public CreateCustomerPaymentProfileRequest() {
        super();
    }

    public CreateCustomerPaymentProfileRequest(CustomerPaymentProfile profile) {
        this();
        this.profile = profile;
        this.requestType = 'CreateCustomerPaymentProfile';
    }

    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }

    public override Map<String,Object> getBodyAsNativeObject() {
        Map<String,Object> obj = new Map<String,Object>();

        obj.put('customerProfileId', this.customerProfileId);
        obj.put('paymentProfile', this.profile);
        System.debug(obj);
        return obj;
    }
}