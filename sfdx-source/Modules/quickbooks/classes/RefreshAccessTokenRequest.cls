public class RefreshAccessTokenRequest extends HttpRequestMessage {
    
    public RefreshAccessTokenRequest(String accessToken, String refreshToken) {
/*POST /v3/company/4620816365342587500/customer?minorversion=65

Content type:application/json
Production Base URL:https://quickbooks.api.intuit.com
Sandbox Base URL:https://sandbox-quickbooks.api.intuit.com
*/
        this.setMethod('POST');
        this.setHeader('Content-Type','application/x-www-urlform-encoded');
        this.setEndpoint('https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365342587500/customer?minorversion=65');

        this.setHeader('Authorization','Basic '+accessToken);
        this.setHeader('Accept','application/json');


        Map<String,String> params = new Map<String,String>();
        params.put('refresh_token', refreshToken);
        // params.put('FamilyName','Bernal');


        this.setBody(body);
    }


}
