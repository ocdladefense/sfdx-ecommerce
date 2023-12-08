public class PaymentProfiles extends AuthorizeDotNetType{

    //wrapper class used when creating new customer profile
    //json payload class unable to recognize List<CustomerPaymentProfile> or List<AuthNetAddress> as correct type when building request body

    //looking closely at documentation, createCustomerProfileRequest does NOT take a customerPaymentProfileObject
    //it takes at least one Payment object

    public String customerType;

    public Payment payment;

    private static final String CUSTOMER_TYPE_INDIVIDUAL = 'individual';
    private static final String CUSTOMER_TYPE_BUSINESS = 'business';
 
    public PaymentProfiles() {

    }
    public PaymentProfiles(CreditCard card){
        this();
        this.payment = new Payment(card);
    }

    public PaymentProfiles(Payment thePayment){
        this();
        this.payment = thePayment;
    }

    public override Set<String> keySet() {
        return new Set<String>{'customerType', 'payment'};
    }
  

    public override Map<String,Object> toMap() {
        System.debug('CALLING TO MAP on paymentProfiles');


        Map<String,Object> tmp = new Map<String,Object>();
        tmp.put('customerType', this.customerType);
        tmp.put('payment', this.payment);
       
        if(null == this.customerType) {
            this.ignoreField('customerType');
        }
        if (null == this.payment){
            throw new AuthorizeDotNetException('Payment cannot be null');
        }

        return tmp;
    }
    public String getCustomerType(){
        return this.customerType;
    }
    public Payment getPayment(){
        return this.payment;
    }

    public void setPayment (Payment thePayment){
        this.payment = thePayment;
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