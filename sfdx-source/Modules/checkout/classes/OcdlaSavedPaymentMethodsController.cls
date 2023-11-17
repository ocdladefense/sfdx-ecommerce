public class OcdlaSavedPaymentMethodsController {
    
    AuthorizeDotNetClient client = new AuthorizeDotNetClient();
    String customerProfileId = '905372692';

    public Address billingInfo {get; set;}
    public Payment paymentInfo {get; set;}
    public Boolean isDefaultPaymentMethod {get; set;}
    public List<CustomerPaymentProfile> paymentProfiles {get; set;}
    public String selectedPaymentProfileId {get; set;}
    
    
    public OcdlaSavedPaymentMethodsController() {
        billingInfo = new Address();
        paymentInfo = new Payment();
        client = new AuthorizeDotNetClient();

        paymentProfiles = new List<CustomerPaymentProfile>();

        loadPaymentProfiles();
        
    }

    // Calls CreatePaymentProfile
    
    public void addPaymentProfile() {
        /*
        CustomerPaymentProfile paymentProfile = new CustomerPaymentProfile(paymentInfo.getCreditCard(), billingInfo);
        
        paymentProfile.setDefaultPaymentProfile(isDefaultPaymentMethod);

        // Create request
        CreateCustomerPaymentProfileRequest req = new CreateCustomerPaymentProfileRequest(paymentProfile);
        
        // Send request
        AuthorizeDotNetResponse resp = client.send(req);

        // Handle the response
        if (resp.success()) {
            // Redirect or display success message
            // ...
            return new PageReference('/apex/SavedPaymentMethods');
        } else {
            // Handle errors and display messages

            return null; // Stays on the current page
        }
        */
    }

    
    public void editPaymentProfile() {
        /*
        CustomerPaymentProfile paymentProfile = new CustomerPaymentProfile(paymentInfo.getCreditCard(), billingInfo);
        paymentProfile.setCustomerPaymentProfileId(selectedPaymentProfileId);
        paymentProfile.setDefaultPaymentProfile(isDefaultPaymentMethod);

        UpdateCustomerPaymentProfileRequest req = new UpdateCustomerPaymentProfileRequest(paymentProfile);
        
        AuthorizeDotNetResponse resp = client.send(req);
        */
    }

    
    public void deletePaymentProfile() {
        /*
        DeleteCustomerPaymentProfileRequest req = new DeleteCustomerPaymentProfileRequest();
        req.setCustomerProfileId(customerProfileId);
        req.setCustomerPaymentProfileId(selectedPaymentProfileId);

        AuthorizeDotNetResponse resp = client.send(req);
        */
    }

    public void setDefaultPaymentProfile() {
        editPaymentProfile();
    }

    
    public List<CustomerPaymentProfile> getPaymentPaymentProfiles() {
        GetCustomerProfileRequest req = new GetCustomerProfileRequest(customerProfileId);

        AuthorizeDotNetResponse resp = client.send(req);
    }
    

    


    public PageReference redirectToAddPaymentMethod() {
        return new PageReference('/apex/OcdlaAddPaymentMethod');
    }

    public PageReference redirectToEditPaymentMethod() {
        return new PageReference('/apex/OcdlaEditPaymentMethod');
    }

    public PageReference redirectToSavedPaymentMethods() {
        return new Pagereference('/apex/OcdlaSavedPaymentMethods');
    }

    public void loadPaymentProfiles() {
        paymentProfiles = getPaymentPaymentProfiles()



        // For testing
        paymentProfiles = sampleCustomerPaymentProfileList();
        //paymentProfiles = sampleEmptyCustomerPaymentProfileList();
    }

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

    public List<CustomerPaymentProfile> sampleEmptyCustomerPaymentProfileList() {
        List<CustomerPaymentProfile> profiles = new List<CustomerPaymentProfile>();
        return profiles;
    }
}