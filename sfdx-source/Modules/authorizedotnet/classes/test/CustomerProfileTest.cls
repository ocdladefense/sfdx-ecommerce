@isTest
public class CustomerProfileTest {


  
    public CustomerProfileTest() {}



    @isTest
    private static void testCollections() {

        AuthNetAddress address = new AuthNetAddress('Sebastian', 'Berna', '214 NW Monroe Ave', 'Corvallis', 'OR', '97330');

        AuthNetAddressCollection addresses = new AuthNetAddressCollection();
        addresses = new AuthNetAddressCollection(new List<AuthNetAddress>{address});
        addresses = new AuthNetAddressCollection(new List<AuthNetAddress>{address}, null);

        addresses.size();
        addresses.getAsMap();
        addresses.getAsList();
        addresses.getsSize();

        // AuthNetAddress address= new AuthNetAddress('Sebastian', 'Berna', '214 NW Monroe Ave', 'Corvallis', 'OR', '97330');
        CreditCard card = new CreditCard('4111111111111122','11/2024');
        Payment payment = new Payment();
        payment.setCreditCard(card);

        CustomerPaymentProfile paymentProfile = new CustomerPaymentProfile();
        paymentProfile.setBillTo(address);
        paymentProfile.setPayment(payment);
        paymentProfile.setCard(card);


        CustomerPaymentProfileCollection coll = new CustomerPaymentProfileCollection(new List<CustomerPaymentProfile>{paymentProfile});
        coll.size();
        coll.getDefault();
        coll.getAsList();
    }



