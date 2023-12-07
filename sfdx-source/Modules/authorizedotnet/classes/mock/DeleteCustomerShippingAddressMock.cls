@isTest
public class DeleteCustomerShippingAddressMock extends AuthorizeDotNetResponse implements IMockResponse{
    public DeleteCustomerShippingAddressMock() {

    }

    public override string getBody(){
        String result = '{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;
        return result;
    }
}