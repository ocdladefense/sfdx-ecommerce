public with sharing class DeleteCustomerShippingAddressMockResp extends AuthorizeDotNetResponse implements IMockResponse{
    public DeleteCustomerShippingAddressMockResp() {

    }

    public override string getBody(){
        String result = '{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;
        return result;
    }
}