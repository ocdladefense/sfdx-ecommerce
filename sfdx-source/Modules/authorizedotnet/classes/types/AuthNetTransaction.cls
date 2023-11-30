public class AuthNetTransaction extends AuthorizeDotNetType {
    

    private String transactionType = 'authCaptureTransaction';

    private Decimal amount;

    private String currencyCode = 'USD';

    // Populated when specifying a customerProfileId 
    // and* customerPaymentProfileId.
    private Map<String,Object> profile;

    // Populated when specifying card info.
    private Payment payment;




    public AuthNetTransaction() {}



    public AuthNetTransaction(Decimal amount) {
        this.amount = amount;
    }

    public void payWith(String cardNumber, String expDate) {
        if(null != this.profile) {
            throw new AuthorizeDotNetTypeException('MALFORMED_PROPERTIES_ERROR: Payment already set.');
        }
        this.payment = new Payment(new CreditCard(cardNumber,expDate));
    }

    public void payWith(CustomerProfile profile) {

        if(null != this.payment) {
            throw new AuthorizeDotNetTypeException('MALFORMED_PROPERTIES_ERROR: Payment already set.');
        }

        CustomerPaymentProfile paymentProfile = profile.getDefaultPaymentProfile();

        // when paying with a customer payment profile,
        // what data is required and which properties are populated?
        this.profile = new Map<String,Object>();
        this.profile.put('customerProfileId', profile.getCustomerProfileId());
        this.profile.put('paymentProfile', new Map<String,String>{'paymentProfileId' => paymentProfile.getCustomerPaymentProfileId()});
    }

    
    public void setCreditCard(CreditCard card) {
        // this.creditCard = card;
    }

    public override Set<String> keySet() {
        return new Set<String>{'transactionType','amount','currencyCode','payment'};
    }
    
    public override Map<String,Object> toMap() {
        Map<String,Object> theMap = new Map<String,Object>();
        theMap.put('transactionType', this.transactionType);
        theMap.put('amount', this.amount);
        theMap.put('currencyCode', this.currencyCode);
        theMap.put('payment', this.payment);

        return theMap;
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