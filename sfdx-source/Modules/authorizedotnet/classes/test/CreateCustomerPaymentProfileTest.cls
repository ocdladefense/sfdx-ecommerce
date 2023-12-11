@isTest
public class CreateCustomerPaymentProfileTest {
    public CreateCustomerPaymentProfileTest() {

    }

    @isTest static void CreateCustomerPaymentProfileDefaultConstructorTest() {
        String customerProfileId = '527262';

        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, new AuthorizeDotNetServiceMock());
        }


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
        req.setCustomerProfileId(customerProfileId);
        req.setPaymentProfile(paymentProfile);
        System.assert(req.getRequestType() == 'createCustomerPaymentProfile');

        
        String result = req.getBody();
        system.debug(result);
        Boolean idPresent = result.contains('customerProfileId');

        String msg1 = 'This request should have customerProfileId.';
        System.assertEquals(true, idPresent, msg1);

        
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        //response
        CreateCustomerPaymentProfileResponse resp = new CreateCustomerPaymentProfileResponse();
        resp = (CreateCustomerPaymentProfileResponse)client.send(req);
        
        String msg2 = 'The response should return a 200 response code.';
        System.assert(resp.success(), msg2);
    }

    @isTest static void ConstructorWithPaymentProfileTest() {
        

        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, new AuthorizeDotNetServiceMock());
        }


        //variables
        String customerProfileId = '527262';
        AuthNetAddress address = new AuthNetAddress('Sebastian', 'Berna', '214 NW Monroe Ave', 'Corvallis', 'OR', '97330');
        CreditCard card = new CreditCard('4111111111111122','11/2024');
        Payment payment = new Payment();
        payment.setCreditCard(card);

        CustomerPaymentProfile paymentProfile = new CustomerPaymentProfile();
        paymentProfile.setBillTo(address);
        paymentProfile.setPayment(payment);
        paymentProfile.setCard(card);

        //request
        CreateCustomerPaymentProfileRequest req = new CreateCustomerPaymentProfileRequest(paymentProfile);
        req.setCustomerProfileId(customerProfileId);
        System.assert(req.getRequestType() == 'createCustomerPaymentProfile');

        
        String result = req.getBody();
        Boolean idPresent = result.contains('customerProfileId');

        String msg1 = 'This request should have customerProfileId.';
        System.assertEquals(true, idPresent, msg1);

        
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        //response
        CreateCustomerPaymentProfileResponse resp = (CreateCustomerPaymentProfileResponse)client.send(req);
        
        String msg2 = 'The response should return a 200 response code.';
        System.assert(resp.success(), msg2);

        System.assertEquals(customerProfileId, resp.getCustomerProfileId());
        System.assert(resp.getCustomerPaymentProfileId() != null);
        System.assert(resp.getValidationResponse() != null);
        System.assert(resp.isDefault() == false, 'Should be false since it was not set to true in the request');
    }
    
    @isTest static void RequestBaseClassTest() {
        

        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, new AuthorizeDotNetServiceMock());
        }


        //variables
        String customerProfileId = '527262';
        
        CustomerPaymentProfile paymentProfile = new CustomerPaymentProfile();

        //request
        AuthorizeDotNetRequest req = new AuthorizeDotNetRequest('createCustomerPaymentProfile');
        //req.setCustomerProfileId(customerProfileId);
        req.put('customerProfileId', customerProfileId);
        System.assert(req.getRequestType() == 'createCustomerPaymentProfile');
        System.assert(req.get('customerProfileId') == customerProfileId);

        //adds the field 'testField' to the request
        req.addField('testField');
        System.debug('req: ' + req);
        System.debug('req: ' + req.keySet());
        System.assert(req.keyset().contains('testField'), 'The request keyset should contain testField');

        req.put('testField', '50');
        String body = req.getBody();
        System.assert(req.getBody().contains('testField'));

        //adds 'testField as an ignored field'
        req.ignoreField('testField');
        System.debug('req: ' + req.keySet());
        System.debug('req.getBody(): ' + req.getBody());
        System.assert(!(req.getBody().contains('testField')), 'The request body should not contain testField');

        //sets fields back to the original two entries without 'testField'
        Set<String> fields = new Set<String> {'customerProfileId', 'paymentProfile'};
        req.setFields(fields);
        System.debug('req: ' + req);
        System.debug('req: ' + req.keySet());
        System.assert(!(req.keyset().contains('testField')), 'The request keyset should not contain testField');
  

        System.assert(req.getPrimaryKeyField() == null);
        System.assert(req.getPrimaryKeyValue() == null);
        
        
    }
}