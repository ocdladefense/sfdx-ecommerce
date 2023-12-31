public class CreateCustomerRequest extends HttpRequestMessage {
    public CreateCustomerRequest() {
/*POST /v3/company/4620816365342587500/customer?minorversion=65

Content type:application/json
Production Base URL:https://quickbooks.api.intuit.com
Sandbox Base URL:https://sandbox-quickbooks.api.intuit.com
*/
        this.setMethod('POST');
        this.setHeader('Content-Type','application/json');
        this.setEndpoint('https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365342587500/customer?minorversion=65');

        Map<String,String> params = new Map<String,String>();
        params.put('GivenName','José');
        params.put('FamilyName','Bernal');

        
        String body = JSON.serialize(params);

        this.setBody(body);
    }


}