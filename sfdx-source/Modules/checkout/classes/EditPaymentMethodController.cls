public class EditPaymentMethodController {
    
    AuthorizeDotNetClient client = new AuthorizeDotNetClient();
    
    public String customerProfileId;
    
    public String paymentProfileId;

    public Contact c {get; set;}

    public AuthNetAddress billingInfo {get; set;}

    public Payment paymentInfo {get; set;}

    public Boolean isDefaultPaymentMethod {get; set;}

    public CustomerPaymentProfile paymentProfile {get; set;}

    public String selectedPaymentProfileId {get; set;}
    



    
    
    public EditPaymentMethodController() {
        billingInfo = new AuthNetAddress();
        paymentInfo = new Payment();
        client = new AuthorizeDotNetClient();
        // c = [SELECT FirstName, LastName, Email FROM Contact WHERE Id = '0037h00000u1YBpAAM'];
        //customerProfileId = '905372692';//c.AuthorizeDotNetCustomerProfileId__c;
        //paymentProfileId = '915752253';
        
        // Steven's sandbox 
        customerProfileId = '916263569';
        paymentProfileId = '915683841';


        GetCustomerPaymentProfileRequest req = new GetCustomerPaymentProfileRequest();
        req.setCustomerPaymentProfileId(paymentProfileId);
        req.setCustomerProfileId(customerProfileId);

        GetCustomerPaymentProfileResponse resp = (GetCustomerPaymentProfileResponse)client.send(req);
        paymentProfile = resp.getPaymentProfile();

        System.debug(' XXXX - RESPONSE FOR THE ACTIVE PAYMENT PROFILE');
        System.debug(paymentProfile.getCustomerPaymentProfileId());

        billingInfo = paymentProfile.getBillTo();
        paymentInfo = paymentProfile.getPayment();
    }

   
        

    
    public Pagereference editPaymentProfile() {


        //Address billToAddress = new Address('Testy', 'Tester', 'blah 123', 'Springfield', 'OR', '97477');
        UpdateCustomerPaymentProfileRequest req = new UpdateCustomerPaymentProfileRequest(paymentProfile, billingInfo);
        System.debug('XXXX- Payment profile id');
        System.debug(paymentProfile.getCustomerPaymentProfileId());
        System.debug('XXXX - Payment profile keySet...');
        System.debug(paymentProfile.keySet());
        System.debug('XXXX - Update request body...');
        System.debug(req.getBody());

        UpdateCustomerPaymentProfileResponse resp = (UpdateCustomerPaymentProfileResponse)client.send(req);
        System.debug(resp.success());
        
        return redirectToSavedPaymentMethods();
    }


    public void setDefaultPaymentProfile(CustomerPaymentProfile custPayProfile) {
        paymentProfile = custPayProfile;
        billingInfo = custPayProfile.getBillTo();
        editPaymentProfile();
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
}