public class UpdateCustomerShippingAddressResponse extends AuthorizeDotNetResponse {

    public UpdateCustomerShippingAddressResponse() {
        super();
    }

    public UpdateCustomerShippingAddressResponse(String theBody) {
        super(theBody);
    }

    //update shipping address only returns messages
    public override void deserialize(){
        super.deserialize();
    }
}