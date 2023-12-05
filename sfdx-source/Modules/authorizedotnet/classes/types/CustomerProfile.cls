public class CustomerProfile extends AuthorizeDotNetType {

    public List<CustomerPaymentProfile> paymentProfiles;

    public String profileType;

    public String customerProfileId;

    public String merchantCustomerId;

    public String description;

    public String email;

    public List<AuthNetAddress> shipToList;

    //collection or list
    
    public CustomerProfile() {}

    public CustomerProfile (String customerProfileId){
        this.customerProfileId = customerProfileId;
    }

    /*
    public CustomerProfile(CustomerPaymentProfile paymentprofile) {
        this.paymentProfiles = new List<CustomerPaymentProfile>();
        this.paymentProfiles.add(paymentprofile);
    }
    */

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

    public List<AuthNetAddress> getShipToList(){
        return this.shipToList;
    }

    public void setShipToList(List<AuthNetAddress> shipToList) {
        this.shipToList = shipToList;
    }

    public CustomerPaymentProfile getDefaultPaymentProfile() {
        for(CustomerPaymentProfile paymentProfile : this.paymentProfiles) {
            if(paymentProfile.getDefaultPaymentProfile()) {
                return paymentProfile;
            }
        }

        return null;
    }


    //return paymentprofile 
    public CustomerPaymentProfileCollection getPaymentProfileCollection(){
        return null;
    }

    public AuthNetAddressCollection getShipToCollection(String customerProfileId) {
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();
        //take shipToList and send it
        GetCustomerProfileRequest req = new GetCustomerProfileRequest();
        req.setCustomerProfileId(customerProfileId);
        //AuthorizeDotNetClient tempClient = new AuthorizeDotNetClient();
        Boolean isClientNull = client==null;
        if(isClientNull){
            throw new CheckoutException('AuthorizeDotNetClient must not be null');
        }
        GetCustomerProfileResponse resp = (GetCustomerProfileResponse) client.send(req);
        CustomerProfile profile = resp.getProfile();
        if(profile.getShipToList()==null){
            // ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'No saved addresses found. Please add an address.'));
            // return new Pagereference('/apex/AddShippingAddress');
            return null;

        }
        AuthNetAddressCollection collection = new AuthNetAddressCollection(profile.getShipToList());

        return collection;
    }

    public string getDefaultShippingAddressId(){

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        for (AuthNetAddress address : this.shipToList)
        {
            GetCustomerShippingAddressRequest req = new GetCustomerShippingAddressRequest();
        
            req.setCustomerAddressId(address.getCustomerAddressId());
            req.setCustomerProfileId(customerProfileId);
    
            Boolean isClientNull = client==null;
            if(isClientNull){
                throw new CheckoutException('AuthorizeDotNetClient must not be null');
            }
            
            GetCustomerShippingAddressResponse resp = (GetCustomerShippingAddressResponse)client.send(req);

            if(resp.success() && resp.getDefaultShippingAddress()){
                //set it as well?
                //address.setDefaultShipToAddress(true);
                return address.getCustomerAddressId();
            }
        }
        //not found
        return null;
    }

    public AuthNetAddress getDefaultShippingAddress() {
        
        String defaultCustomerAddressId = this.getDefaultShippingAddressId();
           

        for(AuthNetAddress address : this.shipToList) {
            if(address.getCustomerAddressId()==defaultCustomerAddressId) {
                return address;
            }
        }

        return null;
    }
}