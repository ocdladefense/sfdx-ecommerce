// See also, https://developer.intuit.com/app/developer/qbo/docs/develop/authentication-and-authorization/oauth-2.0

public class OAuthController {
    public OAuthController() {
        // Get the page parameters.
    }

    // Authorize the client to the authorization server.
    public PageReference init() {
        Map<String,String> params = ApexPages.currentPage().getParameters();
        PageReference resp = null;
		String clientId = 'ABmhzVOY4yX8b0GP4XiQHi6uApU2GSaLKqwnpH8lTUhUmDXdw7';
		String clientSecret = 'IAavioKHTFwLc9TxUsVChH14kJyiDdlnwCtgt6Su';

        Cache.Org.put('local.Default.clientId', clientId);
        Cache.Org.put('local.Default.clientSecret', clientSecret);

        String redirect_uri = 'https://energy-fun-599-dev-ed--c.scratch.vf.force.com/apex/OAuth';
        // String redirect_uri = 'https://ocdla--ocdpartial.sandbox.my.salesforce.com/OAuth';
        
        Url authUrl = new Url('https://appcenter.intuit.com/connect/oauth2');
		authUrl.addParam('client_id', clientId);
        authUrl.addParam('scope', 'com.intuit.quickbooks.accounting');
        authUrl.addParam('redirect_uri', redirect_uri);
        authUrl.addParam('state','foobar');
        authUrl.addParam('claims',null);
        authUrl.addParam('response_type','code');
        

        if(params.get('code') == null) {
            System.debug(authUrl.toString());
            return authUrl.getAsPageReference();
        }
        // https://fun-flow-9826-dev-ed--c.scratch.vf.force.com/apex/OAuth?
        // code=AB11694925875yfmW1CT32Ft7FDDyCgj1yysJ32v810JmbyFJO&
        // state=foobar&
        // realmId=4620816365342587500
        System.debug(params);
        String b64encoded = EncodingUtil.base64Encode(Blob.valueof(clientId + ':' + clientSecret));
        String authorization = 'Basic '+b64encoded;
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer');
        req.setMethod('POST');
       	req.setHeader('Accept', 'application/json');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setHeader('Host', 'oauth.platform.intuit.com');
        req.setHeader('Authorization',authorization);

        
        Map<String,String> requestParams = new Map<String,String>();
        requestParams.put('grant_type', 'authorization_code');
        requestParams.put('code',params.get('code'));
        requestParams.put('redirect_uri', redirect_uri);
        
		req.setBody(Url.encodeParams(requestParams));
        
        Http client = new Http();
        
        HttpResponse oauthResp = client.send(req);
        
        
        String body = oauthResp.getBody();

        Map<String,String> tokens = (Map<String,String>)JSON.deserialize(body,Map<String,String>.class);
        
        for(String key :tokens.keySet()) {
            System.debug(key + ': ' + tokens.get(key));
        }
        
        String accessToken = tokens.get('access_token');
        String refreshToken = tokens.get('refresh_token');

        Cache.Org.put('local.Default.accessToken',accessToken);
        Cache.Org.put('local.Default.refreshToken',refreshToken);

        return null;
    }
    
    // Authorize the client to the authorization server.
    public PageReference doAuthorization() {
        
        
        PageReference authUrl = new PageReference('https://appcenter.intuit.com/connect/oauth2?client_id=ABmhzVOY4yX8b0GP4XiQHi6uApU2GSaLKqwnpH8lTUhUmDXdw7&scope=com.intuit.quickbooks.accounting&redirect_uri=https://ocdla--ocdpartial.sandbox.my.salesforce.com/qb/integration/v1&response_type=code&state=foobar');

        return authUrl;
    }

    public static String getNewAccessToken() {
        String refreshToken = (String)Cache.Org.get('local.Default.refreshToken');
        String clientId = (String)Cache.Org.get('local.Default.clientId');
        String clientSecret = (String)Cache.Org.get('local.Default.clientSecret');

        Map<String,String> params = new Map<String,String>();
        params.put('grant_type', 'refresh_token');
        params.put('refresh_token', refreshToken);

        HttpRequestMessage req = new HttpRequestMessage();



        String b64encoded = EncodingUtil.base64Encode(Blob.valueof(clientId + ':' + clientSecret));
        String authorization = 'Basic '+b64encoded;


        req.setHeader('Accept','application/json');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        req.setHeader('Authorization', authorization);
        req.setBody(params);
        req.setMethod('POST');
        req.setEndpoint('https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer');

        QuickBooksSandboxClient client = new QuickBooksSandboxClient();

        HttpResponseMessage resp = client.send(req);
        System.debug(resp.getHeader('Content-Type'));
        System.debug(resp.getBody());
        Map<String,String> body = (Map<String,String>)resp.getBodyAsMap();

        String accessToken = body.get('access_token');

        Cache.Org.put('local.Default.accessToken',accessToken);  
        
        return accessToken;
    }
}