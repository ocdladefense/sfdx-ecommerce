public class AuthorizeDotNetClient extends HttpClient implements IPaymentGatewayClient {
      	
    //can be used in production and testing
    
	private static final Integer CALLOUT_TIMEOUT = 60000;
    
    private static final String endpoint = 'ccAuthorize';
    
    private static final String protocol = 'https'; 
    
    public static final String GATEWAY_SANDBOX_URL = 'membertest.ocdla.org';
    
    public static final String GATEWAY_PRODUCTION_URL = 'members.ocdla.org';

    public static final String DELETE_REQUEST_KEY = 'deleteCustomerPaymentProfileRequest';


    public static final Map<String, String> MERCHANT_AUTHENTICATION = new Map<String, String>{ 
        'name'=> '6gSVxaYj397',
        'transactionKey'=> '6FR49pDH5Jjum58g'
    };

    private String url;
    
    
    
    public AuthorizeDotNetClient() {
        
    }
    
    //copied to be like QuickBooksClient as private instance method
    //class would not deploy without value
    private String getAccessToken() {
        return 'foobar';
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
    /*
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
    */


    public AuthorizeDotNetResponse send(AuthorizeDotNetRequest req) {
       
        Http client = new Http();

        String xRequestType=req.getRequestType();
        String payloadRequestType = xRequestType.uncapitalize();
        payloadRequestType+='Request';

        req.setHeader('X-Request-Type', xRequestType);
        req.prepend('merchantAuthentication', MERCHANT_AUTHENTICATION);
        req.wrap(payloadRequestType);
        
        req.setMethod('POST');
        req.setEndpoint('https://apitest.authorize.net/xml/v1/request.api');
        req.setHeader('Content-Type', 'application/json');
        
        //then convert to this saleforce
        HttpRequest breq = req.getAsHttpRequest();

        HttpResponse bresp = client.send(breq);
  
        //inspect the specific type of request to know what to do.
        AuthorizeDotNetResponse resp = AuthorizeDotNetResponse.newFromRequestType(req.getHeader('X-Request-Type'));
        
        
        resp.setBody(bresp.getBody());
        // AuthorizeDotNetResponse authResp = AuthorizeDotNetClient.getInstanceOfResponse(r);
        // authResp.setBody(resp.getBody());
        resp.deserialize();

        return resp;
    }
    
    
    public HttpResponse send(HttpRequest req) {

        Http client = new Http();
        return client.send(req);
    }
    


    public static AuthorizeDotNetResponse getInstanceOfResponse(AuthorizeDotNetRequest r){
        
        /*
        if (r instanceof CreateCustomerPaymentProfileRequest) {
            return new CreateCustomerPaymentProfileResponse();
        }
        */

        return new AuthorizeDotNetResponse();
    }

    public static AuthorizeDotNetResponse getInstanceOfResponse(CreateCustomerPaymentProfileRequest r){


        return new CreateCustomerPaymentProfileResponse();




    }

    public String getEndpoint(){
        return endPoint;
    }
    
    public String getProtocol(){
        return protocol;
    }

    /*
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
    */
    
    
    public static String getDomain(){
        Organization org = [SELECT Id, InstanceName, IsSandbox FROM Organization WHERE Id = :UserInfo.getOrganizationId()];
        
        return org.IsSandbox ? GATEWAY_SANDBOX_URL  : GATEWAY_PRODUCTION_URL;
    }


}