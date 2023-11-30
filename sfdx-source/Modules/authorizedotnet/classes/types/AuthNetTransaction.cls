public class AuthNetTransaction extends AuthorizeDotNetType {
    

    private String transactionType = 'authCaptureTransaction';

    private Decimal amount;

    private String currencyCode = 'USD';

    private Map<String,Object> profile;

    private Payment payment;




    public AuthNetTransaction() {}



    public AuthNetTransaction(Decimal amount) {
        this.amount = amount;
    }

    public void payWith(String cardNumber, String expDate) {
        this.payment = new Payment(new CreditCard(cardNumber,expDate));
    }

    
    public void setCreditCard(CreditCard card) {
        // this.creditCard = card;
    }
    

    
    
    public void setBillToAddress(Map<String,String> address) {
        
        // this.billto = address;
    }
    
    
    public void setShipToAddress(Map<String,String> address) {
        // this.shipto = address;
    }
    


    public void setAmount(Decimal amount) {
        this.amount = amount;
    }


    public static AuthNetTransaction newFromCustomerPaymentProfile(String customerProfileId, String customerPaymentProfileId) {

        AuthNetTransaction t = new AuthNetTransaction();

        Map<String,Object> profile = new Map<String,Object>();
        profile.put('customerProfileId', customerProfileId);
        
        Map<String,String> paymentProfile = new Map<string,String>();
        paymentProfile.put('paymentProfileId', customerPaymentProfileId);

        profile.put('paymentProfile', paymentProfile);

        t.profile = profile;
        
        return t;
    }

    
    


    

    
}