public class CreditCard {

    public final String TEST_CREDIT_CARD_NUMBER = '4111111111111111';

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

    public CreditCard(string cardNumber, date expirationDate, string firstName, string lastName) {
        this.cardNumber = cardNumber;
        this.expirationDate = expirationDate;
        this.firstName = firstName;
        this.lastName = lastName;
    }

    /*  */
    public static List<CreditCard> retrieveSavedCards(string customerProfileId) {
        //replace static list with http callout in alex's code
        List <Map<string, string>> creditCards2 = new List <Map<string, string>> {
            new Map<String, string>{'isDefault'=>'true', 'id'=>'905264262', 'cardNumber'=>'XXXX4532', 'expirationDate'=>'2024-08', 'cardType'=>'visa', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'},
                new Map<String, string>{'isDefault'=>'false', 'id'=>'905264263', 'cardNumber'=>'XXXX4632', 'expirationDate'=>'2023-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'},
                    new Map<String, string>{'isDefault'=>'false', 'id'=>'905264264', 'cardNumber'=>'XXXX4786', 'expirationDate'=>'2043-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'},
                        new Map<String, string>{'isDefault'=>'false', 'id'=>'905264265', 'cardNumber'=>'XXXX4912', 'expirationDate'=>'2025-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'}
        };

        Map<String,Map<String,String>> creditCards =  fetchUsersCards(customerProfileId);
            
        List<CreditCard> cards = new List<CreditCard> {};
        for (Map<string,string> card : creditCards.values()) {
            String expDate = card.get('expirationDate');
            String cardNum = card.get('cardNumber');
            String firstName = card.get('firstName');
            String lastName = card.get('lastName');

            CreditCard theCard = new CreditCard(cardNum, expDate, firstName, lastName);

            savedCards.add(theCard);
        }
        return savedCards;

        
        /*
                
        
        return creditCards;
        */
    }

    public static List<SelectOption> toSelectOptions(List<CreditCard> cards) {
        List<SelectOption> cardValues = new List<SelectOption>();

        for (CreditCard card : cards) {
            String viewableCardNum;
            String exp = card.getExpirationDate();
            List<string> splitExp = exp.split('-');
            String year = splitExp[0];
            String month = splitExp[1];
            exp = month + '/' + year;
            if(isExpired(card)) {
                string viewableCardNum = card.getCardNumber();
                viewableCardNum = viewableCardNum + '(expired)';
            }
            cardValues.add(new SelectOption(card.getId(), viewableCardNum));
            if (card.getIsDefault())
            {
                defaultCard = card;
            }
        }   

        cardValues.add(new SelectOption('newCard', 'Add New Card'));
        return cardValues;
    }

    // From Alex's branch
    public static Map<String,Map<String,String>> fetchUsersCards(){
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

    public Integer getId() {
        return id;
    }

    public Boolean getIsDefault() {
        return isDefault;
    }

    public String getExpirationDate() {
        return expirationDate;
    }

    public String getCardNumber() {
        return cardNumber;
    }
    
    
}