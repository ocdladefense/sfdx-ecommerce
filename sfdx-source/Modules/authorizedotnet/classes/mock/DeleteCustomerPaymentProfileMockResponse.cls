public class DeleteCustomerPaymentProfileMockResponse extends AuthorizeDotNetResponse implements IMockResponse{
    
    private boolean isErrorTest;

    public DeleteCustomerPaymentProfileMockResponse() {
        super();
    }

    //when testing for an error call setIsErrorTest
    public override String getBody() {
        return okDeletePaymentProfileResponseBody();
    }
   
    public static String okDeletePaymentProfileResponseBody(){
        return'{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}';
    }

    public static String errorDeletePaymentProfileResponseBody(){
        return'{"messages":{"resultCode":"Error","message":[{"code":"E00105","text":"The specified payment profile is associated with an active or suspended subscription and cannot be deleted"}]}}';
    }


    public static List<String> samplePaymentProfileIds() {
        List<CustomerPaymentProfile> profiles =sampleCustomerPaymentProfileList();
        List <String> paymentProfileIds = new List<String>();

        for (CustomerPaymentProfile profile : profiles){
            String customerPaymentProfileId = profile.getCustomerPaymentProfileId();
            paymentProfileIds.add(customerPaymentProfileId);
        }

        return paymentProfileIds;
    } 

    
    public static CustomerPaymentProfile sampleCustomerPaymentProfile(){
        String customerProfileId= '905372692';
        String customerPaymentProfileId ='905264262';
        CreditCard card = new CreditCard('123456789022', Date.newInstance(2026, 8, 1));
        Address billToAddress = new Address('mara', 'williams', 'blah 123', 'eugene', 'oregon', '97454');
        CustomerPaymentProfile profile = new CustomerPaymentProfile(card, billToAddress);
        profile.setCustomerPaymentProfileId(customerPaymentProfileId);
        return profile;
    }
    public static List<CustomerPaymentProfile> sampleCustomerPaymentProfileList(){
        List<CustomerPaymentProfile> profiles = new List<CustomerPaymentProfile>();

        //invalid card
        String customerProfileId= '905372692';
        String customerPaymentProfileId ='905264262';
        CreditCard card = new CreditCard('123456789022', Date.newInstance(2026, 8, 1));
        Address billToAddress = new Address('mara', 'williams', 'blah 123', 'eugene', 'oregon', '97454');
        CustomerPaymentProfile profile = new CustomerPaymentProfile(card, billToAddress);
        profile.setCustomerPaymentProfileId(customerPaymentProfileId);

        //default valid Visa card
        String customerPaymentProfileId2 = '905264263';
        CreditCard card2 = new CreditCard('4444111144441111', Date.newInstance(2025, 11, 1));
        Address billToAddress2 = new Address('mara', 'williams', 'blah 123', 'eugene', 'oregon', '97454');
        CustomerPaymentProfile profile2 = new CustomerPaymentProfile(card, billToAddress);
        profile2.setCustomerPaymentProfileId(customerPaymentProfileId2);
        profile2.setDefaultPaymentProfile(true);

        //valid Mastercard card
        String customerPaymentProfileId3 ='905264264';
        CreditCard card3 = new CreditCard('5555111144441111', Date.newInstance(2027, 2, 1));
        Address billToAddress3 = new Address('mara', 'morgan', 'blah 123', 'eugene', 'oregon', '97454');
        CustomerPaymentProfile profile3 = new CustomerPaymentProfile(card, billToAddress);
        profile3.setCustomerPaymentProfileId(customerPaymentProfileId3);
        profile3.setDefaultPaymentProfile(false);

        //valid card number and type expired 

        String customerPaymentProfileId4 = '905264265';
        CreditCard card4 = new CreditCard('5544111155559999', Date.newInstance(2023, 6, 1));
        Address billToAddress4 = new Address('Mara', 'Williams', 'office park 123', 'Eugene', 'OR', '97402');
        CustomerPaymentProfile profile4 = new CustomerPaymentProfile(card, billToAddress);
        profile3.setCustomerPaymentProfileId(customerPaymentProfileId3);
        profile3.setDefaultPaymentProfile(false);

        //add to list
        profiles.add(profile);
        profiles.add(profile2);
        profiles.add(profile3);
        profiles.add(profile4);
        
        //return list
        return profiles;
    }
    public static Boolean setIsErrorTestByPaymentProfileId(String customerPaymentProfileId){
    
        List <String> paymentProfileIds = samplePaymentProfileIds();
        Integer matches=0;
        for (String paymentProfileId : paymentProfileIds){
            
            if (paymentProfileId==customerPaymentProfileId){
                matches++;
            }
        }
       
        return matches==0;
    }



}