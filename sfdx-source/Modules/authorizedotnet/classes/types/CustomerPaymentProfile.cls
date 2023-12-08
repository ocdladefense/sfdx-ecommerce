public class CustomerPaymentProfile extends AuthorizeDotNetType{

    private String customerPaymentProfileId;

    private Payment payment; 

    private String originalNetworkTransId;

    private Decimal originalAuthAmount;

    private String customerType;

    public AuthNetAddress billTo {public get; private set;}

    private Boolean defaultPaymentProfile;

    public String cardNumber {public get { return this.payment.getCreditCard().getCardNumber();} private set;}
    
    public String cardType {public get { return this.payment.getCreditCard().getType();} private set;}
    
    private static final String CUSTOMER_TYPE_INDIVIDUAL = 'individual';
    private static final String CUSTOMER_TYPE_BUSINESS = 'business';
 

    public CustomerPaymentProfile() {
        super();
    }


    public CustomerPaymentProfile(CreditCard card, AuthNetAddress billTo) {
        this();
        this.billTo = billTo;
        this.payment = new Payment(card);
    }


    public override String getPrimaryKeyField() {
        return 'customerPaymentProfileId';
    }

    public override String getPrimaryKeyValue() {
        return this.customerPaymentProfileId;
    }


    public override Set<String> keySet() {
        return new Set<String>{'billTo', 'payment', 'defaultPaymentProfile', 'customerPaymentProfileId'};
    }


    public override Map<String,Object> toMap() {
        System.debug('CALLING TO MAP on payment profile itself');


        Map<String,Object> tmp = new Map<String,Object>();
        tmp.put('payment', this.payment);
        tmp.put('billTo', this.billTo);
        tmp.put('customerPaymentProfileId', this.customerPaymentProfileId);
        tmp.put('defaultPaymentProfile', this.defaultPaymentProfile);

        if(null == this.defaultPaymentProfile) {
            this.ignoreField('defaultPaymentProfile');
        }

        return tmp;
    }


    
    



    public SelectOption toSelectOption() {
        
        CreditCard card = this.payment.getCreditCard();

        String cardNum = card.getCardNumber();
        String value = this.getCustomerPaymentProfileId();
        String label = card.isExpired() ? (cardNum + ' (expired)') : cardNum;

        return new SelectOption(value, label);
    }

    


    public static CreditCard newCardFromPaymentMap(Map<String, Object> payment){
        Map<String, Object> theCard = ((CreditCard)payment.get('creditCard')).toMap();
        String cardNumber = (String) theCard.get('cardNumber');
        String expirationDate = (String)theCard.get('expirationDate');
       
        CreditCard card = new CreditCard(cardNumber, expirationDate);
        
        return card;
    }

    public static AuthNetAddress newAuthNetAddressFromMap(Map<String, Object> billTo){
        Map<String, String> theAuthNetAddress = (Map<String, String>)billTo;
        String firstName = theAuthNetAddress.get('firstName');
        String lastName = theAuthNetAddress.get('lastName');
        String phoneNumber = theAuthNetAddress.get('phoneNumber');
        String theAddress = theAuthNetAddress.get('AuthNetAddress');
        String city = theAuthNetAddress.get('city');
        String state = theAuthNetAddress.get('state');
        String zip = theAuthNetAddress.get('zip');
        String country = theAuthNetAddress.get('country');
        
        //check for nulls?
        AuthNetAddress newAdress = new AuthNetAddress();
        newAdress.setFirstName(firstName);
        newAdress.setLastName(lastName);
        newAdress.setAddress(theAddress);
        newAdress.setCity(city);
        newAdress.setState(state);
        newAdress.setZip(zip);

        if(country!=null){
            newAdress.setCountry(country);
        }

        if (phoneNumber!=null){
            newAdress.setPhoneNumber(phoneNumber);
        }
        return newAdress;
    }
    

    public String getCustomerPaymentProfileId() {
        return customerPaymentProfileId;
    }

    public AuthNetAddress getBillTo() {
        return billTo;
    }

    public Payment getPayment() {
        return payment;
    }

    public Boolean getDefaultPaymentProfile() {
        return defaultPaymentProfile == null || False == defaultPaymentProfile ? False : True;
    }

    public void setCustomerPaymentProfileId(String customerPaymentProfileId) {
        this.customerPaymentProfileId = customerPaymentProfileId;
    }

    public void setBillTo(AuthNetAddress billTo) {
        this.billTo = billTo;
    }

    public void setPayment(Payment payment) {
        this.payment = payment;
    }

    public void setCard(CreditCard card) {
        this.payment = new Payment(card);
    }
    
    public CreditCard getCard() {
        return this.payment.getCreditCard();
    }

    public void setDefaultPaymentProfile (Boolean defaultPaymentProfile){
        this.defaultPaymentProfile = defaultPaymentProfile;
    }

    public void setDefault() {
        setDefaultPaymentProfile(true);
    }

    public void setCustomerType (String customerType){
        if(customerType == CUSTOMER_TYPE_INDIVIDUAL  ||  customerType == CUSTOMER_TYPE_BUSINESS){
            this.customerType = customerType;
        }
        else {
            throw new AuthorizeDotNetException ('CustomerType must be individual or business.');
        }
    }
}