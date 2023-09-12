@isTest
public class AuthorizeDotNetMockResponse implements HttpCalloutMock {

    
    private final TransactionResponseCode responseCode;
    
    private static final Map<String,String> TRANSACTION_RESPONSE_SUCCESS = new Map<String,String>{
		'TransactionResponseCode' => '1',
         'TransactionResponseAuthorizationCode' => 'ZR7LJM',
            'TransactionResponseId' => '120002081234',
            'TransactionResponseMessageCode' => '1',
            'TransactionResponseDescription' => 'This transaction has been approved.',
            'AuthorizeDotNetCustomerProfileId__c' => '911366382',
            'OrderNumber' => '00016248',
             'OrderSummary' => 'Books Online Subscription',
            'ApiEndpointName' => 'ApiEndpointSandbox'
    };
        
    private static final Map<String,String> TRANSACTION_RESPONSE_FAILURE = new Map<String,String>{
		'TransactionResponseCode' => '2',
         'TransactionResponseAuthorizationCode' => 'ZR7LJM',
            'TransactionResponseId' => '120002081234',
            'TransactionResponseMessageCode' => '1',
            'TransactionResponseDescription' => 'This transaction has been declined.',
            'AuthorizeDotNetCustomerProfileId__c' => '911366382',
            'OrderNumber' => '00016248',
             'OrderSummary' => 'Books Online Subscription',
            'ApiEndpointName' => 'ApiEndpointSandbox'
    };
    

    
    public AuthorizeDotNetMockResponse(TransactionResponseCode code) {
        this.responseCode = code;
    }
    
    public HttpResponse respond(HttpRequest req) {
        // Create a fake response.
        // Set response values, and 
        // return response.
        // Create a fake response

        // Optionally, only send a mock response for a specific endpoint
        // and method.
        // System.assertEquals('http://api.salesforce.com/foo/bar', req.getEndpoint());
        // System.assertEquals('GET', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String body = JSON.serialize(this.responseCode == TransactionResponseCode.SUCCESS ? TRANSACTION_RESPONSE_SUCCESS : TRANSACTION_RESPONSE_FAILURE);
	
        res.setBody(body);
        res.setStatusCode(200);
        res.setStatus('Apex generated Mock HttpResponse.');
        
        return res;
    }
    

}