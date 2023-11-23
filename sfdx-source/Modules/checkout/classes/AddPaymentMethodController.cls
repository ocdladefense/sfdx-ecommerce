public class AddPaymentMethodController {
    
    AuthorizeDotNetClient client = new AuthorizeDotNetClient();

    String customerProfileId;

    public Contact c {get; set;}

    public Address billingInfo {get; set;}

    public Payment paymentInfo {get; set;}

    
    public AddPaymentMethodController() {
        billingInfo = new Address();
        paymentInfo = new Payment();
        client = new AuthorizeDotNetClient();
        // c = [SELECT FirstName, LastName, Email FROM Contact WHERE Id = '0037h00000u1YBpAAM'];
        //customerProfileId = '905372692';//c.AuthorizeDotNetCustomerProfileId__c;
        //paymentProfileId = '915752253';
        
        // Steven's sandbox 
        customerProfileId = '916263569';


    }

    /*
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
    */

    // Calls CreatePaymentProfile
    
    public Pagereference addPaymentProfile() {

        CustomerPaymentProfile paymentProfile = new CustomerPaymentProfile(paymentInfo.getCreditCard(), billingInfo);

        CreateCustomerPaymentProfileRequest req = new CreateCustomerPaymentProfileRequest(paymentProfile);
        req.setCustomerProfileId(customerProfileId);

        CreateCustomerPaymentProfileResponse resp = (CreateCustomerPaymentProfileResponse)client.send(req);

        System.debug(resp.success());

        return redirectToSavedPaymentMethods();

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