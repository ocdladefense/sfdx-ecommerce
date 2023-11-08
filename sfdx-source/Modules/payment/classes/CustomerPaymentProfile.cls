public with sharing class CustomerPaymentProfile {
    
    private String customerProfileId;
    private String customerPaymentProfileId;
    private Payment payment; 
    private String originalNetworkTransId;
    private Decimal originalAuthAmount;
    private String customerType;
    private Address billTo;
    private Boolean defaultPaymentProfile;
    
    public CustomerPaymentProfile() {

    }

    public CustomerPaymentProfile(CreditCard card, Address billTo) {
        this.billTo = billTo;
        //this.card = card;
        this.payment = new Payment(card);
    }

    // profileId currently not used. Assume it is "905372692" in "https://appdev.ocdla.org/customer/905372692/cards"
    public static Map<String,Map<String,String>> fetchUsersCards(String profileId){
        Http client = new Http();

        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://appdev.ocdla.org/customer/' + profileId + '/cards');
        req.setMethod('GET');

        // Send the request, and return a response
        HttpResponse res = client.send(req);
        String body =  res.getBody();

        // deserializes the JSON to a Map with strings before returning
        return (Map<String,Map<String,String>>)JSON.deserialize(body, Map<String,Map<String,String>>.class);
    }

    //call to AuthorizeDotNet getCustomerProfileRequest to retrieve full profile with list of saved payment profiles
    public static List<CustomerPaymentProfile> getPaymentProfileList(String customerProfileId){
        
        List<CustomerPaymentProfile> profiles = new List<CustomerPaymentProfile>();
        
        //set up a client
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

    
        //make the request message
        GetCustomerProfileRequest req = new GetCustomerProfileRequest(customerProfileId);
      
        //send the request and receive the response
        HttpResponseMessage resp = client.send(req);

        //get the message from the response and parse
        String respBody = resp.getBody();
       
        Map<String, Object> body = (Map<String, Object>)JSON.deserializeUntyped(respBody);

        //key is profile
        Map<String, Object> soapProfile = (Map<String, Object>)body.get('profile');

        //get list of payment profiles
        List<Object> paymentProfiles = (List<Object>)soapProfile.get('paymentProfiles');
        
        //for each profile in the list, make a new profile object with billto and payment
        //ignore "originalNetworkTransId" and 'originalAuthAmount'

        for (Object p : paymentProfiles) {
            //first hold paymentprofile id in variable
            Map<String, Object> paymentProfile = (Map<String, Object>)p;
            String customerPaymentProfileId = (String)paymentProfile.get('customerPaymentProfileId');

            //next make new address and set the fields
            Map<String, Object> billTo = (Map<String, Object>)paymentProfile.get('billTo');
            Address theAddress = CustomerPaymentProfile.newAddressFromMap(billTo);
            //next deserialize payment into a map string object
            Map<String, Object> payment = (Map<String, Object>)paymentProfile.get('payment');
            CreditCard theCard=CustomerPaymentProfile.newCardFromPaymentMap(payment);

            //make new customerpayment profile
            CustomerPaymentProfile profile = new CustomerPaymentProfile(theCard,theAddress);
        //add to list of profiles
            profiles.add(profile);
        }
        

        //use AuthorizeDotNetResponse to parse messages
 
        //deserialize 
        //AuthorizeDotNetResponse message = new AuthorizeDotNetResponse(body);
        
        /*                                                               
{
  "profile": {
    "paymentProfiles": [{
        "customerPaymentProfileId": "87",
        "payment": {
          "creditCard": {
            "cardNumber": "XXXX1111",
            "expirationDate": "XXXX",
            "cardType": "Visa",
            "issuerNumber": "411111"
          }
        },
        "originalNetworkTransId": "0TN1VE648DFCJSHQ81GZH9F",
        "originalAuthAmount": 0,
        "billTo": {
          "phoneNumber": "000-000-0000",
          "firstName": "John",
          "lastName": "Doe",
          "address": "123 Main St.",
          "city": "Bellevue",
          "state": "WA",
          "zip": "98004",
          "country": "US"
        }
      }, {
        "customerPaymentProfileId": "86",
        "payment": {
          "creditCard": {
            "cardNumber": "XXXX1111",
            "expirationDate": "XXXX",
            "cardType": "Visa",
            "issuerNumber": "411111"
          }
        },
        "originalNetworkTransId": "0STSMT7WLO5D80U0KJR4Z9A",
        "originalAuthAmount": 0,
        "customerType": "individual",
        "billTo": {
          "phoneNumber": "123-123-1235",
          "firstName": "Customer FirstName",
          "lastName": "Customer LastName",
          "address": "123 Main St.",
          "city": "Bellevue",
          "state": "WA",
          "zip": "98004",
          "country": "US"
        }
      }
    ],
    "profileType": "regular",
    "customerProfileId": "527262",
    "merchantCustomerId": "MerchantCustID",
    "description": "Profile description here",
    "email": "customer-profile-email@here.com"
  },
  "messages": {
    "resultCode": "Ok",
    "message": [{
        "code": "I00001",
        "text": "Successful."
      }
    ]
  }
}

    */
      return profiles; 
    }

    public static List<CreditCard> retrieveSavedCards(String customerProfileId) {        
    
        Map<String,Map<String, String>> fetchedCards =  fetchUsersCards(customerProfileId);
            
        List<CreditCard> savedCards = new List<CreditCard> {};
        for (Map<string,string> card : fetchedCards.values()) {
            Integer id = Integer.valueOf(card.get('id'));
            List<String> dateParts = card.get('expirationDate').split('-');
            Integer year = Integer.valueOf(dateParts[0]);
            Integer month = Integer.valueOf(dateParts[1]);
            Date expDate = Date.newInstance(year, month, 1);
            String cardNum = card.get('cardNumber');
            String firstName = card.get('firstName');
            String lastName = card.get('lastName');

            CreditCard theCard = new CreditCard(cardNum, expDate);
            //theCard.setId(id);

            savedCards.add(theCard);
        }
        return savedCards;
    }

    public static List<SelectOption> toSelectOptions(List<CreditCard> cards) {
        System.debug('Input Cards: ' + cards);
        List<SelectOption> cardValues = new List<SelectOption>();

        // original loop to populate select options
        /*
        for (CreditCard card : cards) {
            String viewableCardNum;
            String expDate = card.getExpirationDate();
            List<string> splitExp = exp.split('-');
            String year = splitExp[0];
            String month = splitExp[1];
            expDate = month + '/' + year;
            if(isExpired(card)) {
                viewableCardNum = card.getCardNumber();
                viewableCardNum = viewableCardNum + '(expired)';
            }
            cardValues.add(new SelectOption(card.getId(), viewableCardNum));
            if (card.getIsDefault())
            {
                defaultCard = card;
            }
        }   
        */

        // updated loop to populate select options
        for (CreditCard card : cards) {
            String viewableCardNum = card.getCardNumber();
            if(card.isExpired()) {
                viewableCardNum = viewableCardNum + '(expired)';
            }
            //cardValues.add(new SelectOption(String.valueOf(card.getId()), viewableCardNum));
            
            // ---TODO---
            // fix later after defaultCard is fully investigated in OcdlaCheckoutController
            // currently not needed for testing
            /*
            if (card.getIsDefault())
            {
                defaultCard = card;
            }
            */
        }

        cardValues.add(new SelectOption('newCard', 'Add New Card'));
        System.debug('Output SelectOptions: ' + cardValues);
        return cardValues;
    }

    public String deleteCustomerPaymentProfile(String customerProfileId){
        //set up a client
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

    
        //make the request message
        DeleteCustomerPaymentProfileRequest req = new DeleteCustomerPaymentProfileRequest(this, customerProfileId);
      
        //send the request and receive the response
        HttpResponseMessage resp = client.send(req);

        //get the message from the response and parse
        String body = resp.getBody();

        AuthorizeDotNetResponse message = new AuthorizeDotNetResponse(body);
       
        //send resultCode
        return message.getResultCode();
    }


    public static CreditCard newCardFromPaymentMap(Map<String, Object> payment){
        Map<String, Object> theCard = (Map<String, Object>)payment.get('creditCard');
        String cardNumber = (String) theCard.get('cardNumber');
       
        CreditCard card = new CreditCard(cardNumber);
        
        String expirationDate = (String)theCard.get('expirationDate');
        card.setExpirationDate(expirationDate);
        return card;
    }

    public static Address newAddressFromMap(Map<String, Object> billTo){
        Map<String, String> theAddress = (Map<String, String>)billTo;
        String firstName = theAddress.get('firstName');
        String lastName = theAddress.get('lastName');
        String phoneNumber = theAddress.get('phoneNumber');
        String address = theAddress.get('address');
        String city = theAddress.get('city');
        String state = theAddress.get('state');
        String zip = theAddress.get('zip');
        String country = theAddress.get('country');
        
        //check for nulls?
        Address newAdress = new Address();
        newAdress.setFirstName(firstName);
        newAdress.setLastName(lastName);
        newAdress.setAddress(address);
        newAdress.setCity(city);
        newAdress.setState(state);
        newAdress.setZip(zip);

        if(country!=null){
            newAdress.setCountry(country);
        }

        if (phoneNumber!=null){
            newAdress.setPhoneNumber(phoneNumber);
        }
        return newAdress;
    }
    

    public String getCustomerPaymentProfileId() {
    public String getCustomerPaymentProfileId() {
        return customerPaymentProfileId;
    }

    public Address getBillTo() {
        return billTo;
    }
    /*
    public CreditCard getCard() {
        return card;
    }

    public Boolean getIsDefault() {
        return isDefault;
    }
    */
    public void setCustomerPaymentProfileId(String customerPaymentProfileId) {
        this.customerPaymentProfileId = customerPaymentProfileId;
    }

    public void setBillTo(Address billTo) {
        this.billTo = billTo;
    }
    /*
    public void setCard(CreditCard card) {
        this.card = card;
    }

    public void setIsDefault (Boolean isDefault){
        this.isDefault=isDefault;
    }
    */
}