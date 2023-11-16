public class CreateCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    
    private CustomerPaymentProfile profile;

    private String customerProfileId;


    public CreateCustomerPaymentProfileRequest() {
        super('createCustomerPaymentProfileRequest');
        this.fields = new Set<String>{'customerProfileId', 'profile'};
    }

    public CreateCustomerPaymentProfileRequest(CustomerPaymentProfile profile) {
        this();
        this.profile = profile;
        this.requestType = 'createCustomerPaymentProfile';
    }


    public override Map<String,Object> toMap() {
        Map<String,Object> tmp = new Map<String,Object>();
        tmp.put('profile', this.profile);
        tmp.put('customerProfileId', this.customerProfileId);

        return tmp;
    }

}