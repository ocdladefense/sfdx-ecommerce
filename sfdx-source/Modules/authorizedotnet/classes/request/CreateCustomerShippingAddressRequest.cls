public class CreateCustomerShippingAddressRequest extends AuthorizeDotNetRequest {
    
    private String customerProfileId;


    private AuthNetAddress address;


    private Boolean defaultShippingAddress = false;


        
    public CreateCustomerShippingAddressRequest() {
        super('createCustomerShippingAddress');
        this.fields = new Set<String>{'customerProfileId', 'address', 'defaultShippingAddress'};
    }

    public CreateCustomerShippingAddressRequest(AuthNetAddress address) {
        this();
        this.address = address;
    }

    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }

    public void setAddress(AuthNetAddress address) {
        this.address = address;
    }

    public void setDefaultShippingAddress(Boolean defaultShippingAddress) {
        this.defaultShippingAddress = defaultShippingAddress;
    }

    public String getCustomerProfileId() {
        return this.customerProfileId;
    }

    public AuthNetAddress getAddress() {
        return this.address;
    }

    public Boolean getDefaultShippingAddress() {
        return this.defaultShippingAddress;
    }

    public override Map<String,Object> toMap() {
        if(this.defaultShippingAddress==null){
            this.defaultShippingAddress=false;
        }
        if(this.customerProfileId==null){
            throw new AuthorizeDotNetException('customerProfileId must not be null');
        }
        
        Map<String,Object> theMap = new Map<String,Object>();
        theMap.put('address', this.address);
        theMap.put('customerProfileId', this.customerProfileId);
        theMap.put('defaultShippingAddress', this.defaultShippingAddress);

        return theMap;
    }
}