@isTest
public class GetCustomerPaymentProfileTest {
    public GetCustomerPaymentProfileTest() {

    }

    @isTest static void getCustomerPaymentProfile(){
        //request
        String customerProfileId = '905372692';
        String paymentProfileId = '915890663';
        GetCustomerPaymentProfileRequest req = new GetCustomerPaymentProfileRequest();
        req.setCustomerProfileId(customerProfileId);
        req.setCustomerPaymentProfileId(paymentProfileId);

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
}