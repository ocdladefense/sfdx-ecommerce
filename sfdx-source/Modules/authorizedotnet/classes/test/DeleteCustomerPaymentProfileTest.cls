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
    String respBodyString = '';
    
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
   
}