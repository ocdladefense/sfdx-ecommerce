public with sharing class CreditCard {
    //copied from Credit Card Steven to named class until I have access to independent sandbox


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
    private string billingAddress;
    private string billingCity;
    private string billingState;
    private string billingZip;
    private string billingCountry;
    private Boolean dateIsMasked;

//constructors
    public CreditCard(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public CreditCard(String cardNumber, date expirationDate) {
        this.cardNumber = cardNumber;
        this.expirationDate = expirationDate;
    }

    public CreditCard(String cardNumber, Date expDate, string cvv) {
        this.cardNumber = cardNumber;
        this.expirationDate = expDate;
        this.cvv = cvv;
    }

    /* static methods */
    public static List<CreditCard> retrieveSavedCards(string customerProfileId) {        

        //Map<String,Map<String, String>> fetchedCards =  fetchUsersCards(customerProfileId);
        List<Map<String, String>> fetchedCardList =  new List<Map<String, String>>();

        List<CreditCard> savedCards = new List<CreditCard> {};

        for (Map<string,string> card : fetchedCardList){
            Integer id = Integer.valueOf(card.get('id'));
            List<String> dateParts = card.get('expirationDate').split('-');
            Integer year = Integer.valueOf(dateParts[0]);
            Integer month = Integer.valueOf(dateParts[1]);
            Date expDate = Date.newInstance(year, month, 1);
            String cardNum = card.get('cardNumber');
            String firstName = card.get('firstName');
            String lastName = card.get('lastName');

            CreditCard theCard = new CreditCard(cardNum, expDate);

            savedCards.add(theCard);
        }
        /*for (Map<string,string> card : fetchedCards.values()) {
            Integer id = Integer.valueOf(card.get('id'));
            List<String> dateParts = card.get('expirationDate').split('-');
            Integer year = Integer.valueOf(dateParts[0]);
            Integer month = Integer.valueOf(dateParts[1]);
            Date expDate = Date.newInstance(year, month, 1);
            String cardNum = card.get('cardNumber');
            String firstName = card.get('firstName');
            String lastName = card.get('lastName');

            CreditCard theCard = new CreditCard(cardNum, expDate);

            savedCards.add(theCard);
        }*/
        return savedCards;

    }

    public static List<SelectOption> toSelectOptions(List<CreditCard> cards) {
        System.debug('Input Cards: ' + cards);
        List<SelectOption> cardValues = new List<SelectOption>();

        // original loop to populate select options
        /*
 
        */

        // updated loop to populate select options
        for (CreditCard card : cards) {
            String viewableCardNum = card.getCardNumber();
            if(card.isExpired()) {
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
        System.debug('Output SelectOptions: ' + cardValues);
        return cardValues;
    }

    // profileId currently not used. Assume it is "905372692" in "https://appdev.ocdla.org/customer/905372692/cards"
    public static List<Map<String,String>> fetchUsersCards(String profileId){
        Http client = new Http();

        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://appdev.ocdla.org/customer/' + profileId + '/cards');
        req.setMethod('GET');

        // Send the request, and return a response
        HttpResponse res = client.send(req);
        String body =  res.getBody();
        System.debug(body);

        // deserializes the JSON to a Map with strings before returning
        return (List<Map<String,String>>)JSON.deserialize(body, List<Map<String,String>>.class);
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
    public boolean isExpired() {
        return this.getExpirationDate() < Date.today();
    }

    public String getType() {
        if (cardNumber.startsWith('4')) {
            return 'Visa';
        }
        else if(cardNumber.startsWith('5')){
            return 'Mastercard';
        }
        else if (cardNumber.startsWith('6')){
            return 'Discover';
        }
        else if (cardNumber.startsWith('34') || cardNumber.startsWith('37')){
            return 'American Express';
        }
        else {
            return 'Unknown';
        }
    }

    public Boolean isValid() {
        return cardNumber.length() == 16 && this.getType()!='Unknown';
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

    public string getPhone() {
        return phone;
    }

    public string getFax(){
        return fax;
    }

    public string getEmail(){
        return email;
    }
    

//do not need setters for card number, card type, or id
    
    public void setIsDefault (Boolean isDefault){
        this.isDefault=isDefault;
    }
    public void setExpirationDate (date expirationDate){
        this.expirationDate=expirationDate;
    }
    public void setCvv(string cvv) {
        this.cvv = cvv;
    }
    public void setPhone(string phone){
        this.phone = phone;
    }
    public void setFax(string fax){
        this.fax = fax;
    }
    public void setEmail (string email) {
        this.email = email;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setBillingAddress (string billingAddress){
        this.billingAddress = billingAddress;
    }

    public void setBillingCity (string billingCity){
        this.billingCity = billingCity;
    }

    public void setBillingState (string billingState){
        this.billingState = billingState;
    }

    public void setBillingZip (string billingZip){
        this.billingZip = billingZip;
    }

    public void setBillingCountry (string billingCountry){
        this.billingCountry = billingCountry;
    }

}