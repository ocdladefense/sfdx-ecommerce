public class UpdateCustomerProfileMock extends AuthorizeDotNetResponse implements IMockResponse {
    public UpdateCustomerProfileMock() {

    }


    public override string getBody(){
        String result = '{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;

        return result;
    }
}