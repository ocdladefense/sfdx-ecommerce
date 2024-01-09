public class CreateCustomerProfileRequest extends AuthorizeDotNetRequest{
    
    public CustomerProfile profile;

    public String validationMode = 'testMode';

    // Either guest or regular. Defaults to regular.
    public String profileType;

    //inside of paymentProfiles
    public List<AuthNetAddress> shipToList;


 



    public CreateCustomerProfileRequest() {
        super('createCustomerProfile');
    }


    public CreateCustomerProfileRequest(CustomerProfile profile) {
        this();
        this.profile = profile;
    }





    //some classses have keyset some don't
    public override Set<String> keySet() {
        // return new Set<String>{'profile', 'shipToList','validationMode'};
        return new Set<String>{'profile'};//, 'validationMode'};
    }


    public String getValidationMode(){
        return this.validationMode;
    }


    public void setValidationMode(String validationMode){
        this.validationMode = validationMode;
    }



    public List<AuthNetAddress> getShipToList(){
        return this.shipToList;
    }


    public void setShipToList(List<AuthNetAddress> shipToList) {
        this.shipToList = shipToList;
    }


    public void addToShipToList(AuthNetAddress theAddress){
        if(this.shipToList == null){
            this.shipToList = new List<AuthNetAddress>();
        }
        this.shipToList.add(theAddress);
    }

   

    public override Map<String,Object> toMap() {

        return new Map<String,Object>{'profile' => this.profile};
    }
    /*
    public override Map<String,Object> toMap() {
        System.debug('CALLING TO MAP on create profile request');
        Map<String,Object> tmp = new Map<String,Object>();


        Map<String, Object> tmpPaymentProfiles = new Map <String, Object> {
            'billTo' => this.billTo,
            'customerType' => this.customerType, 
            'payment' => this.payment};

        Map<String, Object> tmpProfile = new Map <String, Object> {
            'merchantCustomerId' => this.merchantCustomerId,
            'description' => this.description, 
            'email' => this.email,
            'paymentProfiles' => tmpPaymentProfiles
        };

        tmp.put('profile',tmpProfile);
       
        tmp.put('validationMode', this.validationMode);
        
        return tmp;
    }
*/

/*
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
*/
}