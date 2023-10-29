public class AuthorizeDotNetClient extends HttpClient implements IPaymentGatewayClient, HttpCalloutMock{
      	
    //can be used in production and testing
    
	private static final Integer CALLOUT_TIMEOUT = 60000;
    
    private static final String endpoint = 'ccAuthorize';
    
    private static final String protocol = 'https'; 
    
    public static final String GATEWAY_SANDBOX_URL = 'membertest.ocdla.org';
    
    public static final String GATEWAY_PRODUCTION_URL = 'members.ocdla.org';
    
    private String url;

    private PaymentGatewayRequestType requestType;
    
    //copied to be like QuickBooksClient as private instance method
    //class would not deploy without value
    private String getAccessToken() {
        return 'foobar';
    }
    
    public AuthorizeDotNetClient() {
    }
    
    public AuthorizeDotNetClient(String url) {
        this.url = url;
    }
    
    @TestVisible
    public TransactionResponse send(TransactionRequest reqn){
        Http http = new Http();
        
        HttpRequest req = reqn.toHttpRequest();
        
        //Set HTTPRequest header properties
        req.setHeader('Host', getDomain());
        req.setEndpoint( 'https' + '://'+ getDomain()+'/'+'ccAuthorize');
        req.setTimeout(CALLOUT_TIMEOUT);
        // Execute web service call here	
     	
        HttpResponse resp = http.send(req);
        
        return TransactionResponse.newFromResponse(resp);
    } 
    //if sent a request message type 
    //do this which then will call send that takes a request type
    public override HttpResponseMessage send(HttpRequestMessage r) {
        System.debug('making a override request');
        Http client = new Http();
        HttpRequest req = r.getAsHttpRequest();
		req.setHeader('Authorization', 'Bearer '+this.getAccessToken());
        String cardsEndpoint = 'https://appdev.ocdla.org/customer/905372692/cards';
        req.setEndpoint(cardsEndpoint);
        req.setMethod('POST');
        //set the reqest type value based on the class
        HttpResponse resp = client.send(req);
  
        return new HttpResponseMessage(resp);
    }

    public HttpResponseMessage send(DeleteCustomerPaymentProfileRequest r) {
        System.debug('making a delete request');
        Http client = new Http();
        HttpRequest req = r.getAsHttpRequest();
		req.setHeader('Authorization', 'Bearer '+this.getAccessToken());
        System.debug('request method is ' + req.getMethod());

        //set the reqest type value based on the class
        //or if there is one method - deserialize the body one level to get the first key name
        this.requestType = PaymentGatewayRequestType.DELETE_CUSTOMER_PAYMENT_PROFILE;
        HttpResponse resp = client.send(req);
  
        return new HttpResponseMessage(resp);
    }
    
    
    public HttpResponse send(HttpRequest req) {

        Http client = new Http();
		
        return client.send(req);
    }
    
    public HttpResponse respond(HttpRequest req) {
  
        HttpResponse res = new HttpResponse();
        String cardsEndpoint = 'https://appdev.ocdla.org/customer/905372692/cards';
        res.setHeader('Content-Type', 'application/json');
        //String cardsEndpoint = 'https://appdev.ocdla.org/customer/905372692/cards';
        res.setHeader('Content-Type', 'application/json');
        //String cardsEndpoint = 'https://appdev.ocdla.org/customer/905372692/cards';
        
        string body;
        //this is where we add the request type
        System.debug(requestType);
        if (this.requestType ==PaymentGatewayRequestType.DELETE_CUSTOMER_PAYMENT_PROFILE){
            body = AuthorizeDotNetMockResponse.okDeletePaymentProfileResponseBody();
            //this is already a string
        }
        else if (this.requestType == PaymentGatewayRequestType.DELETE_CUSTOMER_PAYMENT_PROFILE_ERROR){
            body = AuthorizeDotNetMockResponse.errorDeletePaymentProfileResponseBody();
        }

        res.setBody(body);
        res.setStatusCode(200);
        res.setStatus('Apex generated Mock HttpResponse.');
        
        return res;
    }
    //where to put the logic that evaluates based on PaymentGateway RequestType?

    
    
    public String getEndpoint(){
        return endPoint;
    }
    
    public String getProtocol(){
        return protocol;
    }

    
    public static String getDomain(){
        Organization org = [SELECT Id, InstanceName, IsSandbox FROM Organization WHERE Id = :UserInfo.getOrganizationId()];
        
        return org.IsSandbox ? GATEWAY_SANDBOX_URL  : GATEWAY_PRODUCTION_URL;
    }

}