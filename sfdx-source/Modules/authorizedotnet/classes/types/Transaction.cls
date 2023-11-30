public class Transaction extends AuthorizeDotNetType {
    

    private String transactionType = 'authCaptureTransaction';

    private Decimal amount;

    private String currencyCode = 'USD';

    private Map<String,String> profile;




    public Transaction() {}



    public Transaction(Decimal amount) {
        this.amount = amount;
    }

    
    public void setCreditCard(CreditCard card) {
        // this.creditCard = card;
    }
    

    
    
    public void setBillToAddress(Map<String,String> address) {
        
        this.billto = address;
    }
    
    
    public void setShipToAddress(Map<String,String> address) {
        this.shipto = address;
    }
    


    public void setAmount(Decimal amount) {
        this.amount = amount;
    }


    public static CreateTransactionRequest newFromCustomerPaymentProfile(String customerProfileId, String customerPaymentProfileId) {

        CreateTransactionRequest req = new CreateTransactionRequest();

        Map<String,Object> profile = new Map<String,Object>();
        profile.put('customerProfileId', customerProfileId);
        
        Map<String,String> paymentProfile = new Map<string,String>();
        paymentProfile.put('paymentProfileId', customerPaymentProfileId);

        profile.put('paymentProfile', paymentProfile);

        req.profile = profile;
        
        return req;
    }

    
    


    

    
}