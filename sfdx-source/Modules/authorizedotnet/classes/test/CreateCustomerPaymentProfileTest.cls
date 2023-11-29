@isTest
public class CreateCustomerPaymentProfileTest {
    public CreateCustomerPaymentProfileTest() {

    }

    @isTest static void CreateCustomerPaymentProfile() {
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
        /*req.setCustomerProfileId('1234');*/
        
        string result = req.getBody();
        Boolean idPresent = result.contains('customerProfileId');

        System.assertEquals(true, idPresent, 'this request should have customerProfileId');

        //client or mock
        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();
        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, mock);
        }
        
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        //response
        CreateCustomerPaymentProfileResponse resp = (CreateCustomerPaymentProfileResponse)client.send(req);
        /*
        Boolean success = resp.success();
        System.assertEquals(true, success, 'success should return true');
        
        String idFromResult = '126406';
        System.assertEquals(idFromResult, shipResp.getCustomerAddressId());

        String codeFromResult = 'I00001';
        Messages messages = shipResp.getMessages();
        List<Message> messageList = messages.getMessage();
        System.assertEquals(codeFromResult, messageList[0].getCode());
        */
    }
}