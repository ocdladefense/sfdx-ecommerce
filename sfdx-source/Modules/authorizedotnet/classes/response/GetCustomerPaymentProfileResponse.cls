public class GetCustomerPaymentProfileResponse extends AuthorizeDotNetResponse {
    
    //Map<String,Object> tmp = new Map<String,Object>();
    private Boolean defaultPaymentProfile;
    private String customerProfileId;
    private String customerPaymentProfileId;
    private String originalNetworkTransId;
    // Required for Discover, Diners Club, JCB, and China Union Pay transactions
    private Decimal originalAuthAmount;
    private CustomerPaymentProfile paymentProfile;

    // Optional
    private String refId;


    public GetCustomerPaymentProfileResponse() {
        
    }


    /*
    public override void deserialize() {
        super.deserialize();
        
        Map<String, Object> createBody = (Map<String,Object>)JSON.deserializeUntyped(this.getBody());//this.getBody();
        this.tmp = createBody;

        Boolean isDef = (Boolean) createBody.get('defaultPaymentProfile');
        String custProfileId = (String) createBody.get('customerProfileId');
        String custPaymentProfileId = (String) createBody.get('customerPaymentProfileId');
        CreditCard card = (CreditCard) createBody.get('creditCard');
        string ogNetTransId = (String) createBody.get('originalNetworkTransId');
        Decimal ogAuthAmnt = (Decimal) createBody.get('originalAuthAmount');
        Address billTo = (Address) createBody.get('billTo');
        String refId = (String)createBody.get('refId');

        this.defaultPaymentProfile = isDef;
        this.customerProfileId = custProfileId;
        this.customerPaymentProfileId = custPaymentProfileId;
        this.creditCard = card;
        this.originalNetworkTransId = ogNetTransId;
        this.originalAuthAmount = ogAuthAmnt;
        this.billTo = billTo;
        this.refId = refId;
    }
    
    public List<Map<String,Object>> getPaymentProfiles() {
        List<Map<String,Object>> payProfList = new List<Map<String,Object>>();
        List<Object> paymentProfiles = (List<Object>)this.tmp.get('paymentProfiles');

        for(Object obj : paymentProfiles) {
            Map<String,Object> payment = (Map<String,Object>)obj;

            String paymentProfileId = (String)payment.get('paymentProfileId');
            Map<String,Object> cardObj =  (Map<String,Object>)payment.get('payment');
            Map<String,String> card = (Map<String,String>)cardObj.get('creditCard');
            //CreditCard card = (CreditCard)cardObj.get('creditCard');

            String cardnumber = card.get('cardNumber');
            // by default is masked, request must send unmaskExpirationDate as true to show, else "XXXX"
            String expirationDate = card.get('expirationDate');
            String cardType = card.get('cardType');
            // Only if includeIssuerInfo from request is true
            String issuerNumber = card.get('issuerNumber');
            Map<String,Object> convertedCard = new Map<String,Object> {'cardNumber' => cardnumber, 'expirationDate' => expirationDate, 'cardType' => cardType, 'issuerNumber' => issuerNumber};
            payProfList.add(convertedCard);
        }

        return payProfList;
    }
    */
    public Boolean isDefault() {
        return this.defaultPaymentProfile != null ? this.defaultPaymentProfile : false;
    }

    public String getCustomerProfileId() {
        return this.customerProfileId;
    }

    public String getCustomerPaymentProfileId() {
        return this.customerPaymentProfileId;
    }

    public String getOriginalNetworkTransId() {
        return this.originalNetworkTransId;
    }

    public Decimal getOriginalAuthAmount() {
        return this.originalAuthAmount;
    }

    public String getRefId() {
        return this.refId;
    }

    public CustomerPaymentProfile getPaymentProfile() {
        return this.paymentProfile;
    }
}