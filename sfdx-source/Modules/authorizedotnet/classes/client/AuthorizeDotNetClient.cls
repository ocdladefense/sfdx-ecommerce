public class AuthorizeDotNetClient extends HttpClient {
    
	private static final Integer CALLOUT_TIMEOUT = 60000;
    
    
    
    public AuthorizeDotNetClient() {}
    





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
        breq.setHeader('X-Request-Type', requestType);
        breq.setHeader('X-Response-Type', responseType);
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

        Object forFormat = JSON.deserializeUntyped(respBodyString);
        String formatted = JSON.serializePretty(forFormat);

        AuthorizeDotNetResponse resp = (AuthorizeDotNetResponse)JSON.deserialize(formatted, t);
        resp.setBody(formatted);
        

        return resp;
    }
    
    
    public HttpResponse send(HttpRequest req) {

        Http client = new Http();
        return client.send(req);
    }
    


    /*
    public static String getDomain(){
        Organization org = [SELECT Id, InstanceName, IsSandbox FROM Organization WHERE Id = :UserInfo.getOrganizationId()];
        
        return org.IsSandbox ? GATEWAY_SANDBOX_URL  : GATEWAY_PRODUCTION_URL;
    }
    */

}