    @isTest
    private static void getCustomerProfileResponse() {

        String customerProfileId = '916263569';
        GetCustomerProfileRequest req = new GetCustomerProfileRequest();
        req.setCustomerProfileId(customerProfileId);
        req = new GetCustomerProfileRequest(customerProfileId);
        req.getCustomerProfileId();
        req.getUnmaskExpirationDate();
        req.setUnmaskExpirationDate(True);

        String body = req.getBody();

        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();
        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, mock);
        }

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        GetCustomerProfileResponse resp = new GetCustomerProfileResponse();
        resp = new GetCustomerProfileResponse(resp.getBody());
        resp = (GetCustomerProfileResponse)client.send(req);

        CustomerProfile profile = resp.getProfile();
 
        System.assert(resp.success(), 'Success should return true.');
    }



    @isTest
    private static void createCustomerProfileResponse() {

        String customerProfileId = '916263569';
        CreateCustomerProfileRequest req = new CreateCustomerProfileRequest();
        // req.setCustomerProfileId(customerProfileId);

        String body = req.getBody();

        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();
        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, mock);
        }

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        CreateCustomerProfileResponse resp = new CreateCustomerProfileResponse();
        resp = new CreateCustomerProfileResponse(resp.getBody());
        resp = (CreateCustomerProfileResponse)client.send(req);

        // CustomerProfile profile = resp.getProfile();
 
        System.assert(resp.success(), 'Success should return true.');
    }



    @isTest
    private static void createCustomerPaymentProfileResponse() {
    
        AuthNetAddress address= new AuthNetAddress('Sebastian', 'Berna', '214 NW Monroe Ave', 'Corvallis', 'OR', '97330');
        CreditCard card = new CreditCard('4111111111111122','11/2024');
        Payment payment = new Payment();
        payment.setCreditCard(card);

        CustomerPaymentProfile paymentProfile = new CustomerPaymentProfile();
        paymentProfile.setBillTo(address);
        paymentProfile.setPayment(payment);
        paymentProfile.setCard(card);

     
        CreateCustomerPaymentProfileRequest req = new CreateCustomerPaymentProfileRequest();
        req.setPaymentProfile(paymentProfile);
        System.assert(req.getRequestType() == 'createCustomerPaymentProfile');

        
        String result = req.getBody();
        system.debug(result);
        Boolean idPresent = result.contains('customerProfileId');
    }


  
    @isTest
    static void constructCustomerProfile() {
  
        AuthorizeDotNetServiceMock mock = new AuthorizeDotNetServiceMock();
        if (Test.isRunningTest()){
            Test.setMock(HttpCalloutMock.class, mock);
        }

  
        AuthNetAddress shipTo = new AuthNetAddress('Mel', 'Smythe-Bananas', '1325 West 18th Ave', 'Eugene', 'OR', '97402');
        shipTo.setCompany('LCC Art Department');

        List<AuthNetAddress> shipToList = new List<AuthNetAddress>();
        shipToList.add(shipTo);

        Object generic = shipToList;

        System.assert(generic instanceof List<AuthorizeDotNetType>);

  
        
        CustomerPaymentProfile paymentProfile = new CustomerPaymentProfile();
        paymentProfile.setCard(new CreditCard('4111111111111111', '05-2026'));

        

        CustomerProfile profile = new CustomerProfile();
        profile.setMerchantCustomerId('123');
        profile.setEmail('john.doe@example.com');
        profile.setDescription('My Profile');
        profile.setProfileType('individual');
        profile.addToPaymentProfiles(paymentProfile);
        profile.setCustomerType(CustomerProfile.CUSTOMER_TYPE_INDIVIDUAL);


        profile.getProfileType();
        profile.getMerchantCustomerId();
        profile.getEmail();
        profile.getDescription();
        profile.getPaymentProfiles();
        profile.getShipToList();
        profile.getDefaultPaymentProfile();
        profile.addToShipToList(shipTo);
        profile.getDefaultShippingAddressFromList();
        profile.getShipToCollection();
        profile.setCustomerProfileId('123');
        profile.setPaymentProfiles(new List<CustomerPaymentProfile>{paymentProfile});
        profile.setShipToList(new List<AuthNetAddress>{shipTo});
        profile.getPaymentProfileCollection();


        JsonPayload p1 = new JsonPayload();
        p1.writeStartObject();
        p1.writeObjectField('profile', profile);
        p1.writeEndObject();
        System.debug(p1.getAsString());

        CreateCustomerProfileRequest req = new CreateCustomerProfileRequest(profile);
        req.setValidationMode('testMode');
        req.getValidationMode();
        req.addToShipToList(shipTo);
        req.setShipToList((List<AuthNetAddress>)shipToList);
        req.getShipToList();
        
        String body = req.getBody();


        AuthorizeDotNetClient client = new AuthorizeDotNetClient();
        CreateCustomerProfileResponse resp = (CreateCustomerProfileResponse)client.send(req);


        System.debug(resp.getBody());
        System.debug('Response status is: '+ resp.success());
        System.debug('CustomerProfileId from response is: ' + resp.getCustomerProfileId());
    }



    @isTest
    private static void testMessages() {

        Messages msgs = new Messages();
        Message m1 = new Message('I00001','Successful.');
        m1.setCode('');
        m1.setText('');
        m1.getCode();
        m1.getText();

        msgs.addMessage(m1);
        msgs.setMessage(new List<Message>{m1});
        msgs.setResultCode(AuthorizeDotNetResponse.RESPONSE_SUCCESS);

        JsonPayload p2 = new JsonPayload();
        p2.writeStartObject();
        p2.writeObjectField('messages', msgs);
        p2.writeEndObject();
        System.debug(p2.getAsString());

        String resultCode = msgs.getResultCode();
        List<Message> statuses = msgs.getMessage();
        Message first = msgs.getFirstMessage();
    }



    @isTest
    private static void testCredentials() {

        Credentials c = new Credentials('name', 'key');
        c.getName();
        c.getTransactionKey();

        JsonPayload p = new JsonPayload();
        p.writeStartObject();
        p.writeObjectField('credentials', c);
        p.writeEndObject();
        System.debug(p.getAsString());
    }


  
    @isTest
    private static void testCreditCard() {

        String cardNumber = '4111111111111111';
        String unkownCardNumber = '9111111111111111';
        Date expDate = Date.newInstance(2050,1,1);

        CreditCard card = new CreditCard();
        card = new CreditCard(cardNumber);
        card = new CreditCard(cardNumber, '1/2050');
        card = new CreditCard(cardNumber, '1/2050', '123');
        card = new CreditCard(cardNumber, expDate);

        String cardType = card.getType();
        String nativeType = card.getCardType();
        System.assert(cardType == 'Visa');
        System.assert(card.isValid());
        System.assert(!card.isExpired());
        String theExpDate = card.getExpirationDate();
        String theCardNumber = card.getCardNumber();
        String cvv = card.getCVV();


        card.setCardNumber(unkownCardNumber);
        card.setExpirationDate('1/2050');
        card.setCvv('123');
        card.setCardType('Visa');
        System.assert(CreditCard.CARD_TYPE_UNKNOWN == card.getType());

        JsonPayload p = new JsonPayload();
        p.writeStartObject();
        p.writeObjectField('merchantAuthentication', card);
        p.writeEndObject();
        System.debug(p.getAsString());
    }

   

    @isTest static void updateCustomerProfile(){
        //set up data to send
            
        //make request

        //send request

        //deserialize response
    }

    @isTest static void deleteCustomerProfile(){
        //set up data to send
            
        //make request

        //send request

        //deserialize response
    }
}