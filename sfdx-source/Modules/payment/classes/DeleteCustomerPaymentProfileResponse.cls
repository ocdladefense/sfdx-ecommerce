public class DeleteCustomerPaymentProfileResponse extends AuthorizeDotNetResponse{

    //delete response only contains messages which are deserialized in AuthorizeDotNetResponse class
    public DeleteCustomerPaymentProfileResponse(String theBody) {
        super(theBody);
    }

    public override void deserialize(){
        super.deserialize();
    }

    //for testing anon code without making request first
    // public DeleteCustomerPaymentProfileResponse(String theBody) {
    //     this.body = theBody;
    // }

}