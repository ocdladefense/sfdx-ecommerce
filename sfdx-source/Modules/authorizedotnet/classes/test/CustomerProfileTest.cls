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
    
    @isTest
    static void CreateCustomerProfileWithLists(){
        AuthNetAddress billTo = new AuthNetAddress('Mel', 'Smythe', '1325 West 18th Ave', 'Eugene', 'OR', '97402');
        billTo.setCompany('LCC');
        CreditCard card = new CreditCard('4111111111111111', '12-2026');

        CustomerPaymentProfile theDefaultPayment = new CustomerPaymentProfile(card, billTo);
        theDefaultPayment.setDefault();
        List<CustomerPaymentProfile> paymentProfiles = new List<CustomerPaymentProfile>();
        paymentProfiles.add(theDefaultpayment);
        CustomerProfile profile = new CustomerProfile();
        profile.setPaymentProfiles(paymentProfiles);
        profile.setEmail('mara@mara.org');
    
        AuthNetAddress shipTo = new AuthNetAddress('M.', 'Smythe', '1000 10th Ave', 'Eugene', 'OR', '97401');
 
  //setting test prop singleAddress 
    profile.setSingleAddress(shipTo);
    
       
        CreateCustomerProfileRequest req = new CreateCustomerProfileRequest(profile);
        req.setCustomerProfile(profile);
    
        List<AuthNetAddress> shipToList = new List<AuthNetAddress>();
        shipToList.add(shipTo);
        req.setShipToList(shipToList);

      
        String result = req.getBody();
        System.debug(result);

        System.AssertEquals(false, result.contains('primaryKeyField'), 'should not contain fields not specified in field list');

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();
        CreateCustomerProfileResponse resp = (CreateCustomerProfileResponse)client.send(req);
        System.debug (resp.getBody());

        System.debug('success is '+ resp.success());
        System.debug('customerProfileId from response is ' + resp.getCustomerProfileId());


        
    }
      
    @isTest static void createCustomerProfile(){
        //set up data to send
        CreditCard theCard = new CreditCard('4111111111111111', '2025-01');
        AuthNetAddress billTo = new AuthNetAddress('M.', 'Williams', '1000 10th Ave', 'Eugene', 'OR', '97401');

        CustomerPaymentProfile theDefaultPayment = new CustomerPaymentProfile(theCard, billTo);
        theDefaultPayment.setDefaultPaymentProfile(true);
        theDefaultPayment.setCustomerType('individual');
        
        AuthNetAddress shipto = new AuthNetAddress('M.', 'Williams', '1000 10th Ave', 'Eugene', 'OR', '97401');

        CustomerProfile theProfile = new Customerprofile();
        theProfile.addToPaymentProfiles(theDefaultPayment);
        //setting shipTo inside profile
        theProfile.addToShipToList(shipTo);
        theProfile.setEmail('mara@testing.org');
        theProfile.setDescription('testing profile');
            
        //make request
        CreateCustomerProfileRequest req = new CreateCustomerProfileRequest();
        req.setCustomerProfile(theProfile);

        string result = req.getBody();
        //System.debug(result);
        Boolean idPresent = result.contains('customerProfileId');
        System.assertEquals(false, idPresent, 'this request should not have customerProfileId');


        //send request

        //deserialize response

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