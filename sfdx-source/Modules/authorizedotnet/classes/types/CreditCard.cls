public class CreditCard extends AuthorizeDotNetType {

    private String cardNumber;
    
    private String expirationDate;
    
    private String unmaskedExpirationDate;
    
    //public String cardType {public get{ return getType(); }}

    private String cardType;
    
    private Boolean dateIsMasked;
    
    private String cvv;

    public CreditCard() {}

    public CreditCard(String cardNumber) {
        this();
        this.cardNumber = cardNumber;
    }

    public CreditCard(String cardNumber, Date theDate) {
        this();
        this.cardNumber = cardNumber;
        this.expirationDate = AuthorizeDotNet.formatDateString(AuthorizeDotNet.dateToString(theDate));
    }


    public CreditCard(String cardNumber, String expirationDate) {
        this();
        this.cardNumber = cardNumber;
        this.expirationDate = expirationDate;
    }

    public CreditCard(String cardNumber, String expirationDate, string cvv) {
        this();
        this.cardNumber = cardNumber;
        this.expirationDate = expirationDate;
        this.cvv = cvv;
    }



    public override Set<String> keySet() {
        return new Set<String>{'cardNumber', 'expirationDate'};
    }

    

    public Boolean isExpired() {
        return AuthorizeDotNet.stringToDate(this.expirationDate) < Date.today();
    }

    
    public String getType() {

        if(null == cardNumber) {
            return 'Unknown';
        }
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
        return this.cardNumber.length() == 16 && this.getType()!='Unknown';
    }

    public String getExpirationDate() {
        return this.expirationDate;
    }

    public String getCardNumber() {
        return this.cardNumber;
    }

    public String getCVV() {
        return this.cvv;
    }

    public String getCardType() {
        return this.cardType;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public void setExpirationDate (String expirationDate){
        this.expirationDate=expirationDate;
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