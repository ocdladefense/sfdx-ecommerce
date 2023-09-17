public class AuthorizeDotNetClient {
    
    public Map<String, String> params {get;public set;}

	public static final Integer CALLOUT_TIMEOUT = 60000;
    
    public final String endpoint = 'ccAuthorize';
    
    public final String protocol = 'https'; 
    
    private String url;
    
    public AuthorizeDotNetClient(String url) {
        this.url = url;
    }
    
    @TestVisible
    public String formatResponse(HttpResponse resp){
        return resp.getBody();
    }
    
    public String getEndpoint(){
        return this.EndPoint;
    }
    
    public String getProtocol(){
        return this.protocol;
    }
    
    public String formatPostBody(String fieldName,String fieldValue){
        return fieldName+'='+EncodingUtil.urlEncode(fieldValue, 'UTF-8');
    }
    
	// parameter acts like a clone()    
    public String formatPostBody(Map<String,String> ccVals){
        List<String> postBody = new List<String>();
        
        for(String key: ccVals.keySet()) {
            if('' == key) continue;
            if(null == ccVals.get(key)) continue;
            postBody.add(key+'='+EncodingUtil.urlEncode(ccVals.get(key), 'UTF-8'));
        }

        return String.join(postBody,'&');                 
    }
    
    public HttpRequest buildRequest(Map<String, String> params) {
        // Create a map to be converted to JSON
        HttpRequest req = new HttpRequest(); 
        
        //Set HTTPRequest Method
        req.setMethod('POST');
        req.setTimeout(CALLOUT_TIMEOUT);
        
        //Set HTTPRequest header properties
        req.setHeader('Host', OcdlaCCAuthorize.getDomain());
        req.setEndpoint( 'https' + '://'+ OcdlaCCAuthorize.getDomain()+'/'+'ccAuthorize');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
        // Set the HTTPRequest body	
        String body = OcdlaCCAuthorize.formatPostBody(params);
        req.setBody(body);
        
        return req;
    }
    
    @TestVisible
    public Map<String, String> send(HttpRequest req){
        Http http = new Http();
        
        // Execute web service call here	
     	
        HttpResponse resp = http.send(req);
        
        return (Map<String, String>) JSON.Deserialize(resp.getBody(), Map<String, String>.class);
    } 
}