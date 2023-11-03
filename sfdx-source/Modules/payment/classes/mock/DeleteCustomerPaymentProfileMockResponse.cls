public class DeleteCustomerPaymentProfileMockResponse extends AuthorizeDotNetResponse implements IMockResponse{
    
    public DeleteCustomerPaymentProfileMockResponse() {
        super();
    }
    public override String getBody() {
        return'{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}';
    }

    public static String okDeletePaymentProfileResponseBody(){
        return'{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}';
    }

    public static String errorDeletePaymentProfileResponseBody(){
        return'{"messages":{"resultCode":"Error","message":[{"code":"E00105","text":"The specified payment profile is associated with an active or suspended subscription and cannot be deleted"}]}}';
    }
}