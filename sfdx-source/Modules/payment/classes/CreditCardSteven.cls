public with sharing class CreditCardSteven {
    private Boolean isDefault;
    private integer id;
    private string cardType;
    private string cardNumber;
    private string cvv;
    private date expirationDate;
    private string unmaskedExpirationDate;
    private string firstName;
    private string lastName;
    private string phone;
    private string fax;
    private string email;
    private string address;
    private string city;
    private string state;
    private string zip;
    private string country;
    private Boolean dateIsMasked;

    public CreditCardSteven(string cardNumber, date expirationDate, string firstName, string lastName) {
        this.cardNumber = cardNumber;
        this.expirationDate = expirationDate;
        this.firstName = firstName;
        this.lastName = lastName;
    }

    /*  */
    public static List<CreditCardSteven> retrieveSavedCards(string customerProfileId) {        

        Map<String,Map<String,String>> creditCards =  fetchUsersCards(customerProfileId);
            
        List<CreditCardSteven> savedCards = new List<CreditCardSteven> {};
        for (Map<string,string> card : creditCards.values()) {
            Date expDate = Date.parse(card.get('expirationDate'));
            String cardNum = card.get('cardNumber');
            String firstName = card.get('firstName');
            String lastName = card.get('lastName');

            CreditCardSteven theCard = new CreditCardSteven(cardNum, expDate, firstName, lastName);

            savedCards.add(theCard);
        }
        return savedCards;

    }

    public static List<SelectOption> toSelectOptions(List<CreditCardSteven> cards) {
        List<SelectOption> cardValues = new List<SelectOption>();

        // original loop to populate select options
        /*
        for (CreditCardSteven card : cards) {
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
        for (CreditCardSteven card : cards) {
            String viewableCardNum;
            if(isExpired(card)) {
                viewableCardNum = card.getCardNumber();
                viewableCardNum = viewableCardNum + '(expired)';
            }
            cardValues.add(new SelectOption(String.valueOf(card.getId()), viewableCardNum));
            
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
        return cardValues;
    }

    // profileId currently not used. Assume it is "905372692" in "https://appdev.ocdla.org/customer/905372692/cards"
    public static Map<String,Map<String,String>> fetchUsersCards(String profileId){
        Http client = new Http();

        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://appdev.ocdla.org/customer/905372692/cards');
        req.setMethod('GET');

        // Send the request, and return a response
        HttpResponse res = client.send(req);
        String body =  res.getBody();
        System.debug(body);

        // deserializes the JSON to a Map with strings before returning
        return (Map<String,Map<String,String>>)JSON.deserialize(body, Map<String,Map<String,String>>.class);
    }
    
    // original isExpired function
    /*
    private static boolean isExpired(Map<string,string> card) {
        String exp = card.get('expirationDate');
        List<string> splitExp = exp.split('/');
        String month = splitExp[0];
        String year = splitExp[1];
        String expirationDate = month + '/01/' + year;
        Date realDate = Date.parse(expirationDate);
        
        return realDate < Date.today();
    }
    */

    // updated isExpired function
    public static boolean isExpired(CreditCardSteven card) {
        return card.getExpirationDate() < Date.today();
    }

    public Integer getId() {
        return id;
    }

    public Boolean getIsDefault() {
        return isDefault;
    }

    public Date getExpirationDate() {
        return expirationDate;
    }

    public String getCardNumber() {
        return cardNumber;
    }
    
    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }
}