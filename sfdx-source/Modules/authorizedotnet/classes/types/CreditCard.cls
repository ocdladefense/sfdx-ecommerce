public class CreditCard extends AuthorizeDotNetType {

    private String cardNumber;
    
    private String expirationDate;
    
    private String unmaskedExpirationDate;
    
    //public String cardType {public get{ return getType(); }}

    private String cardType;
    
    private Boolean dateIsMasked;
    
    private String cvv;

    private static Map<String,String> registeredTypes = new Map<String,String>{
        '4' => 'Visa',
        '5' => 'Mastercard',
        '6' => 'Discover',
        '34' => 'American Express',
        '37' => 'American Express'
    };

    public static String CARD_TYPE_UNKNOWN = 'Unknown';




    public CreditCard() {}


    public CreditCard(String cardNumber) {
        this();
        this.cardNumber = cardNumber;
    }


    public CreditCard(String cardNumber, Date expDate) {
        this();
        this.cardNumber = cardNumber;
        this.expirationDate = AuthorizeDotNet.formatDateString(AuthorizeDotNet.dateToString(expDate));
    }


    public CreditCard(String cardNumber, String expDate) {
        this();
        this.cardNumber = cardNumber;
        this.expirationDate = expDate;
    }


    public CreditCard(String cardNumber, String expDate, string cvv) {
        this();
        this.cardNumber = cardNumber;
        this.expirationDate = expDate;
        this.cvv = cvv;
    }


    public override Set<String> keySet() {
        return new Set<String>{'cardNumber', 'expirationDate'};
    }

    
    public Boolean isExpired() {
        return AuthorizeDotNet.stringToDate(this.expirationDate) < Date.today();
    }

    
    public String getType() {


        for(String cardPrefix : registeredTypes.keySet()) {

            if(this.cardNumber.startsWith(cardPrefix)) {
                return registeredTypes.get(cardPrefix);
            }
        }

        return CARD_TYPE_UNKNOWN;
    }
    

    public Boolean isValid() {
        return this.cardNumber.length() >= 16 && this.getType() != CARD_TYPE_UNKNOWN;
    }


    public String getExpirationDate() {
        return this.expirationDate;
    }


    public String getCardNumber() {
        return this.cardNumber;
    }


    public String getCvv() {
        return this.cvv;
    }


    public String getCardType() {
        return this.cardType;
    }


    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }


    public void setExpirationDate(String expDate) {
        this.expirationDate = expDate;
        // Set this.expMonth and this.expYear
        // parse from expiration date
        // assume param format is YYYY-MM
    }
    

    public void setCvv(string cvv) {
        this.cvv = cvv;
    }


    public void setCardType(String cardType) {
        this.cardType = cardType;
    }


    public override Map<String,Object> toMap() {

        String theJson = JSON.serialize(this);

        return (Map<String, Object>)JSON.deserializeUntyped(theJson);
    }
    
}