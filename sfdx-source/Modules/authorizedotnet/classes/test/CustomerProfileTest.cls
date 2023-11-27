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
        Boolean idPresent = result.contains('customerProfileId');

        System.assertEquals(true, idPresent, 'this request should have customerProfileId');
        System.assertEquals(req.getCustomerProfileId(), req.getCustomerProfileId());
        System.assertEquals(true, req.getUnmaskExpirationDate());

    }
}