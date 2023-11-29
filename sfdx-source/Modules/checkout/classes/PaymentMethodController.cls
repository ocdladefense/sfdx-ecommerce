public class PaymentMethodController {
    
    AuthorizeDotNetClient client;

    String customerProfileId;

    public Contact c {get; set;}

    public AuthNetAddress billTo {get; set;}

    public CreditCard cardInfo {get; set;}

    public CustomerPaymentProfile paymentProfile;

    public Boolean isDefaultPaymentMethod {get; set;}

    public String title {get; private set;}
    
    
    
   
    public PaymentMethodController() {
        
        Map<String,String> params = ApexPages.currentPage().getParameters();
        String action = params.get('action');
        
        // Only provided when editing.
        String paymentProfileId = params.get('paymentProfileId');
        
        // Testing id.
        customerProfileId = '916263569';
        
        // More testing.
        if(null == paymentProfileId) {
            paymentProfileId = '915907992';
        }
        
		client = new AuthorizeDotNetClient();
        
        
        
        
        
        
        if('new' == action) {
            billTo = new AuthNetAddress();
            cardInfo = new CreditCard();
            paymentProfile = new CustomerPaymentProfile();
        } else {
            paymentProfile = doLoadAction(paymentProfileId);
        	Address addy = paymentProfile.getBillTo();
        	cardInfo = paymentProfile.getCard();  
        }
        
        String title = 'Add Payment Method';
        // title = 'Edit Payment Method';
    }
    
    
    public CustomerPaymentProfile doLoadAction(String paymentProfileId) {
        
        GetCustomerPaymentProfileRequest req = new GetCustomerPaymentProfileRequest();
        req.setCustomerPaymentProfileId(paymentProfileId);
        req.setCustomerProfileId(customerProfileId);

        GetCustomerPaymentProfileResponse resp = (GetCustomerPaymentProfileResponse)client.send(req);
        return resp.getPaymentProfile();

        // System.debug(' XXXX - RESPONSE FOR THE ACTIVE PAYMENT PROFILE');
        // System.debug(paymentProfile.getCustomerPaymentProfileId());
    }
    
 


    // Calls CreatePaymentProfile
    
    public Pagereference doCreateAction() {

        paymentProfile = new CustomerPaymentProfile(cardInfo, billTo.getAsAddress());
        paymentProfile.setDefaultPaymentProfile(isDefaultPaymentMethod);

        CreateCustomerPaymentProfileRequest req = new CreateCustomerPaymentProfileRequest(paymentProfile);
        req.setCustomerProfileId(customerProfileId);

        System.debug('Add controller req.getBody' + req.getBody());

        CreateCustomerPaymentProfileResponse resp = (CreateCustomerPaymentProfileResponse)client.send(req);

        System.debug(resp.success());

        return new PageReference('/apex/SavedPaymentMethods');
    }
    
    
    public Pagereference doEditAction() {


        //Address billToAddress = new Address('Testy', 'Tester', 'blah 123', 'Springfield', 'OR', '97477');
        UpdateCustomerPaymentProfileRequest req = new UpdateCustomerPaymentProfileRequest(paymentProfile, billTo.getAsAddress());
        System.debug('XXXX- Payment profile id');
        System.debug(paymentProfile.getCustomerPaymentProfileId());
        System.debug('XXXX - Payment profile keySet...');
        System.debug(paymentProfile.keySet());
        System.debug('XXXX - Update request body...');
        System.debug(req.getBody());

        UpdateCustomerPaymentProfileResponse resp = (UpdateCustomerPaymentProfileResponse)client.send(req);
        System.debug(resp.success());
        
        return new PageReference('/apex/SavedPaymentMethods');
    }

    
    
    public PageReference cancel() {
        return new PageReference('/apex/SavedPaymentMethods');
    }


}