public class UpdateCustomerShippingAddressRequest extends AuthorizeDotNetRequest {
    
    private String customerProfileId;

    private Address address;

    private Boolean defaultShippingAddress = false;
    
    public UpdateCustomerShippingAddressRequest() {
        super('updateCustomerShippingAddress');
        this.fields = new Set <String> {
            'customerProfileId', 'address', 'defaultShippingAddress'
        };
    }

    public UpdateCustomerShippingAddressRequest(Address address) {
      this();
      this.address=address;
    }

        
    public override Map<String,Object> toMap() {
        Map<String,Object> theMap = new Map<String,Object>();
        theMap.put('address', this.address);
        theMap.put('customerProfileId', this.customerProfileId);
        theMap.put('defaultShippingAddress', this.defaultShippingAddress);

        return theMap;
    }


    public override Set<String> keySet() {
        return new Set<String>{ 'customerProfileId', 'address', 'defaultShippingAddress'};
    }
    
    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }

    public void setAddress(Address address){
        this.address=address;
    }

    public void setDefaultShippingAddress(Boolean defaultShippingAddress) {
        this.defaultShippingAddress = defaultShippingAddress;
    }
    
    public String getCustomerProfileId() {
        return this.customerProfileId;
    }

    public Address getAddress(){
        return this.address;
    }

    public Boolean getDefaultShippingAddress() {
        return this.defaultShippingAddress;
    }
}