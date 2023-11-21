public class DeleteCustomerShippingAddressResponse extends AuthorizeDotNetResponse{

    public DeleteCustomerShippingAddressResponse() {
        super();
    }

    public DeleteCustomerShippingAddressResponse(String theBody) {
        super(theBody);
    }

    //this response only returns messages
    public override void deserialize(){
        super.deserialize();
    }
}