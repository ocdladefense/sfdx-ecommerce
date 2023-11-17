public class CreateCustomerShippingAddressRequest extends AuthorizeDotNetRequest {
    
    private String customerProfileId;


    private Address address;


    private Boolean defaultShippingAddress = false;


        
    public CreateCustomerShippingAddressRequest() {
        super('createCustomerShippingAddress');
        this.fields = new Set<String>{'customerProfileId', 'address', 'defaultShippingAddress'};
    }

    public CreateCustomerShippingAddressRequest(Address address) {
        this();
        this.address = address;
    }






    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public void setDefaultShippingAddress(Boolean defaultShippingAddress) {
        this.defaultShippingAddress = defaultShippingAddress;
    }

    public String getCustomerProfileId() {
        return this.customerProfileId;
    }

    public Address getAddress() {
        return this.address;
    }

    public Boolean getDefaultShippingAddress() {
        return this.defaultShippingAddress;
    }

    public override Map<String,Object> toMap() {
        Map<String,Object> theMap = new Map<String,Object>();
        theMap.put('address', this.address);
        theMap.put('customerProfileId', this.customerProfileId);
        theMap.put('defaultShippingAddress', this.defaultShippingAddress);

        return theMap;
    }
}