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
        this.cardNumber = cardNumber;
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
        return stringToDate() < Date.today();
    }

    public Date stringToDate() {
        String exp = this.expirationDate;
        //List<String> splitExp = exp.split('-'); - old divider, using / now
        List<String> splitExp = exp.split('/');
        String year = splitExp[1]; // was index 0
        String month = splitExp[0]; // was index 1
        String expDate = month + '/01/' + year;
        Date realDate = Date.parse(expDate);

        return realDate;
    }

    public static String dateToString(Date expDate) {
        Integer year = expDate.year();
        Integer month = expDate.month();
        // Format as 'YYYY-MM'
        //String formattedDate = String.valueOf(year) + '-' + (month < 10 ? '0' + String.valueOf(month) : String.valueOf(month));
        // New format as MM/YYYY
        String formattedDate = (month < 10 ? '0' + String.valueOf(month) : String.valueOf(month)) + '/' + String.valueOf(year);
        return formattedDate;

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