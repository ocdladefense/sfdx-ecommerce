public class SavedPaymentMethodsController {
    
    private AuthorizeDotNetClient client;

    private String customerProfileId;

    public Contact c {get; set;}

    public Address billingInfo {get; set;}

    public Payment paymentInfo {get; set;}

    public Boolean isDefaultPaymentMethod {get; set;}

    public CustomerProfile customerProfile {public get; private set;}

    transient private List<CustomerPaymentProfile> paymentProfiles;
    
    private CustomerPaymentProfileCollection paymentProfileCollection;

    public String selectedPaymentProfileId {get; set;}
    
    
 

    public SavedPaymentMethodsController() {
        billingInfo = new Address();
        paymentInfo = new Payment();
        Boolean useMock = False;
        

        client = new AuthorizeDotNetClient();
        
        paymentProfiles = new List<CustomerPaymentProfile>();
        // pretend that logged in users Authorize.net customer profile id is called.
        customerProfileId = CurrentCustomer.getCustomerProfileId();
        
        if(!useMock) {
            GetCustomerProfileRequest req = new GetCustomerProfileRequest();
            req.setCustomerProfileId(customerProfileId);

            GetCustomerProfileResponse resp = (GetCustomerProfileResponse)client.send(req);
            this.customerProfile = resp.getProfile();
            this.paymentProfiles = this.customerProfile.getPaymentProfiles();
            this.paymentProfileCollection = new CustomerPaymentProfileCollection(this.paymentProfiles);
        }
        else {
            this.paymentProfiles = sampleCustomerPaymentProfileList();
        }
    }

    

    // Builds request with no errors, but no field for defaultPaymentMethod
    public Pagereference setDefaultPaymentProfile() {
        
        Map<String,String> params = ApexPages.currentPage().getParameters();
        System.debug(params);
        String paymentProfileId = params.get('paymentProfileId');
        
        // Gets a paymentProfile from the paymentProfileCollection by paymentProfileId
        CustomerPaymentProfile selected = this.paymentProfileCollection.get(paymentProfileId);
        selected.setDefault();
        
        UpdateCustomerPaymentProfileRequest req = new UpdateCustomerPaymentProfileRequest(selected);
        req.setCustomerProfileId(this.customerProfileId);

        System.debug(req.getBody());

        UpdateCustomerPaymentProfileResponse resp = (UpdateCustomerPaymentProfileResponse)client.send(req);

        System.debug(resp.getBody());
        
        return null;
    }
    
    public List<CustomerPaymentProfile> getPaymentProfiles() {
        return this.paymentProfileCollection.getAsList();
    }





    public Pagereference deletePaymentProfile() {
        
        DeleteCustomerPaymentProfileRequest req = new DeleteCustomerPaymentProfileRequest();
        req.setCustomerProfileId(customerProfileId);
        req.setCustomerPaymentProfileId(selectedPaymentProfileId);

        DeleteCustomerPaymentProfileResponse resp = (DeleteCustomerPaymentProfileResponse)client.send(req);
        
        // Forces a full page reload
        return new Pagereference(ApexPages.currentPage().getUrl()).setRedirect(true);
    }


    // TODO: can I call a method in EditPaymentMethodController?
    // TODO: setDefaultPaymentMethod needs to set the selected payment method as default and set all other payment methods to not default
    //
    //
    /*
    // Gives null reference error in JsonPayload
    public Pagereference setDefaultPaymentProfile() {
        //editPaymentProfile();
        CustomerPaymentProfile paymentProfile = getPaymentProfile();
        billingInfo = paymentProfile.getBillTo();
        System.debug('SPMController paymentProfile: ' + paymentProfile);
        paymentProfile.setDefaultPaymentProfile(isDefaultPaymentMethod);
        System.debug('SPMController paymentProfile.defaultPaymentProfile: ' + paymentProfile.getDefaultPaymentProfile());


        UpdateCustomerPaymentProfileRequest req = new UpdateCustomerPaymentProfileRequest(paymentProfile, billingInfo);
        System.debug('Test');
        System.debug('SPMController req.getBody: ' + req.getBody());
        System.debug('Test');
        UpdateCustomerPaymentProfileResponse resp = (UpdateCustomerPaymentProfileResponse)client.send(req);
        System.debug('Test');
        
        return new Pagereference(ApexPages.currentPage().getUrl()).setRedirect(true);
    }
    */
    
        /*
        EditPaymentMethodController con = new EditPaymentMethodController();
        con.customerProfileId = customerProfileId;
        con.paymentProfileId = selectedPaymentProfileId;
        con.isDefaultPaymentMethod = isDefaultPaymentMethod;
        con.editPaymentProfile();
		*/
		
        /*
        for(CustomerPaymentProfile paymentProfile : paymentProfiles) {
            if(paymentProfile.getCustomerPaymentProfileId() == selectedPaymentProfileId) {
                con.paymentProfileId = selectedPaymentProfileId;
                con.isDefaultPaymentMethod = isDefaultPaymentMethod; // could just hardcode value here
            }
            else {
                con.paymentProfileId = paymentProfile.getCustomerPaymentProfileId();
                con.isDefaultPaymentMethod = !isDefaultPaymentMethod;
            }
            con.editPaymentProfile();
        }
        */


    

    public CustomerPaymentProfile getPaymentProfile() {
        GetCustomerPaymentProfileRequest req = new GetCustomerPaymentProfileRequest();
        req.setCustomerPaymentProfileId('915683841');
        req.setCustomerProfileId(customerProfileId);

        GetCustomerPaymentProfileResponse resp = (GetCustomerPaymentProfileResponse)client.send(req);
        CustomerPaymentProfile paymentProfile = resp.getPaymentProfile();
        return paymentProfile;
    }
    
    
    
    public Pagereference redirectToPaymentMethod() {
        Map<String,String> params = ApexPages.currentPage().getParameters();
        String action = params.get('action');

        Pagereference PaymentMethodPage = new PageReference('/apex/PaymentMethod');
        PaymentMethodPage.setRedirect(true);
        PaymentMethodPage.getParameters().put('action', action);

        return PaymentMethodPage;
    }
    


    public PageReference redirectToAddPaymentMethod() {
        return new PageReference('/apex/AddPaymentMethod');
    }

    public PageReference redirectToEditPaymentMethod() {
        Pagereference editPage = new PageReference('/apex/EditPaymentMethod');
        editPage.setRedirect(true);
        editPage.getParameters().put('paymentProfileId', selectedPaymentProfileId);
        system.debug(editPage.getParameters());
        return editPage;

        //return new PageReference('/apex/EditPaymentMethod');
    }

    public PageReference redirectToSavedPaymentMethods() {
        return new Pagereference('/apex/SavedPaymentMethods');
    }

    

    // Test method
    public List<CustomerPaymentProfile> sampleCustomerPaymentProfileList(){
        List<CustomerPaymentProfile> profiles = new List<CustomerPaymentProfile>();

        //default valid Visa card
        String customerPaymentProfileId2 ='905264263';
        CreditCard card2 = new CreditCard('4444111144441111', '2025-11');
        Address billToAddress2 = new Address('Testy', 'Tester', 'blah 123', 'Springfield', 'OR', '97477');
        CustomerPaymentProfile profile2 = new CustomerPaymentProfile(card2, billToAddress2);
        profile2.setCustomerPaymentProfileId(customerPaymentProfileId2);
        profile2.setDefaultPaymentProfile(true);

        //valid Mastercard card
        String customerPaymentProfileId3 ='905264264';
        CreditCard card3 = new CreditCard('5555111144441111', '2027-02');
        Address billToAddress3 = new Address('Testy', 'Tester', 'blah 123', 'eugene', 'OR', '97477');
        CustomerPaymentProfile profile3 = new CustomerPaymentProfile(card3, billToAddress3);
        profile3.setCustomerPaymentProfileId(customerPaymentProfileId3);
        profile3.setDefaultPaymentProfile(false);

        //valid card number and type expired 

        String customerPaymentProfileId4 ='905264265';
        CreditCard card4 = new CreditCard('5544111155559999', '2023-06');
        Address billToAddress4 = new Address('Testy', 'Tester', 'office park 123', 'Eugene', 'OR', '97454');
        CustomerPaymentProfile profile4 = new CustomerPaymentProfile(card4, billToAddress4);
        profile3.setCustomerPaymentProfileId(customerPaymentProfileId3);
        profile3.setDefaultPaymentProfile(false);

        //add to list
        profiles.add(profile2);
        profiles.add(profile3);
        profiles.add(profile4);
        
        //return list
        return profiles;
    } 

    // Test method
    public List<CustomerPaymentProfile> sampleEmptyCustomerPaymentProfileList() {
        List<CustomerPaymentProfile> profiles = new List<CustomerPaymentProfile>();
        return profiles;
    }
}