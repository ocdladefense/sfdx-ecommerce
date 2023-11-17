public class CustomerPaymentProfile extends AuthorizeDotNetType {

    private String customerPaymentProfileId;

    private Payment payment; 

    private String originalNetworkTransId;

    private Decimal originalAuthAmount;

    private String customerType;

    private Address billTo;

    private Boolean defaultPaymentProfile;
    


    public CustomerPaymentProfile() {
        this.fields = new Set<String>{'customerPaymentProfileId','billTo','payment','defaultPaymentProfile'};
    }

    public CustomerPaymentProfile(CreditCard card, Address billTo) {
        this();
        this.billTo = billTo;
        this.payment = new Payment(card);
    }

  public override Map<String,Object> toMap() {
    Map<String,Object> tmp = new Map<String,Object>();
    tmp.put('payment', this.payment );
    tmp.put('billTo', this.billTo);
    tmp.put('defaultPaymentProfile', this.defaultPaymentProfile);

    return tmp;
  }

    



    public static List<SelectOption> toSelectOptions(List<CreditCard> cards) {
        System.debug('Input Cards: ' + cards);
        List<SelectOption> cardValues = new List<SelectOption>();

        // original loop to populate select options
        /*
        for (CreditCard card : cards) {
            String viewableCardNum;
            String expDate = card.getExpirationDate();
            List<string> splitExp = exp.split('-');
            String year = splitExp[0];
            String month = splitExp[1];
            expDate = month + '/' + year;
            if(isExpired(card)) {
                viewableCardNum = card.getCardNumber();
                viewableCardNum = viewableCardNum + '(expired)';
            }
            cardValues.add(new SelectOption(card.getId(), viewableCardNum));
            if (card.getIsDefault())
            {
                defaultCard = card;
            }
        }   
        */

        // updated loop to populate select options
        for (CreditCard card : cards) {
            String viewableCardNum = card.getCardNumber();
            if(card.isExpired()) {
                viewableCardNum = viewableCardNum + '(expired)';
            }
            //cardValues.add(new SelectOption(String.valueOf(card.getId()), viewableCardNum));
            
            // ---TODO---
            // fix later after defaultCard is fully investigated in OcdlaCheckoutController
            // currently not needed for testing
            /*
            if (card.getIsDefault())
            {
                defaultCard = card;
            }
            */
        }

        cardValues.add(new SelectOption('newCard', 'Add New Card'));
        System.debug('Output SelectOptions: ' + cardValues);
        return cardValues;
    }

    


    public static CreditCard newCardFromPaymentMap(Map<String, Object> payment){
        Map<String, Object> theCard = (Map<String, Object>)payment.get('creditCard');
        String cardNumber = (String) theCard.get('cardNumber');
       
        CreditCard card = new CreditCard(cardNumber);
        
        String expirationDate = (String)theCard.get('expirationDate');
        card.setExpirationDate(expirationDate);
        return card;
    }

    public static Address newAddressFromMap(Map<String, Object> billTo){
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
        return defaultPaymentProfile;
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
        this.defaultPaymentProfile= defaultPaymentProfile;
    }
}