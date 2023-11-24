public class SavedPaymentMethodsController {
    
    AuthorizeDotNetClient client = new AuthorizeDotNetClient();
    String customerProfileId;
    //String customerProfileId = '905372692';

    public Contact c {get; set;}
    public Address billingInfo {get; set;}
    public Payment paymentInfo {get; set;}
    public Boolean isDefaultPaymentMethod {get; set;}
    public List<CustomerPaymentProfile> paymentProfiles {get; set;}
    public String selectedPaymentProfileId {get; set;}
    
    
    public SavedPaymentMethodsController() {
        billingInfo = new Address();
        paymentInfo = new Payment();
        client = new AuthorizeDotNetClient();
        c = [SELECT FirstName, LastName, Email, AuthorizeDotNetCustomerProfileId__c FROM Contact WHERE Id = '0037h00000u1YBpAAM'];
        customerProfileId = c.AuthorizeDotNetCustomerProfileId__c;
        paymentProfiles = new List<CustomerPaymentProfile>();
        // pretend that logged in users Authorize.net customer profile id is called.
        loadPaymentProfiles(false);
        
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

    // Builds request with no errors, but no field for defaultPaymentMethod
    public Pagereference setDefaultPaymentProfile() {
        EditPaymentMethodController con = new EditPaymentMethodController();
        con.customerProfileId = customerProfileId;
        con.paymentProfileId = selectedPaymentProfileId;
        con.isDefaultPaymentMethod = isDefaultPaymentMethod;
        con.editPaymentProfile();

        return new Pagereference(ApexPages.currentPage().getUrl()).setRedirect(true);
    }

    public CustomerPaymentProfile getPaymentProfile() {
        GetCustomerPaymentProfileRequest req = new GetCustomerPaymentProfileRequest();
        req.setCustomerPaymentProfileId('915683841');
        req.setCustomerProfileId(customerProfileId);

        GetCustomerPaymentProfileResponse resp = (GetCustomerPaymentProfileResponse)client.send(req);
        CustomerPaymentProfile paymentProfile = resp.getPaymentProfile();
        return paymentProfile;
    }
    
    
    

    


    public PageReference redirectToAddPaymentMethod() {
        return new PageReference('/apex/AddPaymentMethod');
    }

    public PageReference redirectToEditPaymentMethod() {
        return new PageReference('/apex/EditPaymentMethod');
    }

    public PageReference redirectToSavedPaymentMethods() {
        return new Pagereference('/apex/SavedPaymentMethods');
    }

    public void loadPaymentProfiles(Boolean mock) {
        //getPaymentPaymentProfiles();



        // For testing
        if(mock) {
            this.paymentProfiles = sampleCustomerPaymentProfileList();
        }
        else {
            this.paymentProfiles = getPaymentProfiles();
        }
        
        //paymentProfiles = sampleEmptyCustomerPaymentProfileList();
    }

    public List<CustomerPaymentProfile> getPaymentProfiles() {
        
        GetCustomerProfileRequest req = new GetCustomerProfileRequest();
        req.setCustomerProfileId(customerProfileId);

        GetCustomerProfileResponse resp = (GetCustomerProfileResponse)client.send(req);
        CustomerProfile profile = resp.getProfile();
        List<CustomerPaymentProfile> paymentProfiles = profile.getPaymentProfiles();

        return paymentProfiles;
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