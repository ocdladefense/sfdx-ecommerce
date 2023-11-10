@isTest 
public with sharing class DeleteCustomerPaymentProfileTest {

    public static final String DEFAULT_CUSTOMER_PROFILE_ID = '905372692';

    public DeleteCustomerPaymentProfileTest() {

    }
    
    @isTest static void prependTest(){
        Test.startTest();
        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();

        Test.setMock(HttpCalloutMock.class, mock);
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        String customerProfileId= DEFAULT_CUSTOMER_PROFILE_ID;
        CustomerPaymentProfile profile = DeleteCustomerPaymentProfileMockResponse.sampleCustomerPaymentProfile();
        profile.setCustomerProfileId(customerProfileId);

        DeleteCustomerPaymentProfileRequest req = new DeleteCustomerPaymentProfileRequest(profile);

        //from send in AuthorizeDotNetClient

        String xRequestType = req.getRequestType();
        String payloadRequestType = xRequestType.uncapitalize();
        payloadRequestType += 'Request';

        Map<String, String> MERCHANT_AUTHENTICATION = new Map<String, String>{ 
            'name'=> '6gSVxaYj397',
            'transactionKey'=> '6FR49pDH5Jjum58g'
        };
        req.prependBody('merchantAuthentication', MERCHANT_AUTHENTICATION);
        
        req.wrapBody(payloadRequestType);
        req.setEndpoint('https://apitest.authorize.net/xml/v1/request.api');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('X-Request-Type', xRequestType);

        Test.stopTest();

        System.assertEquals('POST', req.getMethod(), 'method should be post');
    }

    @isTest static void testDeletePaymentProfileSuccess(){
        Test.startTest();
        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();

        Test.setMock(HttpCalloutMock.class, mock);
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        //id of customer
        String customerProfileId= DEFAULT_CUSTOMER_PROFILE_ID;
        CustomerPaymentProfile profile = DeleteCustomerPaymentProfileMockResponse.sampleCustomerPaymentProfile();
        profile.setCustomerProfileId(customerProfileId);

        //make request or call the method held in payment profile class

        DeleteCustomerPaymentProfileRequest req = new DeleteCustomerPaymentProfileRequest(profile);
        //test to see if the request native object has two kvp?
        
        DeleteCustomerPaymentProfileResponse resp = (DeleteCustomerPaymentProfileResponse)client.send(req);
        //test to see if the wrap method worked? i.e. that the first key is the right request type

        Test.stopTest();
        
        System.assertEquals(true, resp.success(), 'the success method should return true');
      
        
    }
    @isTest static void testDeletePaymentProfileFailure(){
        Test.startTest();
        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();

        Test.setMock(HttpCalloutMock.class, mock);
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        //id of customer
        String customerProfileId= DEFAULT_CUSTOMER_PROFILE_ID;
        CustomerPaymentProfile profile = DeleteCustomerPaymentProfileMockResponse.sampleCustomerPaymentProfile();
        profile.setCustomerProfileId(customerProfileId);
        profile.setCustomerPaymentProfileId('xxxxxxxx');

        //make request or call the method held in payment profile class

        DeleteCustomerPaymentProfileRequest req = new DeleteCustomerPaymentProfileRequest(profile);
        
        DeleteCustomerPaymentProfileResponse resp = (DeleteCustomerPaymentProfileResponse)client.send(req);

        Test.stopTest();

        String body = resp.getBody();
        
        System.assertEquals(false, resp.success(), 'the success method should return false');

        System.assertEquals('Error', resp.getResultCode());

        
    }
}