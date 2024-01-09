@isTest
public class CustomerProfileTest {
    public CustomerProfileTest() {

    }

    @isTest static void deserializeGetCustomerProfileResponse() {

        String customerprofileId='916263569';
        GetCustomerProfileRequest req = new GetCustomerProfileRequest();
        req.setCustomerProfileId(customerProfileId);

        string result = req.getBody();

        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();
        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, mock);
        }

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        GetCustomerProfileResponse resp = (GetCustomerProfileResponse)client.send(req);
        System.debug('23 resp.getBody()' + resp.getBody());
        resp.deserialize();
        System.debug('25 resp' + resp);
        CustomerProfile profile = resp.getProfile();
        

        System.debug(profile.getCustomerProfileId());
        System.assertEquals('916263569', profile.getCustomerProfileId());
        profile.setCustomerProfileId('12345');
        resp.setCustomerProfile(profile);
        profile = resp.getProfile();

        System.assertEquals('12345', profile.getCustomerProfileId());
        Boolean success = resp.success();
        //for mock
        System.assertEquals(true, success, 'success should return true');

    }

    @isTest static void getCustomerProfileRequestBody() {
        String customerProfileId='916263569';
        Boolean unmaskExpirationDate = true;

        GetCustomerProfileRequest req = new GetCustomerProfileRequest();
        req.setCustomerProfileId(customerProfileId);
        req.setUnmaskExpirationDate(unmaskExpirationDate);
        

        


        string result = req.getBody();
        system.debug(result);
        Boolean idPresent = result.contains('customerProfileId');

        System.assertEquals(true, idPresent, 'this request should have customerProfileId');
        System.assertEquals(req.getCustomerProfileId(), req.getCustomerProfileId());
        System.assertEquals(true, req.getUnmaskExpirationDate());

    }

    @isTest
    private static void createCustomerPaymentProfileRequestBodyForRef() {
               //variables
        AuthNetAddress address= new AuthNetAddress('Sebastian', 'Berna', '214 NW Monroe Ave', 'Corvallis', 'OR', '97330');
        CreditCard card = new CreditCard('4111111111111122','11/2024');
        Payment payment = new Payment();
        payment.setCreditCard(card);

        CustomerPaymentProfile paymentProfile = new CustomerPaymentProfile();
        paymentProfile.setBillTo(address);
        paymentProfile.setPayment(payment);
        paymentProfile.setCard(card);

        //request
        CreateCustomerPaymentProfileRequest req = new CreateCustomerPaymentProfileRequest();
        req.setPaymentProfile(paymentProfile);
        System.assert(req.getRequestType() == 'createCustomerPaymentProfile');

        
        String result = req.getBody();
        system.debug(result);
        Boolean idPresent = result.contains('customerProfileId');
       
    }

    @isTest
    static void ConstructCustomerProfile() {
  
        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();
        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, mock);
        }

  
        AuthNetAddress shipTo = new AuthNetAddress('Mel', 'Smythe-Bananas', '1325 West 18th Ave', 'Eugene', 'OR', '97402');
        shipTo.setCompany('LCC Art Department');

        List<AuthNetAddress> shipToList = new List<AuthNetAddress>();
        shipToList.add(shipTo);

        Object generic = shipToList;

        System.assert(generic instanceof List<AuthorizeDotNetType>);

  
        
        CustomerPaymentProfile paymentProfile = new CustomerPaymentProfile();
        paymentProfile.setCard(new CreditCard('4111111111111111', '05-2026'));

        

        CustomerProfile profile = new CustomerProfile();
        profile.setMerchantCustomerId('123');
        profile.setEmail('john.doe@example.com');
        profile.setDescription('My Profile');
        profile.setProfileType('individual');
        profile.addToPaymentProfiles(paymentProfile);

        JsonPayload p1 = new JsonPayload();
        p1.writeStartObject();
        p1.writeObjectField('profile', profile);
        p1.writeEndObject();
        System.debug(p1.getAsString());

        CreateCustomerProfileRequest req = new CreateCustomerProfileRequest(profile);
        req.setValidationMode('testMode');
        req.getValidationMode();
        req.addToShipToList(shipTo);
        req.setShipToList((List<AuthNetAddress>)shipToList);
        req.getShipToList();
        
        String body = req.getBody();


        AuthorizeDotNetClient client = new AuthorizeDotNetClient();
        CreateCustomerProfileResponse resp = (CreateCustomerProfileResponse)client.send(req);


        System.debug(resp.getBody());
        System.debug('Response status is: '+ resp.success());
        System.debug('CustomerProfileId from response is: ' + resp.getCustomerProfileId());
    }





    @isTest
    private static void testMessages() {

        Messages msgs = new Messages();
        Message m1 = new Message('I00001','Successful.');
        m1.setCode('');
        m1.setText('');
        m1.getCode();
        m1.getText();

        msgs.addMessage(m1);
        msgs.setMessage(new List<Message>{m1});
        msgs.setResultCode(AuthorizeDotNetResponse.RESPONSE_SUCCESS);

        JsonPayload p2 = new JsonPayload();
        p2.writeStartObject();
        p2.writeObjectField('messages', msgs);
        p2.writeEndObject();
        System.debug(p2.getAsString());

        String resultCode = msgs.getResultCode();
        List<Message> statuses = msgs.getMessage();
        Message first = msgs.getFirstMessage();
    }

   

    @isTest static void updateCustomerProfile(){
        //set up data to send
            
        //make request

        //send request

        //deserialize response
    }

    @isTest static void deleteCustomerProfile(){
        //set up data to send
            
        //make request

        //send request

        //deserialize response
    }
}