@isTest
public class ShippingAddressTest {
    public ShippingAddressTest() {

    }

    @isTest static void createCustomerShippingAddress(){
        //request is connected?
        Address address = new Address('M.', 'Williams', '1000 10th Ave', 'Eugene', 'OR', '97401');
        CreateCustomerShippingAddressRequest req = new CreateCustomerShippingAddressRequest();
        req.setAddress(address);
        req.setCustomerProfileId('1234');
        
        string result = req.getBody();
        Boolean idPresent = result.contains('customerAddressId');

        System.assertEquals(false, idPresent, 'this request should not have customerAddressId');

        //client or mock
        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();
        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, mock);
        }

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        //response
        CreateCustomerShippingAddressResponse shipResp = (CreateCustomerShippingAddressResponse)client.send(req);

        Boolean success = shipResp.success();
        System.assertEquals(true, success, 'success should return true');

        String idFromResult = '126406';
        System.assertEquals(idFromResult, shipResp.getCustomerAddressId());

        String codeFromResult = 'I00001';
        Messages messages = shipResp.getMessages();
        List<Message> messageList = messages.getMessage();
        System.assertEquals(codeFromResult, messageList[0].getCode());
    }



    @isTest static void updateCustomerShippingAddress(){
        //request
        UpdateCustomerShippingAddressRequest req = new UpdateCustomerShippingAddressRequest();
        req.setCustomerProfileId('1234');
        Address newAddress = new Address('J.', 'Berna', '214 NW Monroe Ave', 'Albany', 'OR', '97330');
        newAddress.setCompany('OCDLA');
        req.setAddress(newAddress);

       
        String result = req.getBody();
        Integer indexMerchantAuthentication = result.indexOf('merchantAuthentication');
        Integer indexCustomerProfileId = result.indexOf('customerProfileId');
        Integer indexAddress = result.indexOf('address');
        Integer indexDefaultShippingAddress= result.indexOf('defaultShippingAddress');
        Integer startObjectMatches = result.countMatches('{');

        System.assert(indexMerchantAuthentication<indexCustomerProfileId);
        System.assert(indexCustomerProfileId<indexAddress);
        System.Assert(indexAddress<indexDefaultShippingAddress);
        System.assert(4==startObjectMatches);


        //client or mock
        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();
        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, mock);
        }

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        //response
        UpdateCustomerShippingAddressResponse shipResp = (UpdateCustomerShippingAddressResponse)client.send(req);
        
        Boolean success = shipResp.success();
        System.debug('success is : '+ success);
        System.assertEquals(true, success, 'success should return true');


        String codeFromResult = 'I00001';
        Messages messages = shipResp.getMessages();
        List<Message> messageList = messages.getMessage();
        System.assertEquals(codeFromResult, messageList[0].getCode());

    }

    @isTest static void deleteCustomerShippingAddress(){
        
        //request
        Address address = new Address('M.', 'Williams', '1000 10th Ave', 'The Moon', 'OR', '97401');
        address.setCustomerAddressId('3456');
        DeleteCustomerShippingAddressRequest req = new DeleteCustomerShippingAddressRequest(address.getCustomerAddressId());
        
        req.setCustomerProfileId('1234');
        
        string result = req.getBody();
        Boolean idPresent = result.contains('customerAddressId');

        System.assertEquals(true, idPresent, 'this request should have customerAddressId');

        //client or mock
        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();
        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, mock);
        }

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        //response
        DeleteCustomerShippingAddressResponse shipResp = (DeleteCustomerShippingAddressResponse)client.send(req);

        Boolean success = shipResp.success();
        System.debug('success is : '+ success);
        System.assertEquals(true, success, 'success should return true');


        String codeFromResult = 'I00001';
        Messages messages = shipResp.getMessages();
        List<Message> messageList = messages.getMessage();
        System.assertEquals(codeFromResult, messageList[0].getCode());
    }

    @isTest static void getCustomerShippingAddress(){
        //request
        String customerprofileId='1234';
        String customerAddressId='2345';
        GetCustomerShippingAddressRequest req = new GetCustomerShippingAddressRequest();
        req.setCustomerAddressId(customerAddressId);
        req.setCustomerProfileId(customerProfileId);

        string result = req.getBody();
        Boolean idPresent = result.contains('customerAddressId');

        //client or mock
        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();
        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, mock);
        }

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        //response
        GetCustomerShippingAddressResponse shipResp = (GetCustomerShippingAddressResponse)client.send(req);
        
        List<String> subscriptionIdsfromResult = shipResp.getSubscriptionIds();
        System.debug('subscribtion list is ' + subscriptionIdsfromResult);
        System.assertEquals(1, subscriptionIdsfromResult.size());
        System.debug(shipResp.getAddress());
        
        Boolean success = shipResp.success();
        System.debug('success is : '+ success);
        
        System.assertEquals(true, success, 'success should return true');

    }


  //example from friday 11/24 meeting
    @isTest static void deserializeGetCustomerShippingAddressResponse(){

        String customerprofileId='1234';
        String customerAddressId='2345';
        GetCustomerShippingAddressRequest req = new GetCustomerShippingAddressRequest();
        req.setCustomerAddressId(customerAddressId);
        req.setCustomerProfileId(customerProfileId);

        string result = req.getBody();
        Boolean idPresent = result.contains('customerAddressId');


        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();
        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, mock);
        }

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        GetCustomerShippingAddressResponse shipResp = (GetCustomerShippingAddressResponse)client.send(req);
       
        System.debug('subscribtion list is ' + shipResp.getSubscriptionIds());
        System.debug(shipResp.getAddress());
        
        Boolean success = shipResp.success();
        System.debug('success is : '+ success);

        System.assertEquals(true, success, 'success should return true');

    }

}