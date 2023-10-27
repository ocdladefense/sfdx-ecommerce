
public class CreditCard {

    private String cardType;
    private String cardNumber;
    private String cvv;
    private String expirationDate;
    private String unmaskedExpirationDate;
    private Boolean dateIsMasked;



    public CreditCard(String cardNumber, Date expDate, string cvv) {
        this.cardNumber = cardNumber;
        this.expirationDate = expDate;
        this.cvv = cvv;
    }


    public CreditCard(String cardNumber, date expirationDate) {
        this.cardNumber = cardNumber;
        this.expirationDate = dateToString(expirationDate);
    }

    public CreditCard(String cardNumber, Date expirationDate, string cvv) {
        this.cardNumber = cardNumber;
        this.expirationDate = dateToString(expirationDate);
        this.cvv = cvv;
    }

    // Static Methods------------------------------

    

    

    // Instance Methods-------------------
    
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
        return true;
    }

    public static String dateToString(Date expDate) {
        Integer year = expDate.year();
        Integer month = expDate.month();
        // Format as 'YYYY-MM'
        String formattedDate = String.valueOf(year) + '-' + (month < 10 ? '0' + String.valueOf(month) : String.valueOf(month));
        return formattedDate;

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


    

    public String getExpirationDate() {
        return expirationDate;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public String getCVV() {
        return cvv;
    }
    

    public void setExpirationDate (String expirationDate){
        this.expirationDate=expirationDate;
    }
    public void setCvv(string cvv) {
        this.cvv = cvv;
    }
    
}

