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
    
    public static List <Map<String, string>> RetrieveMockedCards(){
        List <Map<string, string>> mockedCards = new List <Map<string, string>> {
            new Map<String, string>{'isDefault'=>'true', 'id'=>'905264262', 'cardNumber'=>'XXXX4532', 'expirationDate'=>'2024-08', 'cardType'=>'visa', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'},
                new Map<String, string>{'isDefault'=>'false', 'id'=>'905264263', 'cardNumber'=>'XXXX4632', 'expirationDate'=>'2023-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'},
                    new Map<String, string>{'isDefault'=>'false', 'id'=>'905264264', 'cardNumber'=>'XXXX4786', 'expirationDate'=>'2043-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'},
                        new Map<String, string>{'isDefault'=>'false', 'id'=>'905264265', 'cardNumber'=>'XXXX4912', 'expirationDate'=>'2025-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'}
        };
        return mockedCards;
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

        String body;
        if (requestType == PaymentGatewayRequestType.SUBMIT_TRANSACTION) {
            body = JSON.serialize(this.responseCode == TransactionResponseCode.SUCCESS ? TRANSACTION_RESPONSE_SUCCESS : TRANSACTION_RESPONSE_FAILURE);
        }
        else if (requestType == PaymentGatewayRequestType.GET_CUSTOMER_PAYMENT_PROFILES) {
            body = savedPaymentProfileResponseBody(req);
        }
        else if (requestType == PaymentGatewayRequestType.PUT_CUSTOMER_PAYMENT_PROFILE) {
            body = putCustomerPaymentProfile();
        }
    
        res.setBody(body);
        res.setStatusCode(200);
        res.setStatus('Apex generated Mock HttpResponse.');
        
        return res;
    }

    public String putCustomerPaymentProfile() {
        return '{"id": "123"}';
    }

    public String savedPaymentProfileResponseBodyList(HttpRequest req) {

        // extract customer profile id from URL. 
        String reqEndpoint = req.getEndpoint();
        String customerProfileIdFromEndpoint = reqEndpoint.substringBetween('customer/','/cards');

        String hasSavePaymentProfiles = '905372692';
        String hasNoPaymentProfiles = 'abcd1234';

        List <Map<string, string>> noPaymentProfiles = new List <Map<string, string>> {new Map<String, string> {'foo' => 'bar'}};
        noPaymentProfiles.clear();
        //in credit card Map<String,Map<String,String>>
        //old List <Map<string, string>>
        List <Map<string, string>> savedPaymentProfiles = new List <Map<string, string>> {
            new Map<String, string>{'isDefault'=>'true', 'id'=>'905264262', 'cardNumber'=>'XXXX4532', 'expirationDate'=>'2024-08', 'cardType'=>'visa', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'},
                new Map<String, string>{'isDefault'=>'false', 'id'=>'905264263', 'cardNumber'=>'XXXX4632', 'expirationDate'=>'2023-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'},
                    new Map<String, string>{'isDefault'=>'false', 'id'=>'905264264', 'cardNumber'=>'XXXX4786', 'expirationDate'=>'2043-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'},
                        new Map<String, string>{'isDefault'=>'false', 'id'=>'905264265', 'cardNumber'=>'XXXX4912', 'expirationDate'=>'2025-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'}
        };
        if (customerProfileIdFromEndpoint==hasSavePaymentProfiles){
            return  JSON.serialize(savedPaymentProfiles);
        }
        else{
            return JSON.serialize(noPaymentProfiles);
        }
    
    }

    public String savedPaymentProfileResponseBody(HttpRequest req) {

        // extract customer profile id from URL. 
        String reqEndpoint = req.getEndpoint();
        String customerProfileIdFromEndpoint = reqEndpoint.substringBetween('customer/','/cards');

        String hasSavePaymentProfiles = '905372692';
        String hasNoPaymentProfiles = 'abcd1234';

        Map<String,Map<String,String>> noPaymentProfiles = new Map<String,Map<String,String>>();
        //in credit card Map<String,Map<String,String>>
        //old List <Map<string, string>>
        Map<String,Map<String,String>> savedPaymentProfiles = new Map<String,Map<String,String>> {'905263202' => 
                new Map<String, string>{'isDefault'=>'true', 'id'=>'905264262', 'cardNumber'=>'XXXX4532', 'expirationDate'=>'2024-08', 'cardType'=>'visa', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'},
            '905264232' =>
                new Map<String, string>{'isDefault'=>'false', 'id'=>'905264263', 'cardNumber'=>'XXXX4632', 'expirationDate'=>'2023-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'},
            '905264237' =>
                new Map<String, string>{'isDefault'=>'false', 'id'=>'905264264', 'cardNumber'=>'XXXX4786', 'expirationDate'=>'2043-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'},
            '905264243'=>
                new Map<String, string>{'isDefault'=>'false', 'id'=>'905264265', 'cardNumber'=>'XXXX4912', 'expirationDate'=>'2025-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'}
        };
        if (customerProfileIdFromEndpoint==hasSavePaymentProfiles){
            return  JSON.serialize(savedPaymentProfiles);
        }
        else{
            return JSON.serialize(noPaymentProfiles);
        }
    
    }

    //static method to return a card with all fields having valid values
    public static CreditCard newCardAllValidValues(){
        CreditCard card = new CreditCard('4444222211111111', Date.newInstance(2026, 4, 1), '123');
        card.setFirstName('Charles');
        card.setLastName('Dickens');
        card.setEmail('cdickins@books.com');
        card.setFax('555-555-5555');
        card.setPhone('555-556-6666');
        card.setIsDefault(true);
        card.setBillingAddress('123 Tree St.');
        card.setBillingCity('Eugene');
        card.setBillingCountry('US');
        card.setBillingZip('OR');
        card.setBillingZip('97401');

        return card;
    } 
    

}