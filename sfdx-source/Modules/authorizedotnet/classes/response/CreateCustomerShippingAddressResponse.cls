public class CreateCustomerShippingAddressResponse extends AuthorizeDotNetResponse{

    private String customerAddressId;

    public CreateCustomerShippingAddressResponse() {
        super();
    }

    public CreateCustomerShippingAddressResponse(String theBody) {
        super(theBody);
    }

    public override void deserialize(){
        System.debug('deserialize in shipping response class');
        super.deserialize();
        this.customerAddressId = (String)JSON.deserialize(this.getBody(), String.class);
    }

    public void setCustomerAddressId(String customerAddressId){
        this.customerAddressId=customerAddressId;
    }

    public String getCustomerAddressId(){
        return this.customerAddressId;
    }
}