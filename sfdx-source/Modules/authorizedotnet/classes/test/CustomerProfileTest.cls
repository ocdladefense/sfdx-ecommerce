@isTest
public class CustomerProfileTest {
    public CustomerProfileTest() {

    }

    @isTest static void deserializeGetCustomerProfileResponse(){

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

    @isTest static void getCustomerProfileRequestBody(){
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
    public void createCustomerPaymentProfileRequestBodyForRef(){
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

    @isTest static void CreateCustomerprofileRequestConstructors(){
        AuthNetAddress billTo = new AuthNetAddress('Mel', 'Smythe-Bananas', '1325 West 18th Ave', 'Eugene', 'OR', '97402');
        billTo.setCompany('LCC Art Department');
        CreditCard card = new CreditCard('4111111111111111', '05-2026');
        Payment thePayment = new Payment(card);

        CreateCustomerProfileRequest req = new CreateCustomerProfileRequest(card, billTo);
        CreateCustomerProfileRequest req2 = new CreateCustomerProfileRequest(card);
        CreateCustomerProfileRequest req3 = new CreateCustomerProfileRequest();

        req.setEmail('mSmyth@lcctest.org');
        
        String result = req.getBody();
        System.debug(result);
        System.AssertEquals(true, result.contains('billTo'));
        System.AssertEquals(false, result.contains('customerType'));

        req2.setDescription('new profile');
        req2.setCustomerType('individual');
        String result2 = req2.getBody();
        System.debug(result2);
        System.AssertEquals(false, result2.contains('billTo'));
        System.AssertEquals(true, result2.contains('customerType'));

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();
        CreateCustomerProfileResponse resp = (CreateCustomerProfileResponse)client.send(req);
        System.debug (resp.getBody());

        System.debug('success is '+ resp.success());
        System.debug('customerProfileId from response is ' + resp.getCustomerProfileId());

        //able to create req successfully

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