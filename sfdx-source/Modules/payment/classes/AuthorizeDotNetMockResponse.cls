@isTest
public class AuthorizeDotNetMockResponse implements HttpCalloutMock {

    private PaymentGatewayRequestType requestType;
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
    
        
        // Should we tell the person on the CC server side that a Map of Maps is SILLY.
        // Instead a List of Credit Card JSON objects will suffice for our purposes.
        // 
        // 
    public static Map<String,Map<String, String>> retrieveMockedCards(HttpRequest req) {
        


        // extract customer profile id from URL. 
        String reqEndpoint = req.getEndpoint();
        String customerProfileIdFromEndpoint = reqEndpoint.substringBetween('customer/','/cards');

        String hasSavePaymentProfiles = '905372692';
        String hasNoPaymentProfiles = 'abcd1234';
        // List <Map<string, string>> mockedCards = new List <Map<string, string>> {
        Map<String,String> cc1 = new Map<String, string>{'isDefault'=>'true', 'id'=>'905264262', 'cardNumber'=>'XXXX4532', 'expirationDate'=>'2024-08', 'cardType'=>'visa', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'};
        Map<String,String> cc2 = new Map<String, string>{'isDefault'=>'false', 'id'=>'905264263', 'cardNumber'=>'XXXX4632', 'expirationDate'=>'2023-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'};
        Map<String,String> cc3 = new Map<String, string>{'isDefault'=>'false', 'id'=>'905264264', 'cardNumber'=>'XXXX4786', 'expirationDate'=>'2043-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'};
        Map<String,String> cc4 = new Map<String, string>{'isDefault'=>'false', 'id'=>'905264265', 'cardNumber'=>'XXXX4912', 'expirationDate'=>'2025-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'};
		
        Map<String,Map<String,String>> cards = new Map<String,Map<String,String>>();
        cards.put('905264262', cc1);
        cards.put('905264263', cc2);
        cards.put('905264264', cc3);
        cards.put('905264265', cc4);
        

        return customerProfileIdFromEndpoint==hasSavePaymentProfiles ? cards : new Map<String,Map<String,String>>();
 
    }
    
    public AuthorizeDotNetMockResponse(TransactionResponseCode code) {
        this.responseCode = code;
        this.requestType = PaymentGatewayRequestType.SUBMIT_TRANSACTION;
    }

    public AuthorizeDotNetMockResponse(PaymentGatewayRequestType requestType) {
        this.requestType = requestType;
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
        String cardsEndpoint = 'https://appdev.ocdla.org/customer/905372692/cards';
        res.setHeader('Content-Type', 'application/json');
        //String cardsEndpoint = 'https://appdev.ocdla.org/customer/905372692/cards';
        res.setHeader('Content-Type', 'application/json');
        //String cardsEndpoint = 'https://appdev.ocdla.org/customer/905372692/cards';

        String body;
        if (requestType == PaymentGatewayRequestType.SUBMIT_TRANSACTION) {
            body = JSON.serialize(this.responseCode == TransactionResponseCode.SUCCESS ? TRANSACTION_RESPONSE_SUCCESS : TRANSACTION_RESPONSE_FAILURE);
        }
        else if (requestType == PaymentGatewayRequestType.GET_CUSTOMER_PAYMENT_PROFILES) {
            body = JSON.serialize(retrieveMockedCards(req));
            body = JSON.serialize(retrieveMockedCards(req));
        }
        else if (requestType == PaymentGatewayRequestType.PUT_CUSTOMER_PAYMENT_PROFILE) {
            body = JSON.serialize(putCustomerPaymentProfile());
            body = JSON.serialize(putCustomerPaymentProfile());
        }
    
    
        res.setBody(body);
        res.setStatusCode(200);
        res.setStatus('Apex generated Mock HttpResponse.');
        
        return res;
    }

    public String putCustomerPaymentProfile() {
        return '{"id": "123"}';
    }

    public static Map<String,Map<String, String>> retrieveMockedCards(HttpRequest req) {
        
        // extract customer profile id from URL. 
        String reqEndpoint = req.getEndpoint();
        String customerProfileIdFromEndpoint = reqEndpoint.substringBetween('customer/','/cards');

        String hasSavePaymentProfiles = '905372692';
        String hasNoPaymentProfiles = 'abcd1234';
        // List <Map<string, string>> mockedCards = new List <Map<string, string>> {
        Map<String,String> cc1 = new Map<String, string>{'isDefault'=>'true', 'id'=>'905264262', 'cardNumber'=>'XXXX4532', 'expirationDate'=>'2024-08', 'cardType'=>'visa', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'};
        Map<String,String> cc2 = new Map<String, string>{'isDefault'=>'false', 'id'=>'905264263', 'cardNumber'=>'XXXX4632', 'expirationDate'=>'2023-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'};
        Map<String,String> cc3 = new Map<String, string>{'isDefault'=>'false', 'id'=>'905264264', 'cardNumber'=>'XXXX4786', 'expirationDate'=>'2043-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'};
        Map<String,String> cc4 = new Map<String, string>{'isDefault'=>'false', 'id'=>'905264265', 'cardNumber'=>'XXXX4912', 'expirationDate'=>'2025-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'};
		
        Map<String,Map<String,String>> cards = new Map<String,Map<String,String>>();
        cards.put('905264262', cc1);
        cards.put('905264263', cc2);
        cards.put('905264264', cc3);
        cards.put('905264265', cc4);
        

        return customerProfileIdFromEndpoint==hasSavePaymentProfiles ? cards : new Map<String,Map<String,String>>();
 
    }

    public String sampleDeletePaymentProfileResponseBody(){
        return'{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}';
    }
    

}