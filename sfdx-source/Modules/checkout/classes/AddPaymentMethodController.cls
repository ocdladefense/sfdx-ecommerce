public class AddPaymentMethodController {
    
    AuthorizeDotNetClient client = new AuthorizeDotNetClient();

    String customerProfileId;

    public Contact c {get; set;}

    public MyAddress billTo {get; set;}

    public CreditCard cardInfo {get; set;}

    public CustomerPaymentProfile paymentProfile;

    public Boolean isDefaultPaymentMethod {get; set;}

   
    public AddPaymentMethodController() {
        billTo = new MyAddress();
        cardInfo = new CreditCard();
        paymentProfile = new CustomerPaymentProfile();
        client = new AuthorizeDotNetClient();
        // c = [SELECT FirstName, LastName, Email FROM Contact WHERE Id = '0037h00000u1YBpAAM'];
        //customerProfileId = '905372692';//c.AuthorizeDotNetCustomerProfileId__c;
        //paymentProfileId = '915752253';
        
        // Steven's sandbox 
        customerProfileId = '916263569';


    }

    /*
    public SavedPaymentMethodsController() {
        billTo = new MyAddress();
        paymentInfo = new Payment();
        client = new AuthorizeDotNetClient();
        c = [SELECT FirstName, LastName, Email, AuthorizeDotNetCustomerProfileId__c FROM Contact WHERE Id = '0037h00000u1YBpAAM'];
        customerProfileId = c.AuthorizeDotNetCustomerProfileId__c;
        paymentProfiles = new List<CustomerPaymentProfile>();
        // pretend that logged in users Authorize.net customer profile id is called.
        loadPaymentProfiles(false);
        
    }
    */

    // Calls CreatePaymentProfile
    
    public Pagereference addPaymentProfile() {
        System.debug(billTo); // these values are coming from the component and we want to make sure they are being sent to controller.

        /*
        paymentProfile = new CustomerPaymentProfile(cardInfo, billTo);
        paymentProfile.setDefaultPaymentProfile(isDefaultPaymentMethod);

        CreateCustomerPaymentProfileRequest req = new CreateCustomerPaymentProfileRequest(paymentProfile);
        req.setCustomerProfileId(customerProfileId);

        System.debug('Add controller req.getBody' + req.getBody());

        CreateCustomerPaymentProfileResponse resp = (CreateCustomerPaymentProfileResponse)client.send(req);

        System.debug(resp.success());

        return redirectToSavedPaymentMethods();

        
        
        // Handle the response
        if (resp.success()) {
            // Redirect or display success message

            return new PageReference('/apex/SavedPaymentMethods');
        } else {
            // Handle errors and display messages

            return null; // Stays on the current page
        }
        */
        return null;
    }

    public PageReference redirectToSavedPaymentMethods() {
        return new Pagereference('/apex/SavedPaymentMethods');
    }


}