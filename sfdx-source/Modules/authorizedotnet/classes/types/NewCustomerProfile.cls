public class NewCustomerProfile extends AuthorizeDotNetType {

    //for making create customer profile request
    //public List<CustomerPaymentProfile> paymentProfiles;

    //instead of a list have one customerPaymentProfile only 
    //payment profile is required for authorizedotnet
    public CustomerPaymentProfile paymentProfiles;
    public String profileType;

    public String customerProfileId;

    public String merchantCustomerId;

    public String description;

    public String email;

    //instead of a list have one shipping address only 
    //public List<AuthNetAddress> shipToList;
    public AuthNetAddress shipToList;
    

    
    public NewCustomerProfile() {
        super();
    }

    public NewCustomerProfile (String customerProfileId){
        this();
        this.customerProfileId = customerProfileId;
    }

    public NewCustomerProfile (CustomerPaymentProfile theProfile){
        this();
        this.paymentProfiles = theProfile;
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
        System.debug('CALLING TO MAP on profile itself');
        Map<String,Object> tmp = new Map<String,Object>();
        tmp.put('merchantCustomerId', this.merchantCustomerId );
        tmp.put('description', this.description);
        tmp.put('email', this.email);
        tmp.put('paymentProfiles', this.paymentProfiles);
        tmp.put('customerProfileId', this.customerProfileId);
        tmp.put('shipToList', this.shipToList);
        
    
        if(this.shipToList == null){
            this.ignoreField('shipToList');
        }

        if(this.paymentProfiles== null){
            throw new AuthorizeDotNetException ('new profile must include a customer payment profile');
        }
        
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

    public CustomerPaymentProfile getPaymentProfiles(){
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

    public void setPaymentProfiles(CustomerPaymentProfile paymentProfiles) {
        this.paymentProfiles = paymentProfiles;
    }

    public AuthNetAddress getShipToList(){
        return this.shipToList;
    }

    public void setShipToList(AuthNetAddress shipToList) {
        this.shipToList = shipToList;
    }
    
}