@isTest
public class GetCustomerPaymentProfileTest {
    public GetCustomerPaymentProfileTest() {

    }

    @isTest 
    static void getCustomerPaymentProfileDefaultConstructorTest(){
        //request
        String customerProfileId = '905372692';
        String paymentProfileId = '915890663';

        CustomerPaymentProfile paymentProfile = new CustomerPaymentProfile();
        paymentProfile.setCustomerPaymentProfileId(paymentProfileId);

        // request built with default constructor
        GetCustomerPaymentProfileRequest req = new GetCustomerPaymentProfileRequest();
        req.setCustomerProfileId(customerProfileId);
        req.setCustomerPaymentProfileId(paymentProfileId);

        //client or mock
        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();
        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, mock);
        }

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();
        
        //response
        GetCustomerPaymentProfileResponse resp = (GetCustomerPaymentProfileResponse)client.send(req);
        
       
        String primaryKeyField = 'customerPaymentProfileId';
        String primaryKeyValue = '915890663';
        Boolean success = resp.success();
        
        System.assertEquals(true, success, 'success should return true');
        System.assertEquals('customerPaymentProfileId', req.getPrimaryKeyField());
        System.assertEquals('915890663', req.getPrimaryKeyValue());
        System.assert(req.keySet().contains('customerProfileId'));
        System.assert(req.keySet().contains('customerPaymentProfileId'));
    }

    @isTest 
    static void getCustomerPaymentProfileWithPaymentProfileTest(){
        //request
        String customerProfileId = '527262';
        

        //default valid Visa card
        String paymentProfileId = '87';
        CreditCard creditCard = new CreditCard('XXXX1111', 'XXXX');
        Address billTo = new Address('John', 'Doe', '123 Main St.', 'Bellevue', 'WA', '98004');
        CustomerPaymentProfile paymentProfile = new CustomerPaymentProfile(creditCard, billTo);
        paymentProfile.setCustomerPaymentProfileId(paymentProfileId);


        // request built with constructor that includes a CustomerPaymentProfile object
        GetCustomerPaymentProfileRequest req = new GetCustomerPaymentProfileRequest(paymentProfile);
        req.setCustomerProfileId(customerProfileId);


        //client or mock
        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();
        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, mock);
        }

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();
        

        //response
        GetCustomerPaymentProfileResponse resp = (GetCustomerPaymentProfileResponse)client.send(req);
        
        System.debug('resp.getBody(): ' + resp.getBody());
        
        CustomerPaymentProfile thePaymentProfile = resp.getPaymentProfile();
        Address theBillTo = resp.getBillTo();
        CreditCard theCard = resp.getCreditCard();

        System.debug('paymentProfileId' + thePaymentProfile.getCustomerPaymentProfileId());
        System.debug('paymentProfile' + thePaymentProfile);
        System.debug('response: ' + resp);
        System.debug('card: ' + theCard);
        System.debug('billTo: ' + theBillTo);
        //System.debug('firstName: ' + theBillTo.getFirstName());
        //System.debug('cardNumber: ' + theCard.getCardNumber());
        Boolean success = resp.success();
        System.debug('success is : '+ success);
        
        //System.assertEquals(true, success, 'success should return true');
        //System.assert(resp.isDefault() == false);
        //System.assertEquals('527262', resp.getCustomerProfileId());
        //System.assertEquals('87', resp.getCustomerPaymentProfileId());
        //System.assertEquals('John', billTo.getFirstName());
        //System.assertEquals('XXXX1111', theCard.getCardNumber());
    }

    /*
    @isTest 
    static void getCustomerPaymentProfileWithIssuerInfoTest(){
        //request
        String customerProfileId = '905372692';
        String paymentProfileId = '915890663';

        CustomerPaymentProfile paymentProfile = new CustomerPaymentProfile();
        paymentProfile.setCustomerPaymentProfileId(paymentProfileId);

        // request built with default constructor
        GetCustomerPaymentProfileRequest req = new GetCustomerPaymentProfileRequest();
        req.setCustomerProfileId(customerProfileId);
        req.setCustomerPaymentProfileId(paymentProfileId);

        // request built with constructor that includes a CustomerPaymentProfile object
        GetCustomerPaymentProfileRequest reqWithProfile = new GetCustomerPaymentProfileRequest(paymentProfile);
        req.setCustomerProfileId(customerProfileId);

        string result = req.getBody();
        Boolean idPresent = result.contains('customerProfileId');

        //client or mock
        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();
        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, mock);
        }

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();
        
        //response
        GetCustomerPaymentProfileResponse resp = (GetCustomerPaymentProfileResponse)client.send(req);
        
        System.debug(resp.getBody());
        
        Boolean success = resp.success();
        System.debug('success is : '+ success);
        
        System.assertEquals(true, success, 'success should return true');
    }
    */   
}