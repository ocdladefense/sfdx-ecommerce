public with sharing class CustomerPaymentProfile {
    
    public String customerProfileId;
    public String customerPaymentProfileId;
    public Payment payment; 
    public String originalNetworkTransId;
    public String originalAuthAmount;
    public String customerType;
    public Address billTo;
    public Boolean defaultPaymentProfile;
    
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
        return customerPaymentProfileId;
    }

    public String getCustomerProfileId() {
        return customerProfileId;
    }

    public Address getBillTo() {
        return billTo;
    }

    public Payment getPayment() {
        return payment;
    }

    public String getDefaultPaymentProfile() {
        return defaultPaymentProfile;
    }

    public void setCustomerPaymentProfileId(String customerPaymentProfileId) {
        this.customerPaymentProfileId = customerPaymentProfileId;
    }

    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }

    public void setBillTo(Address billTo) {
        this.billTo = billTo;
    }

    public void setPayment(CreditCard card) {
        this.payment = new Payment (card);
    }

    public void setDefaultPaymentProfile (String defaultPaymentProfile){
        this.defaultPaymentProfile=defaultPaymentProfile;
    }
    
}