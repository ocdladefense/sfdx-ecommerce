public with sharing class GetCustomerProfileMockResponse extends AuthorizeDotNetResponse implements IMockResponse {
    public GetCustomerProfileMockResponse() {

    }

    public override string getBody(){
        return '{"profile":{"paymentProfiles":[{"defaultPaymentProfile":true,"customerPaymentProfileId":"915877242","payment":{"creditCard":{"cardNumber":"XXXX1123","expirationDate":"2045-08"}},"billTo":{"firstName":"tester","lastName":"test","address":"asdf","city":"eugene","state":"OR","zip":"97454"}},{"customerPaymentProfileId":"915872876","payment":{"creditCard":{"cardNumber":"XXXX1112","expirationDate":"2045-08"}},"billTo":{"firstName":"asd","lastName":"Tester","address":"blah 123","city":"Springfield","state":"OR","zip":"97478"}},{"customerPaymentProfileId":"915753226","payment":{"creditCard":{"cardNumber":"XXXX1111","expirationDate":"2025-11","cardType":"Visa"}},"billTo":{"firstName":"Testy","lastName":"Tester","address":"blah 123","city":"Springfield","state":"OR","zip":"97477","country":"US"}}],"profileType":"regular","customerProfileId":"916263569","merchantCustomerId":"Merchant_Customer_ID","description":"Profile description here","email":"customer-profile-email@here.com"},"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;
    }
}