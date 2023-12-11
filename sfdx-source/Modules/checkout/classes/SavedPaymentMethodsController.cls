public class SavedPaymentMethodsController {
    
    private AuthorizeDotNetClient client;

    private String customerProfileId;

    public Contact c {get; set;}

    public AuthNetAddress billingInfo {get; set;}

    public Payment paymentInfo {get; set;}

    public Boolean isDefaultPaymentMethod {get; set;}

    public CustomerProfile customerProfile {public get; private set;}

    transient private List<CustomerPaymentProfile> paymentProfiles;
    
    private CustomerPaymentProfileCollection paymentProfileCollection;    
    
 

    public SavedPaymentMethodsController() {
        billingInfo = new AuthNetAddress();
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

    
    public Pagereference setDefaultPaymentProfile() {
        
        Map<String,String> params = ApexPages.currentPage().getParameters();
        String paymentProfileId = params.get('paymentProfileId');
        
        // Gets a paymentProfile from the paymentProfileCollection by paymentProfileId
        CustomerPaymentProfile selected = this.paymentProfileCollection.get(paymentProfileId);
        selected.setDefault();
        
        UpdateCustomerPaymentProfileRequest req = new UpdateCustomerPaymentProfileRequest(selected);
        req.setCustomerProfileId(this.customerProfileId);

        UpdateCustomerPaymentProfileResponse resp = (UpdateCustomerPaymentProfileResponse)client.send(req);
        
        return null;
    }
    
    public List<CustomerPaymentProfile> getPaymentProfiles() {
        return this.paymentProfileCollection.getAsList();
    }

    public void deletePaymentProfile() {
        Map<String,String> params = ApexPages.currentPage().getParameters();
        String selectedPaymentProfileId = params.get('paymentProfileId');

        DeleteCustomerPaymentProfileRequest req = new DeleteCustomerPaymentProfileRequest();
        req.setCustomerProfileId(customerProfileId);
        req.setCustomerPaymentProfileId(selectedPaymentProfileId);

        DeleteCustomerPaymentProfileResponse resp = (DeleteCustomerPaymentProfileResponse)client.send(req);
    }

    
    public Pagereference redirectToPaymentMethod() {
        Map<String,String> params = ApexPages.currentPage().getParameters();
        String action = params.get('action');
        String selectedPaymentProfileId = params.get('paymentProfileId');

        Pagereference PaymentMethodPage = new PageReference('/apex/PaymentMethod');
        PaymentMethodPage.setRedirect(true);
        PaymentMethodPage.getParameters().put('action', action);
        PaymentMethodPage.getParameters().put('paymentProfileId', selectedPaymentProfileId);

        return PaymentMethodPage;
    }
    

    // Test method
    public List<CustomerPaymentProfile> sampleCustomerPaymentProfileList(){
        List<CustomerPaymentProfile> profiles = new List<CustomerPaymentProfile>();

        //default valid Visa card
        String customerPaymentProfileId2 ='905264263';
        CreditCard card2 = new CreditCard('4444111144441111', '2025-11');
        AuthNetAddress billToAddress2 = new AuthNetAddress('Testy', 'Tester', 'blah 123', 'Springfield', 'OR', '97477');
        CustomerPaymentProfile profile2 = new CustomerPaymentProfile(card2, billToAddress2);
        profile2.setCustomerPaymentProfileId(customerPaymentProfileId2);
        profile2.setDefaultPaymentProfile(true);

        //valid Mastercard card
        String customerPaymentProfileId3 ='905264264';
        CreditCard card3 = new CreditCard('5555111144441111', '2027-02');
        AuthNetAddress billToAddress3 = new AuthNetAddress('Testy', 'Tester', 'blah 123', 'eugene', 'OR', '97477');
        CustomerPaymentProfile profile3 = new CustomerPaymentProfile(card3, billToAddress3);
        profile3.setCustomerPaymentProfileId(customerPaymentProfileId3);
        profile3.setDefaultPaymentProfile(false);

        //valid card number and type expired 

        String customerPaymentProfileId4 ='905264265';
        CreditCard card4 = new CreditCard('5544111155559999', '2023-06');
        AuthNetAddress billToAddress4 = new AuthNetAddress('Testy', 'Tester', 'office park 123', 'Eugene', 'OR', '97454');
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