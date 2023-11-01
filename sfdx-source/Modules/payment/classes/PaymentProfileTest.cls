@isTest
public class PaymentProfileTest {
    @isTest
    static void testCreateCustomerPaymentProfile() {
        Test.startTest();
        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();

        Test.setMock(HttpCalloutMock.class, mock);
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();
        
        String customerProfileId= '905372692';
        CreditCard card = new CreditCard('1234567890', Date.newInstance(2026, 8, 1));
        Address billToAddress = new Address('mara', 'williams', 'blah 123', 'eugene', 'oregon', '97454');
        CustomerPaymentProfile profile = new CustomerPaymentProfile(card, billToAddress);
        CreateCustomerPaymentProfileRequest req = new CreateCustomerPaymentProfileRequest(profile);
        // pass as an instance of UpdateCustomerPaymentProfileRequest class
        CreateCustomerPaymentProfileResponse resp = (CreateCustomerPaymentProfileResponse)client.send(req);

        Test.stopTest();
    }
}