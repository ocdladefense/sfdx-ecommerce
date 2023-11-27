public class GetCustomerShippingAddressResponse extends AuthorizeDotNetResponse {

    private Address address;
    private List<String> subscriptionIds;

    public GetCustomerShippingAddressResponse() {
        super();
    }

    public GetCustomerShippingAddressResponse(String theBody) {
        super(theBody);
    }

    public override void deserialize(){
        super.deserialize();
        GetCustomerShippingAddressResponse resp = (GetCustomerShippingAddressResponse)JSON.deserialize(this.getBody(), GetCustomerShippingAddressResponse.class);
        this.address=resp.address;
        this.subscriptionIds=resp.subscriptionIds;
    }

    public Address getAddress(){
        return this.address;
    }

    public List<String> getSubscriptionIds(){
        return this.subscriptionIds;
    }

    // public void setAddress (Address address){
    //     this.address = address;
    // }

    // public void setSubscriptionIds(List<String> subscriptionIds){
    //     this.subscriptionIds=subscriptionIds;
    // }


}