public with sharing class DeleteCustomerProfileMockResponse {
    public DeleteCustomerProfileMockResponse() {

    }


    public override string getBody(){
        String result = '{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;

        return result;
    }
}