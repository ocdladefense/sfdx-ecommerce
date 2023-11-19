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
        this = (GetCustomerShippingAddressResponse)JSON.deserialize(this.getBody(), GetCustomerPaymentProfileResponse.class);
        //this.address = (Address)JSON.deserialize(this.getBody(), Address.class);
        Map<String, Object> theMap = (Map<String, Object>) JSON.deserializeUntyped(this.getBody());
  
        //Address theAddress = (Address)theMap.get('address');
        Object obj = this.getObject('address');
        System.debug(obj);

        Map<String, String> anotherMap = (Map<String, String>)theMap.get('address');
        System.debug(anotherMap);

        //this.address = (Address)anotherMap;

        //i think the parser is the only thing to do - or do it manually through the field list on address
      
        //this.address= (Address)obj.get('address');
        //this.subscriptionIds= (List<String>)JSON.deserialize(this.getBody(), List<String>.class);
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