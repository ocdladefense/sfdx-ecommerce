
@isTest 
public with sharing class DeleteCustomerPaymentProfileTest {
    public DeleteCustomerPaymentProfileTest() {

    }

    @isTest static void testDeletePaymentProfileSuccess(){
        Test.startTest();
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        Test.setMock(HttpCalloutMock.class, client);
        //id of customer
        String customerProfileId= '905372692';
        //id of payment profile to delete
        Integer customerPaymentProfileId =905264262;
       
        CustomerPaymentProfile profile = AuthorizeDotNetMockResponse.sampleCustomerPaymentProfile();

        //make request or call the method held in payment profile class

        //wrote instance method in CustomerPaymentProfile that makes request message, sends, and parses the response
        //returns a string result code

        DeleteCustomerPaymentProfileRequest req = new DeleteCustomerPaymentProfileRequest(profile, customerProfileId);
        //DeletePaymentProfileRequest has a requestType
        //when testing set this value before calling send 
        req.setRequestType(PaymentGatewayRequestType.DELETE_CUSTOMER_PAYMENT_PROFILE_SUCCESS);
        HttpResponseMessage resp = client.send(req);
        Test.stopTest();

        String body = resp.getBody();

        //check the contents of the message for ok
        AuthorizeDotNetResponse message = new AuthorizeDotNetResponse(body);
        String resultCode = message.getResultCode();

        System.assertEquals('Ok', resultCode, 'Result code should be ok');
        
    }

    @isTest static void testDeletePaymentProfileClassMethodSuccess(){
        Test.startTest();
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        Test.setMock(HttpCalloutMock.class, client);
        //id of customer
        String customerProfileId= '905372692';
        //id of payment profile to delete - will be found in list of sample profiles
        Integer customerPaymentProfileId =905264262;
       
        CustomerPaymentProfile profile = AuthorizeDotNetMockResponse.sampleCustomerPaymentProfile();
        profile.setCustomerPaymentProfileId(customerPaymentProfileId);
        //wrote instance method in CustomerPaymentProfile that makes request message, sends, and parses the response
        //if a test is running, it will call a method to add a request type
        //returns a string result code

        String resultCode = profile.deleteCustomerPaymentProfile(customerProfileId);

        Test.stopTest();

        //check the contents of the message for ok

        System.assertEquals('Ok', resultCode, 'Result code should be ok');
        
    }
    @isTest static void testDeletePaymentProfileClassMethodError(){
        Test.startTest();
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        Test.setMock(HttpCalloutMock.class, client);
        //id of customer
        String customerProfileId= '905372692';
        //id of payment profile to delete - will not be found in list of sample ids
        Integer customerPaymentProfileId = 111264262;
       
        CustomerPaymentProfile profile = AuthorizeDotNetMockResponse.sampleCustomerPaymentProfile();
        //reset the value so when the method calls addRequestTypeForTest on a DeleteCustomerPaymentRequest it sets the type to error
        profile.setCustomerPaymentProfileId(customerPaymentProfileId);
        
        //call the method held in payment profile class
        String resultCode = profile.deleteCustomerPaymentProfile(customerProfileId);

        Test.stopTest();

        System.assertEquals('Error', resultCode, 'Result code should be error');
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