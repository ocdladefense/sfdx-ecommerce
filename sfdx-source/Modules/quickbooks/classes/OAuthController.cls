// See also, https://developer.intuit.com/app/developer/qbo/docs/develop/authentication-and-authorization/oauth-2.0

public class OAuthController {

    // Do not expose these values to the ViewState.
    private transient String clientId = 'ABmhzVOY4yX8b0GP4XiQHi6uApU2GSaLKqwnpH8lTUhUmDXdw7';

    // Do not expose these values to the ViewState.
    private transient String clientSecret = 'IAavioKHTFwLc9TxUsVChH14kJyiDdlnwCtgt6Su';




    public OAuthController() {
        // Get the page parameters.
        Cache.Org.put('local.Default.clientId', this.clientId);
        Cache.Org.put('local.Default.clientSecret', this.clientSecret);
    }

    // When the browser loads the page, check the URL for an Authorization Code.
    // The Authorization Code is required to obtain an Access Token.
    public PageReference onBrowserLoad() {
        
        PageReference self = ApexPages.currentPage();
        PageReference resp = null;
        Map<String,String> params = self.getParameters();
        
        String authorizationCode = params.get('code');
        String state = params.get('state');
        
        // Don't leave sensitive parameters in the address bar.    
        params = null;
        
        if(authorizationCode == null) {
            return null;
        }
        
        try {
                 
            String clientId = (String)Cache.Org.get('local.Default.clientId');
            String clientSecret = (String)Cache.Org.get('local.Default.clientSecret');
            QuickBooksClient client = new QuickBooksClient(clientId, clientSecret);
    
            // Otherwise, assuming we are going to request an Access Token.
            System.debug(params);
    
            Map<String,String> tokens = exchangeAuthorizationCodeForAccessToken(authorizationCode);
            
            String accessToken = tokens.get('access_token');
            String refreshToken = tokens.get('refresh_token');
    
            Cache.Org.put('local.Default.accessToken',accessToken);
            Cache.Org.put('local.Default.refreshToken',refreshToken);
  
        } catch(Exception e) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage());
            ApexPages.addMessage(myMsg);
                
        }
        
        resp = new PageReference('/apex/OAuth?status=0');
        resp.setRedirect(True);
        
        return resp;
    }
      
    
    // Authorize the client to the authorization server.
    public PageReference init() {
        Map<String,String> params = ApexPages.currentPage().getParameters();
        
        String clientId = (String)Cache.Org.get('local.Default.clientId');
        String clientSecret = (String)Cache.Org.get('local.Default.clientSecret');
        QuickBooksClient client = new QuickBooksClient(clientId, clientSecret);


        PageReference resp = null;

        String authorizationCode = params.get('code');


        Url instanceUri = Url.getOrgDomainUrl();
        String redirect_uri = instanceUri.toExternalForm() + '/apex/OAuth';
		System.debug(redirect_uri);
        
        if(authorizationCode == null) {
            HttpUrl authUrl = client.getAuthorizationUrl(redirect_uri);
            System.debug(authUrl.toString());
            return authUrl.getAsPageReference();
        }

		return null;
    }
    


    public PageReference refreshAccessToken() {
        String accessToken = getNewAccessToken();
        

        Cache.Org.put('local.Default.accessToken',accessToken);  

        return null;
    }




    public Map<String,String> exchangeAuthorizationCodeForAccessToken(String authorizationCode) {

        QuickBooksClient client = new QuickBooksClient(this.clientId, this.clientSecret);

        HttpRequest req = client.getAccessTokenRequest(authorizationCode);
        
      
        
        HttpResponse oauthResp = client.send(req);
        
        
        String body = oauthResp.getBody();

        Map<String,String> tokens = (Map<String,String>)JSON.deserialize(body,Map<String,String>.class);
        
        for(String key :tokens.keySet()) {
            System.debug(key + ': ' + tokens.get(key));
        }
        
        return tokens;
    }



    public String getNewAccessToken() {

        String refreshToken = (String)Cache.Org.get('local.Default.refreshToken');
        // String clientId = (String)Cache.Org.get('local.Default.clientId');
        // String clientSecret = (String)Cache.Org.get('local.Default.clientSecret');

        QuickBooksClient client = new QuickBooksClient(this.clientId, this.clientSecret);

        HttpRequest req = client.getRefreshTokenRequest(refreshToken);

        HttpResponse resp = client.send(req);
        
        String body = resp.getBody();
        System.debug(resp.getHeader('Content-Type'));
        System.debug(resp.getBody());
        
        Map<String,String> theMap = (Map<String,String>)JSON.deserialize(body,Map<String,String>.class);

        return theMap.get('access_token');
    }
    
    
    
}