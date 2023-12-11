public class UpdateCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {

    private String customerProfileId;

    public CustomerPaymentProfile paymentProfile;

    public String validationMode;

    
    

    public UpdateCustomerPaymentProfileRequest() {
        super('updateCustomerPaymentProfile');
        // testMode: Card data is validated using simple mathematical checks to confirm that it appears to be valid
        // this.validationMode = 'testMode';
    }

    public override Set<String> keySet() {
        return new Set<String>{'customerProfileId', 'paymentProfile'};
    }  


    // Might only need this constructor since billTo and payment are both in here
    public UpdateCustomerPaymentProfileRequest(CustomerPaymentProfile profile) {
        this();
        this.paymentProfile = profile;
    }
    
    
    // Overloaded constructor for if only the Address is changed
    public UpdateCustomerPaymentProfileRequest(CustomerPaymentProfile profile, AuthNetAddress newAddress) {
        this();
        this.paymentProfile = profile;
        this.paymentProfile.setBillTo(newAddress);
    }
    
    
    // Overloaded constructor for if only the CreditCard is changed
    public UpdateCustomerPaymentProfileRequest(CustomerPaymentProfile profile, CreditCard newCard) {
        this();
        this.paymentProfile = profile;
        this.paymentProfile.setCard(newCard);
    }

    // Overloaded constructor for if both Address and CreditCard are changed
    public UpdateCustomerPaymentProfileRequest(CustomerPaymentProfile profile, AuthNetAddress newAddress, CreditCard newCard) {
        this();
        this.paymentProfile = profile;
        this.paymentProfile.setBillTo(newAddress);
        this.paymentProfile.setCard(newCard);
    }

    
    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }

    public void setCustomerPaymentProfileId(String paymentProfileId) {
        this.paymentProfile.setCustomerPaymentProfileId(paymentProfileId);
    }

    public void setIsDefault(Boolean isDefault) {
        this.paymentProfile.setDefaultPaymentProfile(isDefault);
    }

    public override Map<String,Object> toMap() {
        Map<String,Object> tmp = new Map<String,Object>();
        tmp.put('customerProfileId', this.customerProfileId);
        tmp.put('paymentProfile', this.paymentProfile);
        if(this.validationMode != null) {
            tmp.put('validationMode', this.validationMode);
        }
          

        return tmp;
    }

}