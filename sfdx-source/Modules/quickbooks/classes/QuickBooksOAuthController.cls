/*
HttpRequest req = new HttpRequest();
req.setEndpoint('https://appcenter.intuit.com/connect/oauth2');
String clientId = 'ABmhzVOY4yX8b0GP4XiQHi6uApU2GSaLKqwnpH8lTUhUmDXdw7';
String clientSecret = 'IAavioKHTFwLc9TxUsVChH14kJyiDdlnwCtgt6Su';
// https://developer.api.intuit.com/.well-known/openid_sandbox_configuration
String scope = 'com.intuit.quickbooks.accounting';
String state = 'foobar';
Map<String,String> params = new Map<String,String>();
params.put('client_id',clientId);
params.put('scope',scope);
params.put('redirect_uri','my-url');
params.put('response_type','code');
params.put('state',state);
params.put('claims',null);
// https://appcenter.intuit.com/connect/oauth2?client_id=ABmhzVOY4yX8b0GP4XiQHi6uApU2GSaLKqwnpH8lTUhUmDXdw7&scope=com.intuit.quickbooks.accounting&redirect_uri=https://ocdla--ocdpartial.sandbox.my.salesforce.com/qb/integration/v1&response_type=code&state=foobar
*/

public with sharing class QuickBooksOAuthController {
    public QuickBooksOAuthController() {
        // Get the page parameters.
    }

    // Authorize the client to the authorization server.
    public PageReference doAuthorization() {
        PageReference authUrl ;//= new PageReference('https://appcenter.intuit.com/connect/oauth2?client_id=ABmhzVOY4yX8b0GP4XiQHi6uApU2GSaLKqwnpH8lTUhUmDXdw7&scope=com.intuit.quickbooks.accounting&redirect_uri=https://ocdla--ocdpartial.sandbox.my.salesforce.com/qb/integration/v1&response_type=code&state=foobar');

        return authUrl;
    }
}