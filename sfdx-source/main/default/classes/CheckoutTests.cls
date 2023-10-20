@isTest
public class CheckoutTests {

/*
    Contact c;
    Account acct;
    
    CheckoutTests(){
        c = [SELECT id, FirstName, LastName FROM contact WHERE contact.FirstName = 'Trevor'];
        acct = [SELECT id, Name FROM account WHERE account.Name = 'testAccount'];
    }
    
    @testSetup
    private static void Setup(){
        
        Contact c = new Contact();
		c.FirstName = 'Trevor';
        c.LastName = 'Whatever';
        Insert c;
        
        Account acct = new Account(Name='testAccount');
        Insert acct;
        
        //Order order = new Order();
        //order.AccountId = acct.Id;
        //order.EffectiveDate = Date.today();
        //order.Status = 'draft';
        //order.Contact__c = c.Id;
        //Insert order;
        
        //PaymentMethod__c pm = new PaymentMethod__c();
        //pm.CardType__c = 'visa';
        //pm.LastFour__c = '1111';
        //pm.Contact__c = c.Id;
        //pm.Token__c = '57419874949871419';
        //pm.DateSaved__c = Date.today();
        //Insert pm;
    }
    
    static testMethod void ParsePaymentProcessorResponse(){
        HttpResponse resp = new HttpResponse();
        Map<string,object> responseBody = new Map<string,object>();

        responseBody.put('paymentId','023489893408903280923');
        responseBody.put('cardType','visa');
        responseBody.put('status', 'authorized');
        responseBody.put('authorizedAmount',999.98);
        responseBody.put('currency', 'USD');
        
        string body = json.serialize(responseBody);
        resp.setBody(body);
        
        Map<string,object> processorInfo = CheckoutController.ParseResponse(resp);
        
		System.assertEquals(999.98, responseBody.get('authorizedAmount'));
    }
    
    static testMethod void GeneratePaymentMethod(){
        CheckoutTests context = new CheckoutTests();
		HttpResponse resp = new HttpResponse();
		Map<string,object> processorInfo = CheckoutController.ParseResponse(resp);
        processorInfo.put('contact', context.c.Id);
        
        // CheckoutController.InsertPaymentMethod(processorInfo);
        //CheckoutController.InsertPaymentMethod();
        
        PaymentInstrument__c pm = [SELECT CardType__c, MaskedNumber__c, Token__c FROM PaymentInstrument__c WHERE Contact__r.FirstName = 'Trevor' AND Contact__r.LastName = 'Whatever'];
        
        //System.assertEquals('visa',pm.CardType__c);
        //System.assertEquals('4111',pm.MaskedNumber__c);
        //System.assertEquals('023489893408903280923',pm.Token__c);
    }
    
    static testMethod void GenerateOrder(){
        CheckoutTests context = new CheckoutTests();
        Map<string,object> orderInfo = new Map<string,object>();
        orderInfo.put('accountId',context.acct.id);
        orderInfo.put('contact',context.c.id);
    }
*/

}