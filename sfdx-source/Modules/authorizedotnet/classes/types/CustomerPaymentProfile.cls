public class CustomerPaymentProfile extends AuthorizeDotNetType{

    private String customerPaymentProfileId;

    private Payment payment; 

    private String originalNetworkTransId;

    private Decimal originalAuthAmount;

    private String customerType;

    public Address billTo {public get; private set;}

    private Boolean defaultPaymentProfile;

    public String cardNumber {public get { return this.payment.getCreditCard().getCardNumber();} private set;}
    
    public String cardType {public get { return this.payment.getCreditCard().getType();} private set;}
    
    

    public CustomerPaymentProfile() {
        super();
    }


    public CustomerPaymentProfile(CreditCard card, Address billTo) {
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

    public static Address newAddressFromMap(Map<String, String> billTo){
        Map<String, String> theAddress = (Map<String, String>)billTo;
        String firstName = theAddress.get('firstName');
        String lastName = theAddress.get('lastName');
        String phoneNumber = theAddress.get('phoneNumber');
        String address = theAddress.get('address');
        String city = theAddress.get('city');
        String state = theAddress.get('state');
        String zip = theAddress.get('zip');
        String country = theAddress.get('country');
        
        //check for nulls?
        Address newAdress = new Address();
        newAdress.setFirstName(firstName);
        newAdress.setLastName(lastName);
        newAdress.setAddress(address);
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

    public Address getBillTo() {
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

    public void setBillTo(Address billTo) {
        this.billTo = billTo;
    }

    public void setPayment(Payment payment) {
        this.payment = payment;
    }

    public void setCard(CreditCard card) {
        this.payment = new Payment(card);
    }

    public void setDefaultPaymentProfile (Boolean defaultPaymentProfile){
        this.defaultPaymentProfile = defaultPaymentProfile;
    }
}