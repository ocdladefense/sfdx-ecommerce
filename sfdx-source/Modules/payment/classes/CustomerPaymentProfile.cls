public with sharing class CustomerPaymentProfile {
    private Boolean isDefault;
    private Integer customerPaymentProfileId;
    private Address billTo;
    private Map<String, Object> payment; 
    private CreditCard card;   
    
    public CustomerPaymentProfile() {

    }

    public CustomerPaymentProfile(CreditCard card, Address billTo) {
        this.billTo = billTo;
        this.card = card;
        this.payment = new Map<String, Object> {
            'payment' => new Map<String, Object> {
                'creditCard' => card
            }
        };
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

    public String deleteCustomerPaymentProfile(String customerProfileId){
        //set up a client
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        //make the request message
        DeleteCustomerPaymentProfileRequest req = new DeleteCustomerPaymentProfileRequest(profile, customerProfileId);
        
        //send the request and receive the response
        HttpResponseMessage resp = client.send(req);

        //get the message from the response and parse
        String body = resp.getBody();

        AuthorizeDotNetResponse message = new AuthorizeDotNetClient(body);
       
        //send resultCode
        return message.getResultCode();
    }

    public Integer getCustomerPaymentProfileId() {
        return customerPaymentProfileId;
    }

    public Address getBillTo() {
        return billTo;
    }

    public CreditCard getCard() {
        return card;
    }

    public Boolean getIsDefault() {
        return isDefault;
    }

    public void setCustomerPaymentProfileId(Integer customerPaymentProfileId) {
        this.customerPaymentProfileId = customerPaymentProfileId;
    }

    public void setBillTo(Address billTo) {
        this.billTo = billTo;
    }

    public void setCard(CreditCard card) {
        this.card = card;
    }

    public void setIsDefault (Boolean isDefault){
        this.isDefault=isDefault;
    }
}