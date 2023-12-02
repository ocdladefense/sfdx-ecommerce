public class GetCustomerShippingAddressResponse extends AuthorizeDotNetResponse {

    private AuthNetAddress address;
    private Boolean defaultShippingAddress;
    private List<String> subscriptionIds;

    public GetCustomerShippingAddressResponse() {
        super();
    }

    public GetCustomerShippingAddressResponse(String theBody) {
        super(theBody);
    }

    public AuthNetAddress getAddress(){
        return this.address;
    }

    public Boolean getDefaultShippingAddress(){
        return this.defaultShippingAddress!=null && this.defaultShippingAddress==true;
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