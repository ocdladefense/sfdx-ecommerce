public with sharing class CreateCustomerRequest {
    public CreateCustomerRequest() {
/*POST /v3/company/4620816365342587500/customer?minorversion=65

Content type:application/json
Production Base URL:https://quickbooks.api.intuit.com
Sandbox Base URL:https://sandbox-quickbooks.api.intuit.com
*/
    }

    public HttpRequest getAsHttpRequest(String accessToken) {
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type','application/json');
        req.setEndpoint('https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365342587500/customer?minorversion=65');

        Map<String,String> params = new Map<String,String>();
        params.put('GivenName','José');
        params.put('FamilyName','Bernal');
        req.setHeader('Authorization','bearer '+accessToken);
        String body = JSON.serialize(params);

        req.setBody(body);

        return req;
    }
}