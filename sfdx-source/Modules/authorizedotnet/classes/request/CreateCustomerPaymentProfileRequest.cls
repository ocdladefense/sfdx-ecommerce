public class CreateCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    
    private CustomerPaymentProfile paymentProfile;

    private String customerProfileId;


    public CreateCustomerPaymentProfileRequest() {
        super('createCustomerPaymentProfile');
        this.fields = new Set<String>{'customerProfileId', 'paymentProfile'};
    }

    public CreateCustomerPaymentProfileRequest(CustomerPaymentProfile paymentProfile) {
        this();
        this.paymentProfile = paymentProfile;
    }

    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }

    public void setPaymentProfile(CustomerPaymentProfile paymentProfile) {
        this.paymentProfile = paymentProfile;
    }

    public override Map<String,Object> toMap() {
        Map<String,Object> tmp = new Map<String,Object>();
        tmp.put('customerProfileId', this.customerProfileId);
        tmp.put('paymentProfile', this.paymentProfile);

        return tmp;
    }

}