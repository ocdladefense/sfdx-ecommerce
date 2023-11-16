public class UpdateCustomerShippingAddressRequest extends AuthorizeDotNetRequest {
    
    private String customerProfileId;

    private Address address;
    
    public UpdateCustomerShippingAddressRequest() {

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