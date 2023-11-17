public class AuthorizeDotNetClient extends HttpClient implements IPaymentGatewayClient {
      	
    //can be used in production and testing
    
	private static final Integer CALLOUT_TIMEOUT = 60000;
    
    private static final String endpoint = 'ccAuthorize';
    
    private static final String protocol = 'https'; 
    
    public static final String GATEWAY_SANDBOX_URL = 'membertest.ocdla.org';
    
    public static final String GATEWAY_PRODUCTION_URL = 'members.ocdla.org';


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
     	System.debug('From send req is ' + req);
        HttpResponse resp = http.send(req);
        
        return TransactionResponse.newFromResponse(resp);
    } 



public AuthorizeDotNetResponse send(AuthorizeDotNetRequest req) {
       
        Http client = new Http();

        String requestType = req.getRequestType();
        String responseType = requestType.capitalize()+'Response';
       
        // We have to get the body *before we apply other properties.
        // Otherwise, endpoing, method and headers will be serialized.
        // (and we don't want that).
        String reqBody = req.getBody();

        // System.debug(reqBody);


        HttpRequest breq = new HttpRequest();
        breq.setEndpoint('https://apitest.authorize.net/xml/v1/request.api');
        breq.setMethod('POST');
        breq.setHeader('Content-Type', 'application/json');
        breq.setHeader('X-Response-Type', responseType);
        breq.setBody(reqBody);
        
        if(null != req.getHeaders()) {
            for(String key : req.getHeaders().keySet()) {
                breq.setHeader(key, req.getHeader(key));
            }
        }


        // System.debug(breq.getBody());
        HttpResponse bresp = client.send(breq);

        // System.debug(bresp.getBody());
        String respBodyString = bresp.getBody().replace('\uFEFF', '');
        
        System.debug(respBodyString);
        // //inspect the specific type of request to know what to do.
        // //the generic step - an authorizedotnetresponse rather than a specific kind 
        //AuthorizeDotNetResponse resp = new AuthorizeDotNetResponse(respBodyString);
        // DeleteCustomerPaymentProfile
        
        System.Type t = Type.forName(responseType);

        if(null == t) {
            throw new AuthorizeDotNetException('RESPONSE_ERROR: The client could not determine the appropriate type to deserialize the response ('+responseType+')');
        }

        AuthorizeDotNetResponse resp = (AuthorizeDotNetResponse)JSON.deserialize(respBodyString, t);

        

        return resp;
    }
    
    
    public HttpResponse send(HttpRequest req) {

        Http client = new Http();
        return client.send(req);
    }
    


    public String getEndpoint(){
        return endPoint;
    }
    
    public String getProtocol(){
        return protocol;
    }
    
    public static String getDomain(){
        Organization org = [SELECT Id, InstanceName, IsSandbox FROM Organization WHERE Id = :UserInfo.getOrganizationId()];
        
        return org.IsSandbox ? GATEWAY_SANDBOX_URL  : GATEWAY_PRODUCTION_URL;
    }


}