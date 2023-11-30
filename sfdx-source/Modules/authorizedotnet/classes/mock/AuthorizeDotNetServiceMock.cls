public class AuthorizeDotNetServiceMock implements HttpCalloutMock {
    
    protected List<CustomerPaymentProfile> profiles;

    public AuthorizeDotNetServiceMock() {
        //invoke the list with 4 profiles
       
}

//logic for testing if a req's customerProfileId is on the list

/*        if(Test.isRunningTest() && req.getRequestType()=='DeleteCustomerPaymentProfile'){
            //can also try in test class
            //need way to set isErrorTest value to false
            Map<String, Object> tempObj = req.getBodyAsNativeObject();
            String paymentProfileId = (String)tempObj.get('customerPaymentProfileId');
           Boolean isErrorTest = DeleteCustomerPaymentProfileMockResponse.setIsErrorTestByPaymentProfileId(paymentProfileId);
           resp.setIsErrorTest(isErrorTest); 
           System.debug('set the errorTestValue');
        }*/

    public HttpResponse respond(HttpRequest req) {
        //System.debug('making a respond request');

        HttpResponse resp = new HttpResponse();
        
        String requestType = req.getHeader('X-Request-Type');
        String responseType;
        
        //UpdateCustomerShippingAddressMockResponse (and Delete, Create versions) exceed 40 character limit for class name
        //if statement to catch those request types and append shorter 'MockResp' 

        if(requestType.contains('CustomerShippingAddress')){
            responseType = requestType.capitalize()+'MockResp';
        }
        else{
            responseType = requestType.capitalize()+'MockResponse';
        }
       
 

        System.Type t = Type.forName(responseType);
        if(t == null) {
            throw new AuthorizeDotNetException('could not find type matching to ' + responseType);
        }
        IMockResponse mock = (IMockResponse)t.newInstance();


        resp.setHeader('Content-Type', 'application/json');
       
        String theBody = mock.getBody();
        System.debug(theBody);
        if(theBody == null) {
            throw new AuthorizeDotNetException('mock.getBody should not return a null value. ' + responseType);
        }
        resp.setBody(mock.getBody());
        resp.setStatusCode(200);
        String codeForDebug ='200';
        resp.setStatus('Apex generated Mock HttpResponse.');
 
        //System.debug('The mock response status code is ' + codeForDebug);
        return resp;
    }

}