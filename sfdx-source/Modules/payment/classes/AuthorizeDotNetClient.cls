public class AuthorizeDotNetClient extends HttpClient implements IPaymentGatewayClient, HttpCalloutMock{
      	
    //can be used in production and testing
    
	private static final Integer CALLOUT_TIMEOUT = 60000;
    
    private static final String endpoint = 'ccAuthorize';
    
    private static final String protocol = 'https'; 
    
    public static final String GATEWAY_SANDBOX_URL = 'membertest.ocdla.org';
    
    public static final String GATEWAY_PRODUCTION_URL = 'members.ocdla.org';

    public static final String DELETE_REQUEST_KEY = 'deleteCustomerPaymentProfileRequest';
    
    private String url;

    //needed to set value for if statement in respond
    private static PaymentGatewayRequestType requestType;
    
    //copied to be like QuickBooksClient as private instance method
    //class would not deploy without value
    private String getAccessToken() {
        return 'foobar';
    }
    
    public AuthorizeDotNetClient() {
    }
    
    public AuthorizeDotNetClient(String url) {
        this.url = url;
    }
    
    @TestVisible
    public TransactionResponse send(TransactionRequest reqn){
        Http http = new Http();
        
        HttpRequest req = reqn.toHttpRequest();
        
        //Set HTTPRequest header properties
        req.setHeader('Host', getDomain());
        req.setEndpoint( 'https' + '://'+ getDomain()+'/'+'ccAuthorize');
        req.setTimeout(CALLOUT_TIMEOUT);
        // Execute web service call here	
     	
        HttpResponse resp = http.send(req);
        
        return TransactionResponse.newFromResponse(resp);
    } 
    //if sent a request message type 
    //do this which then will call send that takes a request type
    public override HttpResponseMessage send(HttpRequestMessage r) {
        System.debug('making a override request');
        Http client = new Http();
        HttpRequest req = r.getAsHttpRequest();
		req.setHeader('Authorization', 'Bearer '+this.getAccessToken());
        String cardsEndpoint = 'https://appdev.ocdla.org/customer/905372692/cards';
        req.setEndpoint(cardsEndpoint);
        req.setMethod('POST');
        //set the reqest type value based on the class
        HttpResponse resp = client.send(req);
  
        return new HttpResponseMessage(resp);
    }

    public HttpResponseMessage send(DeleteCustomerPaymentProfileRequest r) {
       
        Http client = new Http();

        HttpRequest req = r.getAsHttpRequest();
		
        req.setHeader('Authorization', 'Bearer '+this.getAccessToken());
        
        HttpResponse resp = client.send(req);
  
        return new HttpResponseMessage(resp);
    }
    
    
    public HttpResponse send(HttpRequest req) {

        Http client = new Http();
        return client.send(req);
    }
    
    public HttpResponse respond(HttpRequest req) {
        System.debug('making a responde request');
        HttpResponse res = new HttpResponse();
        String cardsEndpoint = 'https://appdev.ocdla.org/customer/905372692/cards';
        res.setHeader('Content-Type', 'application/json');
        
        String theJson = req.getBody();
        String body = setMockBodyDeserializeVersion(theJson);
        
        res.setBody(body);
        res.setStatusCode(200);
        res.setStatus('Apex generated Mock HttpResponse.');
        
        return res;
    }
    

    public string setMockBodyDeserializeVersion(String theJson){
        Map<String, Object> deserialized = (Map<String, Object>)JSON.deserializeUntyped(theJson);

        Boolean isDeleteRequest = deserialized.containsKey('deleteCustomerPaymentProfileRequest');
        system.debug('is this first string about delete: ' + isDeleteRequest);

        //error evaluation for delete tests based on if the customerpaymentprofileid is held in the sample list 
        //can produce an invalid test by using a customerpaymentprofileid that is not on the list 
        //first extract the top level key
        //then deserialize the next object to extract customerpaymentprofileid
        //then call mini method to check the list
        //if errors are done other ways, then don't need to do this, instead use deserialized.containsKey() in the if statements

        Set <String> requestBodyKeys = new Set<String>();
        requestBodyKeys = deserialized.keySet();

        String requestTypeString;

        if(requestBodyKeys.contains(DELETE_REQUEST_KEY)){
            requestTypeString=DELETE_REQUEST_KEY;
        }

        Map<String,Object> innerBody = ( Map<String, Object>)deserialized.get(requestTypeString);

        Integer customerPaymentProfileId = (Integer)innerBody.get('customerPaymentProfileId');

       

        string body;
        //this is where we add the request type
        //one way - set up multiple request types and have fiddly is test check
        //or if all the requests are properly wrapped - do it this way


         if(requestTypeString == DELETE_REQUEST_KEY)
         {
            //find out if value should be ok or error
            Boolean isErrorTest= AuthorizeDotNetClient.isIdInSampleList(customerPaymentProfileId);
            body = !isErrorTest? AuthorizeDotNetMockResponse.okDeletePaymentProfileResponseBody(): AuthorizeDotNetMockResponse.errorDeletePaymentProfileResponseBody();
            //set body to delete
         }
         else if(requestTypeString == 'updateCustomerPaymentProfileRequest'){
            //find out if value should be ok or error
            //set body to update
         }
         else if (requestTypeString == 'createCustomerPaymentProfileRequest'){
            //find out if value should be ok or error
            //set body to create
         }
         else if (requestTypeString == 'getCustomerPaymentProfileRequest'){
            //find out if value should be ok or error
            //set body to return one payment profile
         }
         else if (requestTypeString == 'getCustomerProfileRequest'){
            //find out if value should be ok or error
            //set body to return set of payment profiles
         }

         return body;
    }
    
    
    public String getEndpoint(){
        return endPoint;
    }
    
    public String getProtocol(){
        return protocol;
    }


    public static Boolean isIdInSampleList(Integer id){
        List<Integer> samplePaymentProfileIds = AuthorizeDotNetMockResponse.samplePaymentProfileIds();
            //default set to error
            Boolean isErrorTest = true;

            //if matching profile id is found set request type to success
            for (Integer sampleId : samplePaymentProfileIds){
                if (sampleId==id){
                    isErrorTest=false;
                }
            }
        return isErrorTest;
    }
    
    
    public static String getDomain(){
        Organization org = [SELECT Id, InstanceName, IsSandbox FROM Organization WHERE Id = :UserInfo.getOrganizationId()];
        
        return org.IsSandbox ? GATEWAY_SANDBOX_URL  : GATEWAY_PRODUCTION_URL;
    }

}