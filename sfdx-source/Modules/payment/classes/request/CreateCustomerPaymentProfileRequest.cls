public class CreateCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    
    private CustomerPaymentProfile paymentProfile;

    private String customerProfileId;


    public CreateCustomerPaymentProfileRequest() {
        super('createCustomerPaymentProfileRequest');
        this.fields = new Set<String>{'customerProfileId', 'paymentProfile'};
    }

    public CreateCustomerPaymentProfileRequest(CustomerPaymentProfile paymentProfile) {
        this();
        this.paymentProfile = paymentProfile;
        this.requestType = 'createCustomerPaymentProfile';
    }

    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }


    public override Map<String,Object> toMap() {
        Map<String,Object> tmp = new Map<String,Object>();
        tmp.put('paymentProfile', this.paymentProfile);
        tmp.put('customerProfileId', this.customerProfileId);

        return tmp;
    }

}