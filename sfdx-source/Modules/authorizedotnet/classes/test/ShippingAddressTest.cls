@isTest
public class ShippingAddressTest {


    @isTest
    private static void createCustomerShippingAddressDefaultConstructor(){
        //request is connected?
        AuthNetAddress address = new AuthNetAddress('M.', 'Williams', '1000 10th Ave', 'Eugene', 'OR', '97401');
        CreateCustomerShippingAddressRequest req = new CreateCustomerShippingAddressRequest();
        req.setAddress(address);
        req.setCustomerProfileId('1234');
        
        string result = req.getBody();
        Boolean idPresent = result.contains('customerAddressId');
        System.debug(result);
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

    @isTest
    private static void createCustomerShippingAddress(){
        //request is connected?
        AuthNetAddress theAddress = new AuthNetAddress('M.', 'Williams', '1000 10th Ave', 'Eugene', 'OR', '97401');
        CreateCustomerShippingAddressRequest req = new CreateCustomerShippingAddressRequest(theAddress);
        req.setAddress(theAddress);
        req.setCustomerProfileId('1234');

        if(req.getDefaultShippingAddress()==false || req.getDefaultShippingAddress()==null){
            req.setDefaultShippingAddress(true);
        }

        System.assert(req.getAddress()!= null);
        System.assert(req.getCustomerProfileId()=='1234');

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



    @isTest
    private static void updateCustomerShippingAddress(){
        //request
        AuthNetAddress newAddress = new AuthNetAddress('J.', 'Berna', '214 NW Monroe Ave', 'Albany', 'OR', '97330');
        newAddress.setCompany('OCDLA');
        newAddress.setfaxNumber('555-555-5555');
        newAddress.setPhoneNumber('556-556-6666');
        UpdateCustomerShippingAddressRequest req = new UpdateCustomerShippingAddressRequest(newAddress);
        req.setCustomerProfileId('1234');
        req.setDefaultShippingAddress(true);

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

    @isTest
    private static void updateCustomerShippingAddressDefaultConstructor(){
        //request
        UpdateCustomerShippingAddressRequest req = new UpdateCustomerShippingAddressRequest();
        req.setCustomerProfileId('1234');
        AuthNetAddress newAddress = new AuthNetAddress('J.', 'Berna', '214 NW Monroe Ave', 'Albany', 'OR', '97330');
        newAddress.setCompany('OCDLA');
        newAddress.setCustomerAddressId('2345');
        req.setAddress(newAddress);

        Boolean currentDefault = req.getDefaultShippingAddress();
        req.setDefaultShippingAddress(!currentDefault);
        Assert.areNotEqual(currentDefault, req.getDefaultShippingAddress());

        AuthNetAddress addressFromReq = req.getAddress();
        System.assert('2345' == addressFromReq.getCustomerAddressId());

        System.assertEquals('1234', req.getCustomerProfileId());

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

    @isTest
    private static void deleteCustomerShippingAddress(){
        String customerAddressId= '916542102';
        String customerProfileId='916376196';
        //request
        DeleteCustomerShippingAddressRequest req = new DeleteCustomerShippingAddressRequest(customerAddressId);
        req.setCustomerAddressId(customerAddressId);
        req.setCustomerProfileId(customerProfileId);
        
        string result = req.getBody();
        Boolean idPresent = result.contains('customerAddressId');

        System.assertEquals(true, idPresent, 'this request should have customerAddressId');

        System.assertEquals('916376196', req.getCustomerProfileId());
        System.assertEquals('916542102', req.getCustomerAddressId());

        System.debug(result);

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


    @isTest
    private static void deleteCustomerShippingAddressDefaultConstructor(){
        
        //request
        AuthNetAddress theAddress = new AuthNetAddress('M.', 'Williams', '1000 10th Ave', 'The Moon', 'OR', '97401');
        theAddress.setCustomerAddressId('3456');

        DeleteCustomerShippingAddressRequest req = new DeleteCustomerShippingAddressRequest();

        req.setCustomerAddressId(theAddress.getCustomerAddressId());
        req.setCustomerProfileId('1234');
        
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
    }


    @isTest
    private static void deserializeDeleteCustomerShippingAddressResponse(){
        String result = '{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;
        DeleteCustomerShippingAddressResponse shipResp = new DeleteCustomerShippingAddressResponse(result);
        shipResp.deserialize();
        System.debug(shipResp);
        Boolean success = shipResp.success();
        System.assertEquals(true, success, 'success should return true');

        DeleteCustomerShippingAddressResponse shipResp2 = new DeleteCustomerShippingAddressResponse();
        shipResp2.setBody(result);
        shipResp2.deserialize();
        Boolean success2 = shipResp2.success();
        System.assertEquals(true, success2, 'success should return true');

    }


    @isTest
    private static void getCustomerShippingAddress(){
        //request
        String customerprofileId='1234';
        String customerAddressId='2345';
        GetCustomerShippingAddressRequest req = new GetCustomerShippingAddressRequest();
        req.setCustomerAddressId(customerAddressId);
        req.setCustomerProfileId(customerProfileId);

        System.assertEquals('1234', req.getCustomerProfileId());
        System.assertEquals('2345', req.getCustomerAddressId());


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


    @isTest
    private static void deserializeGetCustomerShippingAddressResponse(){

        String getResult = '{"address":{"customerAddressId":"37457091","firstName":"China","lastName":"Bayles","company":"Thyme for Tea","address":"12 Main Street","city":"Pecan Springs","state":"TX","zip":"44628","country":"US"},"subscriptionIds":["3078184"],"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;
        GetCustomerShippingAddressResponse shipResp = new GetCustomerShippingAddressResponse(getResult);
        //System.debug(shipResp);
        shipResp.deserialize();
        
        //shipResp = (GetCustomerShippingAddressResponse)JSON.deserialize(shipResp.getBody(), GetCustomerShippingAddressResponse.class);
        //System.debug(shipResp);
        System.debug(shipResp.getSubscriptionIds());
        System.debug(shipResp.getAddress());
        
        Boolean success = shipResp.success();
        System.debug('success is : '+ success);
        System.assertEquals(true, success, 'success should return true');

    }


    @isTest
    private static void deserializeCreateCustomerShippingAddressResponse(){
        //set body through constructor
        //included for code coverage on CreateCustomerShippingAddressResponse
        String result = '{"customerAddressId":"126406","messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;
        
        CreateCustomerShippingAddressResponse shipResp = new CreateCustomerShippingAddressResponse(result);
        shipResp.deserialize();
        
        Boolean success = shipResp.success();
        System.debug('success is : '+ success);
        //System.assertEquals(true, success, 'success should return true');

        String idFromResult = '126406';
        String customerAddressId = shipResp.getCustomerAddressId();
        System.debug('--------' + customerAddressId);
        System.assertEquals(idFromResult, customerAddressId);

        //set body through setter
        String result2 = '{"customerAddressId":"126406","messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;
    
        CreateCustomerShippingAddressResponse shipResp2 = new CreateCustomerShippingAddressResponse();
        shipResp2.setBody(result2);
        shipResp2.deserialize();
        
        Boolean success2 = shipResp2.success();
        System.debug('success2 is : '+ success2);
        //System.assertEquals(true, success, 'success should return true');

        String idFromResult2 = '126406';
        System.debug('--------');
        String customerAddressId2 = shipResp2.getCustomerAddressId();
        System.debug('--------' + customerAddressId2);
        System.assertEquals(idFromResult2, customerAddressId2);
        
    }

    @isTest
    private static void deserializeUpdateCustomerShippingAddressResponse(){
        String result = '{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;
        UpdateCustomerShippingAddressResponse shipResp = new UpdateCustomerShippingAddressResponse(result);
        shipResp.deserialize();
        
        Boolean success = shipResp.success();
        System.debug('success is : '+ success);
        System.assertEquals(true, success, 'success should return true');

        UpdateCustomerShippingAddressResponse shipResp2 = new UpdateCustomerShippingAddressResponse();
        shipResp2.setBody(result);

        System.assert(shipResp2.getBody()!=null);

    }



    @isTest
    private static void messagesAndMessageConstructors(){
        Message message = new Message();
        message.setCode('I00001');
        message.setText('successful message');
        System.assertEquals('successful message', message.getText());

        Messages messages = new Messages();
        List<Message> messageList = new List<Message>();
        messageList.add(message);

        messages.setMessage(messageList);
        System.assert(messages.getFirstMessage()!=null);
        System.assert(messages.getMessage()!=null);

        messages.setResultCode('Ok');
        System.assertEquals('Ok', messages.getResultCode());
    }  

}