@isTest 
public with sharing class DeleteCustomerPaymentProfileTest {

    public static final String DEFAULT_CUSTOMER_PROFILE_ID = '905372692';

    public DeleteCustomerPaymentProfileTest() {

    }
    @isTest static void makeDeleteCustomerPaymentProfileRequestTest(){
        
        String customerProfileId= '905372692';
        GetCustomerProfileRequest req = new GetCustomerProfileRequest(customerProfileId);

        String s = req.getBody();

        System.debug(s);

        System.assert(s.contains('getCustomerProfileRequest'), 'the string should contain the string getCustomerProfileRequest');

    }
    @isTest static void deserializeGetCustomerProfileResponse(){
    String respBodyString = AuthorizeDotNetServiceMock.sampleGetCustomerProfileRespBody();
    
    String responseType = 'GetCustomerProfileResponse';
    System.Type t = Type.forName(responseType);

    //AuthorizeDotNetResponse resp = (AuthorizeDotNetResponse)JSON.deserialize(respBodyString, t);
    GetCustomerProfileResponse resp = (GetCustomerProfileResponse)JSON.deserialize(respBodyString, GetCustomerProfileResponse.class);
    System.assert(resp!=null, 'response should not be null');
  
    CustomerProfile profile = resp.getProfile();

    //System.debug(profile);
    System.Assert(profile!=null);
    Messages messages = resp.getMessages();

    List<Message> mList = messages.getMessage();
    System.Assert(mList.size()==1);

    Message m1 = messages.getFirstMessage();

    system.debug(messages.getResultCode());
    System.assertEquals('Ok', messages.getResultCode(), 'ResultCode should be  Ok');

    System.assertEquals(true, resp.success(), 'Success method should return true');

    List<CustomerPaymentProfile> profiles = profile.getPaymentProfiles();
    System.assertEquals(5, profiles.size(), 'Sample json has 5 paymentprofiles');

    CustomerPaymentProfile p1 = profiles[0];
    System.assertEquals('905264257', p1.getCustomerPaymentProfileId(), 'The payment profile id should match 905264257');
    
    Payment payment1 = p1.getPayment();
    //CreditCard card1 = payment1.getCreditCard();


    Address billTo1 = p1.getBillTo();
    System.assertEquals('97402', billTo1.getZip(), 'The zip code should be 97402');
    }
    /*
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

        
    }*/
}