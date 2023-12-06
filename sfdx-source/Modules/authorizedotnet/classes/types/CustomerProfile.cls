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

    public AuthNetAddressCollection getShipToCollection() {
      
        if(this.shipToList == null){
            throw new AuthorizeDotNetException ('shipToList must not be null');
        }
        if(this.shipToList.size()>0){
            System.debug('about to find default');
            AuthNetAddress theDefaultAddress = this.getDefaultShippingAddressFromList();
            if(theDefaultAddress == null){
                System.debug('no default address found');
            }
            else{
                system.debug('about to set default address boolean in shipToList');
                for (AuthNetAddress address : this.shipToList){
                    if(address.getCustomerAddressId()==theDefaultAddress.getCustomerAddressId())
                    {
                        System.debug('setting');
                        address.setDefaultShippingAddress(true);
                    }
                }
            }
            
        }


        AuthNetAddressCollection collection = this.shipToList!=null? new AuthNetAddressCollection(this.shipToList): null;
        System.debug(collection.size() + 'addresses in collection');
        return collection;

        //should this method also call requestDefaultShippingAddress?
    }

    public AuthNetAddress getDefaultShippingAddressFromList(){
        System.debug('about to iterate');
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        Boolean isClientNull = client==null;
        if(isClientNull){
            throw new CheckoutException('AuthorizeDotNetClient must not be null');
        }
        
        if (this.shipToList.size()==0){
            System.debug('nothing in list');
        }
        else{
            System.debug('something in list');
        }
        for (AuthNetAddress address : this.shipToList)
        {
            System.debug('requesting '+ address.getCustomerAddressId());

            GetCustomerShippingAddressRequest req = new GetCustomerShippingAddressRequest();
            
            req.setCustomerAddressId(address.getCustomerAddressId());

            req.setCustomerProfileId(customerProfileId);

            GetCustomerShippingAddressResponse resp = (GetCustomerShippingAddressResponse)client.send(req);
            System.debug(address.getFirstName() + ' is default? ' + resp.getDefaultShippingAddress());
            if(resp.getDefaultShippingAddress()){
                //set it as well?
                System.debug('DEFAULT FOUND');
                return address;
            }
        }
        //not found
        return null;
    }


}