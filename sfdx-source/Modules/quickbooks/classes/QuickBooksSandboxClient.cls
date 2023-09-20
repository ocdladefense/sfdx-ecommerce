public class QuickBooksSandboxClient extends HttpClient {

    public static final Map<String,String> endpoints = new Map<String,String>{
        'well_known_endpoint' => 'https://developer.api.intuit.com/.well-known/openid_sandbox_configuration',
        'issuer' => 'https://oauth.platform.intuit.com/op/v1',
        'authorization_endpoint' => 'https://appcenter.intuit.com/connect/oauth2',
        'token_endpoint' => 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer',
        'userinfo_endpoint' => 'https://sandbox-accounts.platform.intuit.com/v1/openid_connect/userinfo',
        'revocation_endpoint' => 'https://developer.api.intuit.com/v2/oauth2/tokens/revoke',
        'jwks_uri' => 'https://oauth.platform.intuit.com/op/v1/jwks'
    };
  

    public QuickbooksSandboxClient() {

    }
}