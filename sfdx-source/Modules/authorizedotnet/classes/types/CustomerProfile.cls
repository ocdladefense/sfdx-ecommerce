public class CustomerProfile extends AuthorizeDotNetType {
    public List<CustomerPaymentProfile> paymentProfiles;
    public String profileType;
    public String customerProfileId;
    public String merchantCustomerId;
    public String description;
    public String email;
    public List<Address> shipToList;
    
    public CustomerProfile() {}

    public CustomerProfile(CustomerPaymentProfile paymentprofile) {
        this.paymentProfiles = new List<CustomerPaymentProfile>();
        this.paymentProfiles.add(paymentprofile);
    }

    public override String getPrimaryKeyField() {
        return 'customerProfileId';
    }

    public override String getPrimaryKeyValue() {
        return this.customerProfileId;
    }

    public override Set<String> keySet() {
        return new Set<String> {
            'merchantCustomerId', 'description', 'email', 'paymentProfiles','customerProfileId', 'shipToList'
        };
    }

    public override Map<String,Object> toMap() {
        Map<String,Object> tmp = new Map<String,Object>();
        tmp.put('merchantCustomerId', this.merchantCustomerId );
        tmp.put('description', this.description);
        tmp.put('email', this.email);
        tmp.put('paymentProfiles', this.paymentProfiles);
        tmp.put('customerProfileId', this.customerProfileId);
        tmp.put('shipToList', this.shipToList);
    
        return tmp;
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
        if(this.paymentProfiles == null){
            this.paymentProfiles = new List<CustomerPaymentProfile>();
        }
        return this.paymentProfiles;
    }
    
    public void setProfileType(String profileType) {
        this.profileType = profileType;
    }

    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }
    
    public void setMerchantCustomerId(String merchantCustomerId) {
        this.merchantCustomerId = merchantCustomerId;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPaymentProfiles(List<CustomerPaymentProfile> paymentProfiles) {
        this.paymentProfiles = paymentProfiles;
    }
    public void addToPaymentProfiles(CustomerPaymentProfile paymentProfile){
        if(this.paymentProfiles == null){
            this.paymentProfiles = new List<CustomerPaymentProfile>();
        }
        this.paymentProfiles.add(paymentProfile);
    }
    public List<Address> getShipToList(){
        return this.shipToList;
    }

    public void setShipToList(List<Address> shipToList) {
        this.shipToList = shipToList;
    }
}