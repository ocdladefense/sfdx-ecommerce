public class UpdateCustomerShippingAddressRequest extends AuthorizeDotNetRequest {
    
    private String customerProfileId;

    private Address address;
    
    public UpdateCustomerShippingAddressRequest() {
        super('updateCustomerShippingAddress');
        this.fields = new Set <String> {
            'customerProfileId', 'address'
        };
    }

    
    public override Map<String,Object> toMap() {
        Map<String,Object> theMap = new Map<String,Object>();
        theMap.put('address', this.address);
        theMap.put('customerProfileId', this.customerProfileId);

        return theMap;
    }

    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }

    public void setAddress(Address address){
        this.address=address;
    }
    public String getCustomerProfileId() {
        return this.customerProfileId;
    }

    public Address getAddress(){
        return this.address;
    }
}