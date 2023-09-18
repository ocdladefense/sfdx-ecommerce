public class OcdlaCCTransaction {
    
    public final String protocol = 'https';
    
    public String domain;  
    
    public final String endpoint = 'ccAuthorize';
    
    public HttpResponse res {get;private set;}
    
    public String response {get;private set;}
    
    public static final Integer CALLOUT_TIMEOUT = 60000;
    
    public Map<String,String> params {get;private set;}
    
    public Map<String,String> resp;
    
    private String TransactionResponse;
    
    private static final String TRANSACTION_SUCCESS = '1'; // failure if not transaction_success
    
    public static Map<String, String> getOrderData(Decimal amount, Map<String,String> ccData, String orderNumber, Map<String,String> billingData, Map<String,String> shippingData) {
        if (null == shippingData) {
            shippingData = new Map<String, String>();
        }
        
        if (null == billingData) {
            billingData = new Map<String, String>();
        }
        
        if (null == orderNumber) {
            orderNumber = '';
        }
        
        Map<String, String> params = new Map<String, String> {
		'OrderNumber' => orderNumber,
		
		'amount' => String.valueOf(amount),
		
		'AuthorizeDotNetCustomerProfileId__c' => '',
		'authNetPaymentProfileDescription' => '',
		'authNetPaymentProfileId' => '',
		'authNetCreatePaymentProfile' => 'false',
        
		'BillingFirstName' => billingData.get('firstName'),
		'BillingLastName' => billingData.get('lastName'),
		'BillingStreet' => billingData.get('street'),
		'BillingCity' => billingData.get('city'),
		'BillingStateCode' => billingData.get('stateCode'),
		'BillingPostalCode' => billingData.get('postalCode'),
		'BillingEmail' => billingData.get('email'),
		'BillingCountryCode' => billingData.get('countryCode'),
		
		'ShippingStreet' => shippingData.get('street'),
		'ShippingCity' => shippingData.get('city'),
		'ShippingStateCode' => shippingData.get('stateCode'),
		'ShippingPostalCode' => shippingData.get('postalCode'),
		'ShippingCountryCode' => shippingData.get('countryCode'),
		
		'ccNum' => ccData.get('ccNum'),
		'ccExp' => ccData.get('ccExp'),
		'ccCode' => ccData.get('ccCode')
        };
            return params;
    }
    
    /*
    public void foobarBackup() {
        Map<String, String> params = new Map<String, String> {
		'AccountId' => order.AccountId,
		'ContactId' => order.BillToContactId,
		
		'OpportunityId' => order.OpportunityId,
		'shoppingCartSummary' => cartSummary,
		
		'Id' => '',
		'OrderId' => order.Id,
		'OrderNumber' => order.OrderNumber,
		'OrderStatus' => order.Status,
		'Description' => cartSummary,
		'Origin__c' => '',
		'PostingEntity__c' => '',
		'Payment_Info__c' => '',
		
		'amount' => String.valueOf(opp.Amount),
		'TotalAmount' => String.valueOf(opp.Amount),
		
		'AuthorizeDotNetCustomerProfileId__c' => '',
		'authNetPaymentProfileDescription' => '',
		'authNetPaymentProfileId' => '',
		'authNetCreatePaymentProfile' => 'false',

		'BillToContactId' => order.BillToContactId,
		'FirstName' => billingData.get('firstName'),
		'LastName' => billingData.get('lastName'),
		'Email' => billingData.get('email'),
		'BillingFirstName' => billingData.get('firstName'),
		'BillingLastName' => billingData.get('lastName'),
		'BillingStreet' => billingData.get('street'),
		'BillingCity' => billingData.get('city'),
		'BillingStateCode' => billingData.get('stateCode'),
		'BillingPostalCode' => billingData.get('postalCode'),
		'BillingEmail' => billingData.get('email'),
		'BillingCountryCode' => billingData.get('countryCode'),
		
		'ShipToContactId' => order.ShipToContactId,
		'ShippingStreet' => shippingData.get('street'),
		'ShippingCity' => shippingData.get('city'),
		'ShippingStateCode' => shippingData.get('stateCode'),
		'ShippingPostalCode' => shippingData.get('postalCode'),
		'ShippingCountryCode' => shippingData.get('countryCode'),
		'sameShipping' => 'true',
		
		'ccNum' => ccData.get('num'),
		'ccExp' => ccData.get('exp'),
		'ccCode' => ccData.get('code')
        };
    }
	*/
    
    public OcdlaCCTransaction() {
        // this.params = ApexPages.CurrentPage().getParameters();
        /*
        // Create a map to be converted to JSON
        HttpRequest req = new HttpRequest(); 
        
        //Set HTTPRequest Method
        req.setMethod('POST');
        req.setTimeout(CALLOUT_TIMEOUT);
        
        //Set HTTPRequest header properties
        req.setHeader('Host', OcdlaCCTransaction.getDomain());
        req.setEndpoint( 'https' + '://'+ OcdlaCCTransaction.getDomain()+'/'+'ccAuthorize');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
        // Set the HTTPRequest body	
        String body = OcdlaCCAuthorize.formatPostBody();
        req.setBody(body);
        
        HttpResponse res = OcdlaCCAuthorize.send(req);
        
        this.response = this.formatResponse(this.res);
		*/
    }
    
    public void setResponse(Map<String,String> newResponse) {
        this.resp = newResponse;
    }
    
    // Customer has input all data fields.
    public static OcdlaCCTransaction doPayment(Decimal amount, Map<String,String> ccData, String orderNumber, Map<String,String> billingData, Map<String,String> shippingData) {
        // create params map and merge all maps into it
        Map<String, String> params = OcdlaCCTransaction.getOrderData(amount, ccData, orderNumber, billingData, shippingData);
        
        // construct new instance of OcdlaCCAuthorize()
        // set instance params to newly merged map
        OcdlaCCTransaction transact = new OcdlaCCTransaction();
        
        String domain = OcdlaCCTransaction.getDomain();
        
        AuthorizeDotNetClient client = new AuthorizeDotNetClient(domain);
        
        HttpRequest req = client.buildRequest(params);
        
        // authorizeClient.setBody(params);
        
        Map<String, String> resp = client.send(req);
        
        transact.setResponse(resp);
        
        String transactionCode = resp.get('TransactionResponseCode');
        
        transact.setTransactionResponse(transactionCode);
        
        return transact;
    }
    
    // Customer didn't input extra shipping data; exclude from doPayment.
    public static OcdlaCCTransaction doPayment(Decimal amount, Map<String,String> ccData, String orderNumber, Map<String,String> billingData) {
        return OcdlaCCTransaction.doPayment(amount, ccData, orderNumber, billingData, null);
    }
    
    // Customer used saved cc; exclude billingData and shippingData.
    public static OcdlaCCTransaction doPayment(Decimal amount, Map<String,String> ccData, String orderNumber) {
        return OcdlaCCTransaction.doPayment(amount, ccData, orderNumber, null, null);
    }
    
    // Customer used saved cc; exclude billingData and shippingData, and no order to process.
    public static OcdlaCCTransaction doPayment(Decimal amount, Map<String,String> ccData) {
        return OcdlaCCTransaction.doPayment(amount, ccData, null, null, null);
    }
    
    public void setTransactionResponse(String code) {
        this.TransactionResponse = code;
    }
    
    public Map<String,String> getResponse() {
        return this.resp;
    }
    
    public static String getDomain(){
        Organization org = [SELECT Id, InstanceName, IsSandbox FROM Organization WHERE Id = :UserInfo.getOrganizationId()];
        
        Ocdla_Apps__c profileSettings = Ocdla_Apps__c.getValues(UserInfo.getUserId());
        Ocdla_Apps__c orgDefaults = Ocdla_Apps__c.getOrgDefaults();
        
        return org.IsSandbox ? orgDefaults.Ocdla_Test_Application_Server__c : orgDefaults.Ocdla_Production_Application_Server__c;
    }
    
    public Boolean Success() {
        return this.TransactionResponse == TRANSACTION_SUCCESS;
    }
    
    public String GetTransactionResponse() {
        return this.TransactionResponse;
    }
    
    // Perform any alterations to the params that will be sent to the url.
    public Map<String,String> getParams(){
        return this.params;
    }  
    
    public Map<String,String> setParams(Map<String,String> passed){
        this.params = passed.clone();
        return this.params;
    }
    
    public String getProtocol(){
        return this.protocol;
    }
    
    public String getEndpoint(){
        return this.endpoint;
    }
    
    @TestVisible
    public String formatResponse(HttpResponse resp){
        return resp.getBody();
    }
    
    public static String formatPostBody(Map<String,String> ccVals){
        List<String> postBody = new List<String>();
        
        for(String key: ccVals.keySet()) {
            if('' == key) continue;
            if(null == ccVals.get(key)) continue;
            postBody.add(key+'='+EncodingUtil.urlEncode(ccVals.get(key), 'UTF-8'));
        }

        return String.join(postBody,'&');                 
    }
    
    /* Previous version of send()
    @TestVisible
    virtual HttpResponse send(){
        // Create a map to be converted to JSON
        HttpRequest req = new HttpRequest(); 
        
        //Set HTTPRequest Method
        req.setMethod('POST');
        req.setTimeout(CALLOUT_TIMEOUT);
        
        //Set HTTPRequest header properties
        req.setHeader('Host',this.getDomain());
        req.setEndpoint( 'https' + '://'+this.getDomain()+'/'+'ccAuthorize');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
        // Set the HTTPRequest body	
        String body = ClickpdxHttpCallout.formatPostBody(this.getParams());
        req.setBody(body); 	
        
        Http http = new Http();
        
        // Execute web service call here		
        return http.send(req);	
    } 
	*/
    
    @TestVisible
    public static HttpResponse send(HttpRequest req){
        Http http = new Http();
        
        // Execute web service call here		
        return http.send(req);	
    } 
    
}