@isTest
public class UpdateCustomerShippingAddressMock extends AuthorizeDotNetResponse implements IMockResponse{
    public UpdateCustomerShippingAddressMock() {

    }

    public override string getBody(){
        String result = '{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;

        return result;
    }
}