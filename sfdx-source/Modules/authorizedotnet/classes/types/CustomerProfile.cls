public class CustomerProfile extends AuthorizeDotNetType {

    

    public String customerProfileId;

    public String merchantCustomerId;

    public String profileType = 'individual';

    public String description;

    public String email;

    public List<CustomerPaymentProfile> paymentProfiles;

    public List<AuthNetAddress> shipToList;

    public static final String CUSTOMER_TYPE_INDIVIDUAL = 'individual';

    public static final String CUSTOMER_TYPE_BUSINESS = 'business';
    


    public void setCustomerType(String profileType) {
        if(profileType == CUSTOMER_TYPE_INDIVIDUAL  ||  profileType == CUSTOMER_TYPE_BUSINESS){
            this.profileType = profileType;
        }
        else {
            throw new AuthorizeDotNetException ('ProfileType must be individual or business.');
        }
    }


    public CustomerProfile() {
        super();
    }


    public CustomerProfile(String customerProfileId){
        this();
        this.customerProfileId = customerProfileId;
    }


    public override String getPrimaryKeyField() {
        return 'customerProfileId';
    }


    public override String getPrimaryKeyValue() {
        return this.customerProfileId;
    }


    public override Set<String> keySet() {
        return new Set<String> {
            'merchantCustomerId', 'description', 'email', 'paymentProfiles', 'customerProfileId', 'shipToList'
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
    
        if(this.shipToList == null) {
            this.ignoreField('shipToList');
        }

        if(this.paymentProfiles == null) {
            this.ignoreField('paymentProfiles');
        }
        
    
        return tmp;
    }


    public String getProfileType() {
        return this.profileType;
    }


    public String getCustomerProfileId() {
        return this.customerProfileId;
    }


    public String getMerchantCustomerId() {
        return this.merchantCustomerId;
    }


    public String getEmail() {
        return this.email;
    }


    public String getDescription() {
        return this.description;
    }


    public List<CustomerPaymentProfile> getPaymentProfiles() {
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


    public List<AuthNetAddress> getShipToList() {
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


    //methods to add a single object to a list on the profile

    public void addToPaymentProfiles(CustomerPaymentProfile paymentProfile){
        if(this.paymentProfiles == null){
            this.paymentProfiles = new List<CustomerPaymentProfile>();
        }
        this.paymentProfiles.add(paymentProfile);
    }


    public void addToShipToList(AuthNetAddress theAddress) {
        if(this.shipToList == null){
            this.shipToList = new List<AuthNetAddress>();
        }
        this.shipToList.add(theAddress);
    }
    

    // @TODO - not implemented.
    public CustomerPaymentProfileCollection getPaymentProfileCollection() {
        return null;
    }


    // Collection is a wrapper class for us to do things like get the default shipping address.
    public AuthNetAddressCollection getShipToCollection() {
      
        if(this.shipToList == null || this.shipToList.size() < 1) {
            return new AuthNetAddressCollection();
        }

        AuthNetAddress theDefaultAddress = this.getDefaultShippingAddressFromList();

        for(AuthNetAddress address : this.shipToList) {
            if(address.getCustomerAddressId() == theDefaultAddress.getCustomerAddressId())
            {
                address.setDefaultShippingAddress(true);
            }
        }

		// Null/empty list was handled above.  Here we assume we have at least one address to deal with.
        return new AuthNetAddressCollection(this.shipToList);
    }

    

    public AuthNetAddress getDefaultShippingAddressFromList() {
     
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

  
        
        if(null == this.shipToList || this.shipToList.size() < 1) {
            return null;
        }

        for(AuthNetAddress address : this.shipToList)
        {
            System.debug('requesting '+ address.getCustomerAddressId());

            GetCustomerShippingAddressRequest req = new GetCustomerShippingAddressRequest();
            req.setCustomerAddressId(address.getCustomerAddressId());
            req.setCustomerProfileId(this.customerProfileId);

            GetCustomerShippingAddressResponse resp = (GetCustomerShippingAddressResponse)client.send(req);
            System.debug(address.getFirstName() + ' is default? ' + resp.getDefaultShippingAddress());

            if(resp.getDefaultShippingAddress()) {
                return address;
            }
        }

        return null;
    }


}