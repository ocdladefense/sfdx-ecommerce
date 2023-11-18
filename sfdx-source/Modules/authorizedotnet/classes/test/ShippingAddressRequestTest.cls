@isTest
public class ShippingAddressRequestTest {
    public ShippingAddressRequestTest() {

    }
    @isTest static void createCustomerShippingAddressRequestBody(){
        Address address = new Address('M.', 'Williams', '1000 10th Ave', 'Eugene', 'OR', '97401');
        CreateCustomerShippingAddressRequest req = new CreateCustomerShippingAddressRequest();
        req.setAddress(address);
        req.setCustomerProfileId('1234');
        
        string result = req.getBody();
        Boolean idPresent = result.contains('customerAddressId');

        System.debug('id is present: '+ idPresent);
        System.debug(result);
        System.assertEquals(false, idPresent, 'this request should not have customerAddressId');

    }

    @isTest static void deserializeCreateCustomerShippingAddressResponseBaseClassSetter(){

        String result = '{"customerAddressId":"126406","messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;
        
        AuthorizeDotNetResponse authResp = new AuthorizeDotNetResponse();
        authResp.setBody(result);
        //set body manually needs this in deserialize
            //AuthorizeDotNetResponse resp = (AuthorizeDotNetResponse)JSON.deserialize(this.getBody(), AuthorizeDotNetResponse.class);

            //this.messages = resp.getMessages();
        authResp.deserialize();
        
        Messages messages = authResp.getMessages();
        String resultCode = Messages.getResultCode();
        System.debug('result code manual is' + resultCode);

        Boolean success = authResp.success();
        System.debug('success is : '+ success);
        System.assertEquals(true, success, 'success should return true');

        String idFromResult = '126406';
        String customerAddressId = authResp.getStringValue('customerAddressId');
        System.debug(customerAddressId);

        //set body through constructor needs this in deserialize 
           //Messages m = (Messages)JSON.deserialize(this.getBody(), Messages.class);

            //this.messages = m;
            //added null check in deserialize to cover both situations
        
    }

    @isTest public static void deserializeCreateCustomerShippingAddressResponseBaseClassConstructor(){
        String resultConstruct = '{"customerAddressId":"126406","messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}' ;

        AuthorizeDotNetResponse authRespConstruct = new AuthorizeDotNetResponse(resultConstruct);
        authRespConstruct.deserialize();
        Messages messagesConstruct = authRespConstruct.getMessages();
        System.debug(messagesConstruct);
        String resultCodeConstruct = messagesConstruct.getResultCode();
        System.debug('result code constructor is' + resultCodeConstruct);

        Boolean success = authRespConstruct.success();
        System.debug('success is : '+ success);
        System.assertEquals(true, success, 'success should return true');

        String idFromResult = '126406';
        String customerAddressId = authRespConstruct.getStringValue('customerAddressId');
        System.debug(customerAddressId);

        System.assertEquals(true, customerAddressId==idFromResult, 'this response should be able to get customerAddressId');

    }

    @isTest static void updateCustomerShippingAddressRequestBody(){
        Address address = new Address('M.', 'Williams', '1000 10th Ave', 'The Moon', 'OR', '97401');
        address.setCustomerAddressId('3456');
        UpdateCustomerShippingAddressRequest req = new UpdateCustomerShippingAddressRequest(address);
        req.setAddress(address);
        req.setCustomerProfileId('1234');
        
        string result = req.getBody();
        Boolean idPresent = result.contains('customerAddressId');

        System.debug('id is present: '+ idPresent);
        System.debug(result);
        System.assertEquals(true, idPresent, 'this request should have customerAddressId');

    }

    @isTest static void deleteCustomerShippingAddressRequestBody(){
        Address address = new Address('M.', 'Williams', '1000 10th Ave', 'The Moon', 'OR', '97401');
        address.setCustomerAddressId('3456');
        DeleteCustomerShippingAddressRequest req = new DeleteCustomerShippingAddressRequest(address.getCustomerAddressId());
        
        req.setCustomerProfileId('1234');
        
        string result = req.getBody();
        Boolean idPresent = result.contains('customerAddressId');

        System.debug('id is present: '+ idPresent);
        System.debug(result);
        System.assertEquals(true, idPresent, 'this request should have customerAddressId');

    }

    @isTest static void getCustomerShippingAddressRequestBody(){
        String customerprofileId='1234';
        String customerAddressId='2345';
        GetCustomerShippingAddressRequest req = new GetCustomerShippingAddressRequest();
        req.setCustomerAddressId(customerAddressId);
        req.setCustomerProfileId(customerProfileId);

        string result = req.getBody();
        Boolean idPresent = result.contains('customerAddressId');

        System.debug('id is present: '+ idPresent);
        System.debug(result);
        System.assertEquals(true, idPresent, 'this request should have customerAddressId');

    }


    @isTest static void updateCustomerShippingAddress() {

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

        System.debug(result);

        System.assert(indexMerchantAuthentication<indexCustomerProfileId);
        System.assert(indexCustomerProfileId<indexAddress);
        System.Assert(indexAddress<indexDefaultShippingAddress);
        System.assert(4==startObjectMatches);


    }


}