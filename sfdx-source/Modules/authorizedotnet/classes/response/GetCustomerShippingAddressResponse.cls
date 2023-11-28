public class GetCustomerShippingAddressResponse extends AuthorizeDotNetResponse {

    private Address address;
    private List<String> subscriptionIds;

    public GetCustomerShippingAddressResponse() {
        super();
    }

    public GetCustomerShippingAddressResponse(String theBody) {
        super(theBody);
    }

    public Address getAddress(){
        return this.address;
    }

    public List<String> getSubscriptionIds(){
        //possible
        return this.subscriptionIds;
    }

    // public void setAddress (Address address){
    //     this.address = address;
    // }

    // public void setSubscriptionIds(List<String> subscriptionIds){
    //     this.subscriptionIds=subscriptionIds;
    // }


}