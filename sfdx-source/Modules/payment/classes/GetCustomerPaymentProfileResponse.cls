public class GetCustomerPaymentProfileResponse extends AuthorizeDotNetResponse{
    
    public GetCustomerPaymentProfileResponse() {

    }

    private Boolean defaultPaymentProfile;
    private String customerProfileId;
    private String customerPaymentProfileId;
    private CreditCard creditCard;
    private String originalNetworkTransId;
    // Required for Discover, Diners Club, JCB, and China Union Pay transactions
    private Decimal originalAuthAmount;
    private Address billTo;

    // Optional
    private String refId;

    public override void deserialize() {
        super.deserialize();

        Map<String, Object> createBody = this.temp;

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

    public Boolean isDefault() {
        return this.defaultPaymentProfile != null ? this.defaultPaymentProfile : false;
    }

    public String getCustomerProfileId() {
        return this.customerProfileId;
    }

    public String getCustomerPaymentProfileId() {
        return this.customerPaymentProfileId;
    }

    public CreditCard getCreditCard() {
        return this.creditCard;
    }

    public String getOriginalNetworkTransId() {
        return this.originalNetworkTransId;
    }

    public Decimal getOriginalAuthAmount() {
        return this.originalAuthAmount;
    }

    public Address getBillTo() {
        return this.billTo;
    }

    public String getRefId() {
        return this.refId;
    }
}