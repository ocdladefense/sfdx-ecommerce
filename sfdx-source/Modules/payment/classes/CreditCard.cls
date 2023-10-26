public class CreditCard {
    private Boolean isDefault;
    private Integer id;
    private String cardType;
    private String cardNumber;
    private String cvv;
    private Date expirationDate;
    private String unmaskedExpirationDate;
    private String firstName;
    private String lastName;
    private String phone;
    private String fax;
    private String email;
    private String address;
    private String city;
    private String state;
    private String zip;
    private String country;
    private Boolean dateIsMasked;

    // Constructors
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

    // Static Methods
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
        System.debug(body);

        // deserializes the JSON to a Map with strings before returning
        return (Map<String,Map<String,String>>)JSON.deserialize(body, Map<String,Map<String,String>>.class);
    }

    public static List<CreditCard> retrieveSavedCards(String customerProfileId) {        
    
        Map<String,Map<String, String>> fetchedCards =  fetchUsersCards(customerProfileId);
            
        List<CreditCard> savedCards = new List<CreditCard> {};
        System.debug('Saved Cards: ' + savedCards);
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
            theCard.setId(id);

            savedCards.add(theCard);
        }
        System.debug('Saved Cards: ' + savedCards);
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

    

    public static void addNewCardToPaymentProfile(CreditCard card){
        //user enters values into fields and hits submit
        //post request to server sent with form data as body
        //make a new card from the form values
        //as that happens setters get called and messages get sent back if invalid 
        //after all the data is validated
        //send api request to add it to the db
        //is the body a serialized json object or a json object

    }

    // Instance Methods
    /*
    public HttpRequest buildCardPostRequest() {
        //make new request object
        HttpRequest req = new HttpRequest();
        //Set HTTPRequest Method
        req.setMethod('POST');

        // set the header
        //req.setHeader('Content-Type','application/json');
        
        // Set the HTTPRequest body	
        String body = formatBody(this.params);
        if(null != body) {
            req.setBody(body);
        }
        
        return req;
    } 
    */ 
    
    // original isExpired method
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

    // updated isExpired method
    public Boolean isExpired() {
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

    // Getters
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

    public String getCVV() {
        return cvv;
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

    // Setters
    public void setId(Integer id) {
        this.id = id;
    }
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

    public void setAddress (string address){
        this.address = address;
    }

    public void setCity (string city){
        this.city = city;
    }

    public void setState (string state){
        this.state = state;
    }

    public void setZip (string zip){
        this.zip = zip;
    }

    public void setCountry (string country){
        this.country = country;
    }   
}
