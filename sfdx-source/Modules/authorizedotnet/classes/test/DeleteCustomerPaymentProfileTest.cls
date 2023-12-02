@isTest 
public class DeleteCustomerPaymentProfileTest {

    public static final String DEFAULT_CUSTOMER_PROFILE_ID = '905372692';
    String customerProfileId = '905372692';
    String paymentProfileId = '915890663';

    public DeleteCustomerPaymentProfileTest() {

    }

    @isTest static void DeleteCustomerPaymentProfile() {
        //request
        String customerProfileId = '905372692';
        String paymentProfileId = '915890663';
        DeleteCustomerPaymentProfileRequest req = new DeleteCustomerPaymentProfileRequest();
        req.setCustomerProfileId(customerProfileId);
        req.setCustomerPaymentProfileId(paymentProfileId);

        string result = req.getBody();
        // Asserts both IDs are in the request
        System.Assert(result.contains('customerProfileId'), true);
        System.Assert(result.contains('customerPaymentProfileId'), true);

        //client or mock
        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();
        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, mock);
        }

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();
        
        //response
        DeleteCustomerPaymentProfileResponse resp = (DeleteCustomerPaymentProfileResponse)client.send(req);
        
        System.debug(resp.getBody());
        
        Boolean success = resp.success();
        System.debug('success is : '+ success);
        
        System.assertEquals(true, success, 'success should return true');
    }

}