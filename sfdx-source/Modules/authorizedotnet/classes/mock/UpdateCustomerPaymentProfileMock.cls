public class UpdateCustomerPaymentProfileMock extends AuthorizeDotNetResponse implements IMockResponse {
    public UpdateCustomerPaymentProfileMock() {

    }

    public override String getBody() {
        return '{"validationDirectResponse":"1,1,1,This transaction has been approved.,AWTJEY,Y,10587,none,Test transaction for ValidateCustomerPaymentProfile.,0.00,CC,auth_only,MerchantCustID,John,Doe,,123 Main St.,Bellevue,WA,98004,US,000-000-0000,,customer-profile-email@here.com,,,,,,,,,0.00,0.00,0.00,FALSE,none,1A1D8FCD4098962845C24E5B26A05052,P,2,,,,,,,,,,,XXXX1111,Visa,,,,,,,04UZKLYZMDFJQKWR5ID77NH,,,,,,,,,,","messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}';
    }
}