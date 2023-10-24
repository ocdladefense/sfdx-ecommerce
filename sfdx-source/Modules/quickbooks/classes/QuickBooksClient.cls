public with sharing class QuickBooksClient extends HttpClient {


    private String clientId;


    private String clientSecret;


    private String companyId = '4620816365342587500';

    
    private String getAccessToken() {
        return 'foobar';
    }

    
    public override HttpResponseMessage send(HttpRequestMessage r) {

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
    
    
    
    public QuickBooksClient(String clientId, String clientSecret) {
        this.clientId = clientId;
        this.clientSecret = clientSecret;
    }

    public String getClientId() {
        return this.clientId;
    }

    public String getClientSecret() {
        return this.clientSecret;
    }



    public HttpUrl getAuthorizationUrl(String redirect_uri) {
   
        HttpUrl authUrl = new HttpUrl('https://appcenter.intuit.com/connect/oauth2');
		authUrl.addParam('client_id', this.clientId);
        authUrl.addParam('scope', 'com.intuit.quickbooks.accounting');
        authUrl.addParam('redirect_uri', redirect_uri);
        authUrl.addParam('state','foobar');
        authUrl.addParam('claims',null);
        authUrl.addParam('response_type','code');

        return authUrl;
    }

    public HttpUrl getAuthorizationUrl() {
        Url instanceUri = Url.getOrgDomainUrl();
        String redirect_uri = instanceUri.toExternalForm() + '/apex/OAuth';
        
        return this.getAuthorizationUrl(redirect_uri);
    }

    public HttpRequest getRefreshTokenRequest(String refreshToken) {




        Map<String,String> params = new Map<String,String>();
        params.put('grant_type', 'refresh_token');
        params.put('refresh_token', refreshToken);

        HttpRequest req = new HttpRequest();



        String b64encoded = EncodingUtil.base64Encode(Blob.valueof(this.clientId + ':' + this.clientSecret));
        


        req.setHeader('Accept','application/json');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        req.setHeader('Authorization',  'Basic '+b64encoded);
        req.setBody(HttpUrl.encodeParams(params));
        req.setMethod('POST');
        req.setEndpoint('https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer');

        return req;
    }
    



    public HttpRequest getAccessTokenRequest(String authorization_code) {

        String redirect_uri = this.getAuthorizationUrl().toString();

        String b64encoded = EncodingUtil.base64Encode(Blob.valueof(this.clientId + ':' + this.clientSecret));
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer');
        req.setMethod('POST');
       	req.setHeader('Accept', 'application/json');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setHeader('Host', 'oauth.platform.intuit.com');
        req.setHeader('Authorization','Basic '+b64encoded);

        
        Map<String,String> requestParams = new Map<String,String>();
        requestParams.put('grant_type', 'authorization_code');
        requestParams.put('code', authorization_code);
        requestParams.put('redirect_uri', redirect_uri);
        
		req.setBody(HttpUrl.encodeParams(requestParams));

        return req;
    }
}