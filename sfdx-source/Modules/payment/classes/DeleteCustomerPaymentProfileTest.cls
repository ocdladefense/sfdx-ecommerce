public with sharing class DeleteCustomerPaymentProfileTest {
    public DeleteCustomerPaymentProfileTest() {

    }
    

    @isTest static void testDeletePaymentProfileSuccess(){
        Test.startTest();
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        Test.setMock(HttpCalloutMock.class, client);

        String customerProfileId= '905372692';
        //profileid to delete
        
        //make request or call the method held in payment profile class
        DeleteCustomerPaymentProfileRequest req = new DeleteCustomerPaymentProfileRequest(profile);

        HttpResponseMessage resp = client.send(req);
        Test.stopTest();

        String body = resp.getBody();

        //check the contents of the message for ok
        AuthorizeDotNetResponse message = new AuthorizeDotNetClient(body);
        String resultCode = message.getResultCode();
        
    }


    @isTest static void testDeletePaymentProfileError(){

    }


    /**Pattern for test
     *        Test.startTest();
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        Test.setMock(HttpCalloutMock.class, client);

        String customerProfileId= '905372692';
        CreditCard card = new CreditCard('1234567890', Date.newInstance(2026, 8, 1));
        Address billToAddress = new Address('mara', 'williams', 'blah 123', 'eugene', 'oregon', '97454');
        CustomerPaymentProfile profile = new CustomerPaymentProfile(card, billToAddress);
        CreateCustomerPaymentProfileRequest req = new CreateCustomerPaymentProfileRequest(profile);

        HttpResponseMessage resp = client.send(req);

        Test.stopTest();
 */
}