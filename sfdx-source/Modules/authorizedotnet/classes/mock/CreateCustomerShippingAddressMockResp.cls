public with sharing class CreateCustomerShippingAddressMockResp extends AuthorizeDotNetResponse implements IMockResponse{
    public CreateCustomerShippingAddressMockResp() {

    }

    public override String getBody(){
        return '{"customerAddressId":"126406","messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;
    }
}