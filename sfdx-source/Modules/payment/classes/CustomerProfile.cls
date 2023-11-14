public class CustomerProfile {
    public List<CustomerPaymentProfile> paymentProfiles;
    public String profileType;
    public String customerProfileId;
    public String merchantCustomerId;
    public String description;
    public String email;
    
    public CustomerProfile() {

    }

    public String getProfileType(){
        return this.profileType;
    }

    public String getCustomerProfileId(){
        return this.customerProfileId;
    }

    public String getMerchantCustomerId(){
        return this.merchantCustomerId;
    }

    public String getEmail(){
        return this.email;
    }

    public String getDescription(){
        return this.description;
    }

    public List<CustomerPaymentProfile> getPaymentProfiles(){
        return this.paymentProfiles;
    }
    

}