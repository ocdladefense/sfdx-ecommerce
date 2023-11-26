public with sharing class GetCustomerShippingAddressMockResp extends AuthorizeDotNetResponse implements IMockResponse{
    public GetCustomerShippingAddressMockResp() {

    }

    public override string getBody(){

        return '{"address":{"customerAddressId":"37457091","firstName":"China","lastName":"Bayles","company":"Thyme for Tea","address":"12 Main Street","city":"Pecan Springs","state":"TX","zip":"44628","country":"US"},"subscriptionIds":["3078184"],"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;
    }
}