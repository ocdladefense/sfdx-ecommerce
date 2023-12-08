@isTest
public class TestAuthorizeDotNetTransactions {

    
    @isTest
    static void useManyCreditCardTypes() {
        
        Map<String,String> card = new Map<String,String>{
            'ccNum' => AuthorizeDotNetSandbox.VISA,
            'ccExp' => '09/2030',
            'ccCode' => '123'
        };
        card.put('ccNum', AuthorizeDotNetSandbox.AMERICAN_EXPRESS);
        card.put('ccNum', AuthorizeDotNetSandbox.DISCOVER);
        card.put('ccNum', AuthorizeDotNetSandbox.MASTERCARD);   
    }
    
    
    
    @isTest
    static void doPayment() {
         
        Test.startTest();
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new AuthorizeDotNetMock(TransactionResponseCode.SUCCESS));
        
        Map<String,String> billto = new Map<String,String>{
            'BillingFirstName' => 'Jane',
            'BillingLastName' => 'Doe',
            'BillingStreet' => '1234 Birth Ct.',
            'BillingCity' => 'Ajax',
            'BillingStateCode' => 'OR',
            'BillingPostalCode' => '97211',
            'BillingEmail' => 'admin@mycompany.com',
            'BillingCountryCode' => 'US'
        };

        Map<String,String> card = new Map<String,String>{
            'ccNum' => AuthorizeDotNetSandbox.VISA,
            'ccExp' => '09/2030',
            'ccCode' => '123'
        };
        card.put('ccNum', AuthorizeDotNetSandbox.AMERICAN_EXPRESS);
        card.put('ccNum', AuthorizeDotNetSandbox.DISCOVER);
        card.put('ccNum', AuthorizeDotNetSandbox.MASTERCARD);        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        TransactionRequest req = new TransactionRequest();
        req.setAmount(100.00);
        req.setCreditCard(card);
        req.setBillToAddress(billto);
        req.setShipToAddress(billto);

        AuthorizeDotNetClient client = new AuthorizeDotNetClient(AuthorizeDotNetClient.GATEWAY_SANDBOX_URL);
        
        TransactionResponse resp = client.send(req);
        
        System.assert(resp.success());
    }
    
    
    
    @isTest
    static void payUsingSalesforceData() {
         
        Test.startTest();
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new AuthorizeDotNetMock(TransactionResponseCode.SUCCESS));
        
        Map<String,String> billto = new Map<String,String>{
            'BillingFirstName' => 'Jane',
            'BillingLastName' => 'Doe',
            'BillingStreet' => '1234 Birth Ct.',
            'BillingCity' => 'Ajax',
            'BillingStateCode' => 'OR',
            'BillingPostalCode' => '97211',
            'BillingEmail' => 'admin@mycompany.com',
            'BillingCountryCode' => 'US'
        };
            
		Map<String,String> shipto = billto.clone();
        
        Map<String,String> card = new Map<String,String>{
            'ccNum' => AuthorizeDotNetSandbox.VISA,
            'ccExp' => '09/2030',
            'ccCode' => '123'
        };
        card.put('ccNum', AuthorizeDotNetSandbox.AMERICAN_EXPRESS);
        card.put('ccNum', AuthorizeDotNetSandbox.DISCOVER);
        card.put('ccNum', AuthorizeDotNetSandbox.MASTERCARD);        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        TransactionRequest req = TransactionRequest.fromSalesforceData(100.00, card, billto, shipto, null);


        AuthorizeDotNetClient client = new AuthorizeDotNetClient(AuthorizeDotNetClient.GATEWAY_SANDBOX_URL);
        
        TransactionResponse resp = client.send(req);
        
        System.assert(resp.success());
    }
    
    /*
    @isTest
    static void TestSuccessfulAuthorizeDotNetResponse() {
         
        Test.startTest();
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new ClickpdxResponseGenerator(true));
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse res;     
        
        OcdlaCCAuthorize svc = new OcdlaCCAuthorize();
         
        res = svc.send();
         
        Test.stopTest();
 
        String body = res.getBody();
        
        Map<string, string> bodyMap = (Map<string, string>) JSON.deserializeStrict(body, Map<string, string>.class);
        
        system.assertEquals('1', bodyMap.get('TransactionResponseCode'), 'Should be 1');
    }
    
    @isTest
    static void TestErrorAuthorizeDotNetResponse() {
         
        Test.startTest();
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new ClickpdxResponseGenerator(false));
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse res;
        
        OcdlaCCAuthorize svc = new OcdlaCCAuthorize();
         
        res = svc.send();
         
        Test.stopTest();
 
        String body = res.getBody();
        
        Map<string, string> bodyMap = (Map<string, string>) JSON.deserializeStrict(body, Map<string, string>.class);
        
        system.assertEquals('2', bodyMap.get('TransactionResponseCode'), 'Should be 2');
    }
    
    @isTest
    static void TestGetSavedCardsVisa() {
        List<Map<string,string>> cards = ClickpdxCheckoutController.getSavedCreditCards();
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ClickpdxSavedCustomerResponseGenerator(cards[0]));
        
        HttpResponse res;
        //better way to do a send?
        OcdlaCCAuthorize svc = new OcdlaCCAuthorize();
         
        res = svc.send();
        
        Test.stopTest();
 
        String body = res.getBody();
        
        system.assertEquals('Valid Card', body);
    }
    
    @isTest
    static void TestGetSavedCardsMastercard() {
        List<Map<string,string>> cards = ClickpdxCheckoutController.getSavedCreditCards();
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ClickpdxSavedCustomerResponseGenerator(cards[1]));
        
        HttpResponse res;
        
        OcdlaCCAuthorize svc = new OcdlaCCAuthorize();
         
        res = svc.send();
        
        Test.stopTest();
 
        String body = res.getBody();
        
        system.assertEquals('Invalid Card', body);
    }
*/
}