public class DeleteCustomerProfileMock extends AuthorizeDotNetResponse implements IMockResponse {
    public DeleteCustomerProfileMock() {

    }


    public override string getBody(){
        String result = '{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;

        return result;
    }
}