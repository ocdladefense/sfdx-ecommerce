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

        // JSONParser parser = JSON.createParser(this.getBody());
        // while (parser.nextToken() != null) {
        //     //start the address object
        //     if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
        //         // Read entire address object
        //       Address address = (Address)parser.readValueAs(Address.class); 
        //       System.debug(address.getFirstName()); 
        //       String s = JSON.serialize(address);
        //         system.debug('Serialized address: ' + s);
        //     }

        // }
        this.address = (Address)JSON.deserialize(this.getBody(), Address.class);
        this.subscriptionIds= (List<String>)JSON.deserialize(this.getBody(), List<String>.class);
    }

    public Address getAddress(){
        return this.address;
    }

    public List<String> getSubscriptionIds(){
        return this.subscriptionIds;
    }

    public void setAddress (Address address){
        this.address = address;
    }

    public void setSubscriptionIds(List<String> subscriptionIds){
        this.subscriptionIds=subscriptionIds;
    }


}