public class CreateCustomerProfileRequest extends AuthorizeDotNetRequest{
    //public CustomerProfile profile;

    //public NewCustomerProfile profile;
    //has no profile member
    //instead has the members that would go into a profile
    //public List<AuthNetAddress> shipToList;

    public String validationMode = 'testMode';
    //what about shipping

    //inside of profile
    //public String profileType;

    public String customerProfileId;

    public String merchantCustomerId;

    public String description;

    public String email;

    //inside of paymentProfiles
    public AuthNetAddress billTo;

    public Payment payment;

    public String customerType;

    private static final String CUSTOMER_TYPE_INDIVIDUAL = 'individual';
    private static final String CUSTOMER_TYPE_BUSINESS = 'business';
 
    public CreateCustomerProfileRequest() {
        super('createCustomerProfile');
        this.fields = new Set<String>{'profile', 'validationMode'};
    }

    public CreateCustomerProfileRequest(CreditCard card, AuthNetAddress billTo) {
        this();
        this.payment = new Payment(card);
        this.billTo = billTo;
       
    }
    public CreateCustomerProfileRequest(CreditCard card) {
        this();
        this.payment = new Payment(card);
    }


    //some classses have keyset some don't
    public override Set<String> keySet() {
        // return new Set<String>{'profile', 'shipToList','validationMode'};
        return new Set<String>{'profile', 'validationMode'};
    }


    public String getValidationMode(){
        return this.validationMode;
    }

    public String getMerchantCustomerId(){
        return this.merchantCustomerId;
    }

    public String getEmail(){
        return this.email;
    }

    public String getDescription(){
        return this.description;
    }

    public AuthNetAddress getBillTo() {
        return billTo;
    }

    public Payment getPayment() {
        return payment;
    }
    public String getCardNumber(){
        return this.payment!=null? this.payment.getCreditCard().getCardNumber(): null;
    }

    public String getExpirationDate(){
        return this.payment!=null? this.payment.getCreditCard().getExpirationDate(): null;
    }


    public void setMerchantCustomerId(String merchantCustomerId) {
        this.merchantCustomerId = merchantCustomerId;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setDescription(String description) {
        this.description = description;
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


    // public List<AuthNetAddress> getShipToList(){
    //     if(this.shipToList==null){
    //         this.shipToList = new List<AuthNetAddress>();
    //     }
    //     return this.shipToList;
    // }
    // public AuthNetAddress getShipToList(){
    //     return this.shipToList;
    // }

    public void setValidationMode(String validationMode){
        this.validationMode = validationMode;
    }

    public void setCustomerType (String customerType){
        if(customerType == CUSTOMER_TYPE_INDIVIDUAL  ||  customerType == CUSTOMER_TYPE_BUSINESS){
            this.customerType = customerType;
        }
        else {
            throw new AuthorizeDotNetException ('CustomerType must be individual or business.');
        }
    }

    // public void setShipToList (List<AuthNetAddress> shipToList){
    //     this.shipToList = shipToList;
    // }
    // public void setShipToList (AuthNetAddress shipToList){
    //     this.shipToList = shipToList;
    // }

   

    public override Map<String,Object> toMap() {
        System.debug('CALLING TO MAP on create profile request');
        Map<String,Object> tmp = new Map<String,Object>();


        Map<String, Object> tmpPaymentProfiles = new Map <String, Object> {
            'billTo'=> this.billTo,
            'customerType' => this.customerType, 
            'payment' => this.payment};

        Map<String, Object> tmpProfile = new Map <String, Object> {
            'merchantCustomerId'=> this.merchantCustomerId,
            'description' => this.description, 
            'email' => this.email,
            'paymentProfiles' =>tmpPaymentProfiles
        };

        tmp.put('profile',tmpProfile);
       
        tmp.put('validationMode', this.validationMode);
        
        return tmp;
    }

    public override String getBody(){
        JSONGenerator gen = JSON.createGenerator(true);

        gen.writeStartObject();//start of body
        gen.writeFieldName('createCustomerProfileRequest');
        gen.writeStartObject(); //start of createCustomerProfileRequest
        gen.writeFieldName('merchantAuthentication');
        gen.writeStartObject(); //start merchantAuthentication
        gen.writeStringField('name',this.merchantAuthentication.getName());
        gen.writeStringField('transactionKey', this.merchantAuthentication.getTransactionKey());
        gen.writeEndObject(); //end merchantAuthentication

        gen.writeFieldName('profile');
        gen.writeStartObject();//start of profile
        if(this.merchantCustomerId!=null){
            gen.writeStringField('merchantCustomerId', this.merchantCustomerId);
        }

        if(this.description!=null){
            gen.writeStringField('description', this.description);
        }

        if(this.email!=null){
            gen.writeStringField('email', this.email);
        }

        if(this.merchantCustomerId ==null && this.email==null && this.description ==null){
            throw new AuthorizeDotNetException('A new customer profile must have a value for email, description ,or merchandCustomerId.');
        }

        gen.writeFieldName('paymentProfiles');
        gen.writeStartObject(); //start of payment profiles
        if(this.customerType!=null){
            gen.writeStringField('customerType', this.customerType);
        }
    
        if(this.billTo!=null){
            gen.writeFieldName('billTo');
            gen.writeStartObject(); //start billTo
            Set<String> billToKeys = this.billTo.keySet();
            Map<String,Object> billToMap = this.billTo.toMap();
            for(String key: billToKeys){
                Object value = billToMap.get(key);
                if(key =='customerAddressId'){
                    continue;
                }
                else if(key=='defaultShippingAddress'){
                   gen.writeBooleanField(key, (Boolean)value);
                }
                else if (value!=null){
                    gen.writeStringField(key, (String)value);
                }
                else{
                    gen.writeNullField(key);
                }
            }
            gen.writeEndObject(); //end billTo
        }
        if(this.payment == null){
            throw new AuthorizeDotNetException('A create customer profile request must include a payment method');
        }
        gen.writeFieldName('payment');
        gen.writeStartObject(); //start of payment
        if(this.payment.getCreditCard() == null){
            throw new AuthorizeDotNetException('A payment method must include a credit card');
        }
        gen.writeFieldName('creditCard');
        gen.writeStartObject(); //start of creditCard
        gen.writeStringField('cardNumber', this.getCardNumber());
        gen.writeStringField('expirationDate', this.getExpirationDate());
        gen.writeEndObject(); //end of creditCard
        gen.writeEndObject(); //end of payment

        gen.writeEndObject(); //endof paymentprofiles
        gen.writeEndObject();//end of createCustomerProfileRequest
        gen.writeEndObject();//end of body

        return gen.getAsString();
    }

}