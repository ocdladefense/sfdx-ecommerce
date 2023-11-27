public with sharing class UpdateCustomerShippingAddressMockResp extends AuthorizeDotNetResponse implements IMockResponse{
    public UpdateCustomerShippingAddressMockResp() {

    }

    public override string getBody(){
        String result = '{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;

        return result;
    }
}