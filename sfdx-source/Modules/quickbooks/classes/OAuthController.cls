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
        String redirect_uri = 'https://fun-flow-9826-dev-ed--c.scratch.vf.force.com/apex/OAuth';
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
        requestParams.put('redirect_uri', 'https://fun-flow-9826-dev-ed--c.scratch.vf.force.com/apex/OAuth');
        
		req.setBody(Url.encodeParams(requestParams));
        
        Http client = new Http();
        
        HttpResponse oauthResp = client.send(req);
        
        
        String body = oauthResp.getBody();
        System.debug(body);
        
        return null;
    }
    
    // Authorize the client to the authorization server.
    public PageReference doAuthorization() {
        
        
        PageReference authUrl = new PageReference('https://appcenter.intuit.com/connect/oauth2?client_id=ABmhzVOY4yX8b0GP4XiQHi6uApU2GSaLKqwnpH8lTUhUmDXdw7&scope=com.intuit.quickbooks.accounting&redirect_uri=https://ocdla--ocdpartial.sandbox.my.salesforce.com/qb/integration/v1&response_type=code&state=foobar');

        return authUrl;
    }
}