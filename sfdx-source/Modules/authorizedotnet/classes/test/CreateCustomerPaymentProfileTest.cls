@isTest
public class CreateCustomerPaymentProfileTest {
    public CreateCustomerPaymentProfileTest() {

    }

    @isTest static void CreateCustomerPaymentProfile() {

        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, new AuthorizeDotNetServiceMock());
        }


        //variables
        Address address = new Address('Sebastian', 'Berna', '214 NW Monroe Ave', 'Corvallis', 'OR', '97330');
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
        Boolean idPresent = result.contains('customerProfileId');

        String msg1 = 'This request should have customerProfileId.';
        System.assertEquals(true, idPresent, msg1);

        

        
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        //response
        CreateCustomerPaymentProfileResponse resp = (CreateCustomerPaymentProfileResponse)client.send(req);
        
        String msg2 = 'The response should return a 200 response code.';
        System.assert(resp.success(), msg2);
    }
}