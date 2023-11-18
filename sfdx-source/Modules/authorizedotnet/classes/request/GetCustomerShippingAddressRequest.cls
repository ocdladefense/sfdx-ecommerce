public class GetCustomerShippingAddressRequest extends AuthorizeDotNetRequest{
    
    private String customerProfileId;

    private String customerAddressId;

    //no complex types in request - no need to override toMap
    
    public GetCustomerShippingAddressRequest() {
        super('getCustomerShippingAddressRequest');
        this.fields = new Set<String>{
            'customerProfileId', 'customerAddressId'
        };
    }


    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }

    public void setCustomerAddressId(String customerAddressId) {
        this.customerAddressId = customerAddressId;
    }

    public String getCustomerProfileId() {
        return this.customerProfileId;
    }

    public String getCustomerAddressId(){
        return this.customerAddressId;
    }

    //add to map to throw exception when cutomerProfileId or customerAddressId are null
}