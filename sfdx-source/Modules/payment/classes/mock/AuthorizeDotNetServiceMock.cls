public class AuthorizeDotNetServiceMock implements HttpCalloutMock {
    
    public AuthorizeDotNetServiceMock() {
        //invoke the list with 4 profiles

}

//logic for testing if a req's customerProfileId is on the list

/*        if(Test.isRunningTest() && req.getRequestType()=='DeleteCustomerPaymentProfile'){
            //can also try in test class
            //need way to set isErrorTest value to false
            Map<String, Object> tempObj = req.getBodyAsNativeObject();
            String paymentProfileId = (String)tempObj.get('customerPaymentProfileId');
           Boolean isErrorTest = DeleteCustomerPaymentProfileMockResponse.setIsErrorTestByPaymentProfileId(paymentProfileId);
           resp.setIsErrorTest(isErrorTest); 
           System.debug('set the errorTestValue');
        }*/
        
    public HttpResponse respond(HttpRequest req) {
        System.debug('making a responde request');
        HttpResponse resp = new HttpResponse();

        
        
        
        String mockType = req.getHeader('X-Request-Type')+'MockResponse';
        //if is delete - remove 1 from list

        System.Type t = Type.forName(mockType);

        IMockResponse mock = (IMockResponse)t.newInstance();

        resp.setHeader('Content-Type', 'application/json');
        resp.setBody(mock.getBody());
        resp.setStatusCode(200);
        resp.setStatus('Apex generated Mock HttpResponse.');
        // resp.setHeader('X-Request-Type')

        return resp;
    }

    public static List<CustomerPaymentProfile> sampleCustomerPaymentProfileList(){
        List<CustomerPaymentProfile> profiles = new List<CustomerPaymentProfile>();

        //invalid card
        String customerProfileId= '905372692';
        String customerPaymentProfileId ='905264262';
        CreditCard card = new CreditCard('123456789022', Date.newInstance(2026, 8, 1));
        Address billToAddress = new Address('mara', 'williams', 'blah 123', 'eugene', 'oregon', '97454');
        CustomerPaymentProfile profile = new CustomerPaymentProfile(card, billToAddress);
        profile.setCustomerPaymentProfileId(customerPaymentProfileId);

        //default valid Visa card
        String customerPaymentProfileId2 = '905264263';
        CreditCard card2 = new CreditCard('4444111144441111', Date.newInstance(2025, 11, 1));
        Address billToAddress2 = new Address('mara', 'williams', 'blah 123', 'eugene', 'oregon', '97454');
        CustomerPaymentProfile profile2 = new CustomerPaymentProfile(card, billToAddress);
        profile2.setCustomerPaymentProfileId(customerPaymentProfileId2);
        profile2.setDefaultPaymentProfile(true);

        //valid Mastercard card
        String customerPaymentProfileId3 ='905264264';
        CreditCard card3 = new CreditCard('5555111144441111', Date.newInstance(2027, 2, 1));
        Address billToAddress3 = new Address('mara', 'morgan', 'blah 123', 'eugene', 'oregon', '97454');
        CustomerPaymentProfile profile3 = new CustomerPaymentProfile(card, billToAddress);
        profile3.setCustomerPaymentProfileId(customerPaymentProfileId3);
        profile3.setDefaultPaymentProfile(false);

        //valid card number and type expired 

        String customerPaymentProfileId4 = '905264265';
        CreditCard card4 = new CreditCard('5544111155559999', Date.newInstance(2023, 6, 1));
        Address billToAddress4 = new Address('Mara', 'Williams', 'office park 123', 'Eugene', 'OR', '97402');
        CustomerPaymentProfile profile4 = new CustomerPaymentProfile(card, billToAddress);
        profile3.setCustomerPaymentProfileId(customerPaymentProfileId3);
        profile3.setDefaultPaymentProfile(false);

        //add to list
        profiles.add(profile);
        profiles.add(profile2);
        profiles.add(profile3);
        profiles.add(profile4);
        
        //return list
        return profiles;
    }
}