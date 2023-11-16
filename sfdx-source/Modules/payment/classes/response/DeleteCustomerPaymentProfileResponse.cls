public class DeleteCustomerPaymentProfileResponse extends AuthorizeDotNetResponse{


    public DeleteCustomerPaymentProfileResponse() {
        super();
    }
    //delete response only contains messages which are deserialized in AuthorizeDotNetResponse class
    public DeleteCustomerPaymentProfileResponse(String theBody) {
        super(theBody);
    }

    public override void deserialize(){
        super.deserialize();
    }


}