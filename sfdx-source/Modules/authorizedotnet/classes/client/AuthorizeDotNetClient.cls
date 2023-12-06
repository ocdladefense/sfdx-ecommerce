public class AuthorizeDotNetClient extends HttpClient {
      	
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
        breq.setHeader('X-Request-Type', requestType);
        breq.setBody(reqBody);
        
        if(null != req.getHeaders()) {
            for(String key : req.getHeaders().keySet()) {
                breq.setHeader(key, req.getHeader(key));
            }
        }


        // System.debug(breq.getBody());
        HttpResponse bresp = client.send(breq);

        //System.debug(bresp.getBody());
        
        String respBodyString = bresp.getBody().replace('\uFEFF', '');
        
        
        System.Type t = Type.forName(responseType);

        if(null == t) {
            System.debug('AUTHNET_CLIENT_WARNING: The client could not determine the appropriate type to deserialize the response.  Class `'+responseType+'` not found.');
            t = Type.forName('AuthorizeDotNetResponse');
        }

        AuthorizeDotNetResponse resp = (AuthorizeDotNetResponse)JSON.deserialize(respBodyString, t);
        resp.setBody(respBodyString);
        

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