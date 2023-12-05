
@isTest
public class AuthorizeDotNetMock {

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
    
    public AuthorizeDotNetMock(TransactionResponseCode code) {
        this.responseCode = code;
        this.requestType = PaymentGatewayRequestType.SUBMIT_TRANSACTION;
    }

    public AuthorizeDotNetMock(PaymentGatewayRequestType requestType) {
        this.requestType = requestType;
    }
    
    public String getBody(HttpRequest req) {
       
        String body;
    
        return body;
    }
    public HttpResponse respond(HttpRequest req) {
        // Create a fake response.
        // Set response values, and 
        // return response.
        // Create a fake response

        // Optionally, only send a mock response for a specific endpoint
        // and method.
        
        HttpResponse res = new HttpResponse();
        String cardsEndpoint = 'https://appdev.ocdla.org/customer/905372692/cards';
        res.setHeader('Content-Type', 'application/json');
        //String cardsEndpoint = 'https://appdev.ocdla.org/customer/905372692/cards';
        res.setHeader('Content-Type', 'application/json');
        //String cardsEndpoint = 'https://appdev.ocdla.org/customer/905372692/cards';

        String body;
        
    
    
        res.setBody(body);
        res.setStatusCode(200);
        res.setStatus('Apex generated Mock HttpResponse.');
        
        return res;
    }

    public static String okDeletePaymentProfileResponseBody(){
        return'{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}';
    }

    public static String errorDeletePaymentProfileResponseBody(){
        return'{"messages":{"resultCode":"Error","message":[{"code":"E00105","text":"The specified payment profile is associated with an active or suspended subscription and cannot be deleted"}]}}';
    }
    /*
    public static CustomerPaymentProfile sampleCustomerPaymentProfile(){
        String customerProfileId= 905372692;
        Integer customerPaymentProfileId =905264262;
        CreditCard card = new CreditCard('123456789', Date.newInstance(2026, 8, 1));
        Address billToAddress = new Address('mara', 'williams', 'blah 123', 'eugene', 'oregon', '97454');
        CustomerPaymentProfile profile = new CustomerPaymentProfile(card, billToAddress);
        profile.setCustomerPaymentProfileId(customerPaymentProfileId);
        return profile;
    }*/
/*
    public static List<CustomerPaymentProfile> sampleCustomerPaymentProfileList(){
        List<CustomerPaymentProfile> profiles = new List<CustomerPaymentProfile>();

        //invalid card
        String customerProfileId= '905372692';
        Integer customerPaymentProfileId =905264262;
        CreditCard card = new CreditCard('123456789022', Date.newInstance(2026, 8, 1));
        Address billToAddress = new Address('mara', 'williams', 'blah 123', 'eugene', 'oregon', '97454');
        CustomerPaymentProfile profile = new CustomerPaymentProfile(card, billToAddress);
        profile.setCustomerPaymentProfileId(customerPaymentProfileId);

        //default valid Visa card
        Integer customerPaymentProfileId2 =905264263;
        CreditCard card2 = new CreditCard('4444111144441111', Date.newInstance(2025, 11, 1));
        Address billToAddress2 = new Address('mara', 'williams', 'blah 123', 'eugene', 'oregon', '97454');
        CustomerPaymentProfile profile2 = new CustomerPaymentProfile(card, billToAddress);
        profile2.setCustomerPaymentProfileId(customerPaymentProfileId2);
        profile2.setIsDefault(true);

        //valid Mastercard card
        Integer customerPaymentProfileId3 =905264264;
        CreditCard card3 = new CreditCard('5555111144441111', Date.newInstance(2027, 2, 1));
        Address billToAddress3 = new Address('mara', 'morgan', 'blah 123', 'eugene', 'oregon', '97454');
        CustomerPaymentProfile profile3 = new CustomerPaymentProfile(card, billToAddress);
        profile3.setCustomerPaymentProfileId(customerPaymentProfileId3);
        profile3.setIsDefault(false);

        //valid card number and type expired 

        Integer customerPaymentProfileId4 =905264265;
        CreditCard card4 = new CreditCard('5544111155559999', Date.newInstance(2023, 6, 1));
        Address billToAddress4 = new Address('Mara', 'Williams', 'office park 123', 'Eugene', 'OR', '97402');
        CustomerPaymentProfile profile4 = new CustomerPaymentProfile(card, billToAddress);
        profile3.setCustomerPaymentProfileId(customerPaymentProfileId3);
        profile3.setIsDefault(false);

        //add to list
        profiles.add(profile);
        profiles.add(profile2);
        profiles.add(profile3);
        profiles.add(profile4);
        
        //return list
        return profiles;
    }
    public List<CustomerPaymentProfile> samplePaymentProfileListAfterDelete(HttpRequest req, Integer customerPaymentProfileId) {
        List<CustomerPaymentProfile> profiles =sampleCustomerPaymentProfileList();
        
        for (CustomerPaymentProfile profile : profiles){
            Integer index;
            if (profile.getCustomerPaymentProfileId()==customerPaymentProfileId){
                index=profiles.indexOf(profile);
                profiles.remove(index);
            }
        }

        return profiles;
    }

    public static List<Integer> samplePaymentProfileIds() {
        List<CustomerPaymentProfile> profiles =sampleCustomerPaymentProfileList();
        List <Integer>profileIds = new List<Integer>();

        for (CustomerPaymentProfile profile : profiles){
            Integer id = profile.getCustomerPaymentProfileId();
            profileIds.add(id);
        }

        return profileIds;
    } 
*/
}