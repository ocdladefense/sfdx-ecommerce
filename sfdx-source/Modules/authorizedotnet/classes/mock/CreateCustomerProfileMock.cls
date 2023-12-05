public class CreateCustomerProfileMock extends AuthorizeDotNetResponse implements IMockResponse{
    public CreateCustomerProfileMock() {

    }

    public override string getBody(){
        return '{"customerProfileId":"527262","customerPaymentProfileId":"87","validationDirectResponse":"1,1,1,This transaction has been approved.,AF94HU,Y,10586,none,Test transaction for ValidateCustomerPaymentProfile.,0.00,CC,auth_only,none,John,Doe,,123 Main St.,Bellevue,WA,98004,US,000-000-0000,,email@example.com,,,,,,,,,0.00,0.00,0.00,FALSE,none,76247385B849148C0C6E0C205A6BEFFA,P,2,,,,,,,,,,,XXXX1111,Visa,,,,,,,0TN1VE648DFCJSHQ81GZH9F,,,,,,,,,,","messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;
    }
}