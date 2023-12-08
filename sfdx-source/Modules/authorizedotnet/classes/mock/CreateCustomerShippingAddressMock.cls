@isTest
public class CreateCustomerShippingAddressMock extends AuthorizeDotNetResponse implements IMockResponse{
    public CreateCustomerShippingAddressMock() {

    }

    public override String getBody(){
        return '{"customerAddressId":"126406","messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;
    }
}