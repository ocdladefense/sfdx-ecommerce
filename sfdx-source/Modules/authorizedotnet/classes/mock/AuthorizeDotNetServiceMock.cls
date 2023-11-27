public class AuthorizeDotNetServiceMock implements HttpCalloutMock {
    
    protected List<CustomerPaymentProfile> profiles;

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
        //System.debug('making a respond request');

        HttpResponse resp = new HttpResponse();
        
        String requestType = req.getHeader('X-Request-Type');
        String responseType;
        
        //UpdateCustomerShippingAddressMockResponse (and Delete, Create versions) exceed 40 character limit for class name
        //if statement to catch those request types and append shorter 'MockResp' 

        if(requestType.contains('CustomerShippingAddress')){
            responseType = requestType.capitalize()+'MockResp';
        }
        else{
            responseType = requestType.capitalize()+'MockResponse';
        }
       
 

        System.Type t = Type.forName(responseType);

        IMockResponse mock = (IMockResponse)t.newInstance();


        resp.setHeader('Content-Type', 'application/json');
       

        resp.setBody(mock.getBody());
        resp.setStatusCode(200);
        String codeForDebug ='200';
        resp.setStatus('Apex generated Mock HttpResponse.');
 
        //System.debug('The mock response status code is ' + codeForDebug);
        return resp;
    }
/*
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

    public void deleteFromProfileList(HttpRequest req, String xRequestType) {
        Map<String, Object> tempObj = (Map<String, Object>)JSON.deserializeUntyped(req.getBody());
   
        String profileIdToDelete = (String)tempObj.get('customerPaymentProfileId');
        Integer index;
        for (CustomerPaymentProfile p : this.profiles){
            if (p.getCustomerPaymentProfileId()==profileIdToDelete){
                index=this.profiles.indexOf(p);
            }
        }
        if(index!=null){
            this.profiles.remove(index);
        }
        
        System.debug(this.getSampleListSize());
    }

    public Integer getSampleListSize(){
        return this.profiles.size();
    }
    */

    public static String sampleGetCustomerProfileRespBody(){
        return '{"profile":{"paymentProfiles":[{"customerPaymentProfileId":"905264257","payment":{"creditCard":{"cardNumber":"XXXX9703","expirationDate":"XXXX","cardType":"MasterCard","issuerNumber":"222300"}},"customerType":"individual","billTo":{"phoneNumber":"5417350538","firstName":"Trevor","lastName":"Uehlin","address":"2551 Cubit Street","city":"Eugene","state":"OR","zip":"97402","country":"USA"}},{"customerPaymentProfileId":"905264243","payment":{"creditCard":{"cardNumber":"XXXX0015","expirationDate":"XXXX","cardType":"MasterCard","issuerNumber":"542400"}},"customerType":"individual","billTo":{"phoneNumber":"5417350538","firstName":"Trevor","lastName":"Uehlin","address":"2551 Cubit Street","city":"Eugene","state":"OR","zip":"97402","country":"USA"}},{"customerPaymentProfileId":"905264237","payment":{"creditCard":{"cardNumber":"XXXX0017","expirationDate":"XXXX","cardType":"JCB","issuerNumber":"308800"}},"customerType":"individual","billTo":{"phoneNumber":"5417350538","firstName":"Trevor","lastName":"Uehlin","address":"2551 Cubit Street","city":"Eugene","state":"OR","zip":"97402","country":"USA"}},{"customerPaymentProfileId":"905264232","payment":{"creditCard":{"cardNumber":"XXXX0012","expirationDate":"XXXX","cardType":"Discover","issuerNumber":"601100"}},"customerType":"individual","billTo":{"phoneNumber":"5417350538","firstName":"Trevor","lastName":"Uehlin","address":"2551 Cubit Street","city":"Eugene","state":"OR","zip":"97402","country":"USA"}},{"customerPaymentProfileId":"905263202","payment":{"creditCard":{"cardNumber":"XXXX0017","expirationDate":"XXXX","cardType":"JCB","issuerNumber":"308800"}},"customerType":"individual","billTo":{"phoneNumber":"5417350538","firstName":"Trevor","lastName":"Uehlin","address":"2551 Cubit Street","city":"Eugene","state":"OR","zip":"97402","country":"USA"}}],"profileType":"regular","customerProfileId":"905372692","merchantCustomerId":"003j000000rU9NvAAK","description":"Jose Bernal","email":"redderx@yahoo.com"},"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}';
    }
}