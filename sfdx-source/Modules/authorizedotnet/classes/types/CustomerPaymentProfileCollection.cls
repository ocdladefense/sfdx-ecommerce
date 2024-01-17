public class CustomerPaymentProfileCollection {

    private List<CustomerPaymentProfile> paymentProfiles;


    private Map<String, CustomerPaymentProfile> theMap = new Map<String, CustomerPaymentProfile>(); 
    
    
    

    
    public CustomerPaymentProfileCollection(List<CustomerPaymentProfile> profiles) {
        
        List<CustomerPaymentProfile> tmp = profiles;
        
        
		List<CustomerPaymentProfile> options = new List<CustomerPaymentProfile>();
        
       	List<CustomerPaymentProfile> defaultCardFirst = new List<CustomerPaymentProfile>();
        
        for(CustomerPaymentProfile profile : tmp) {
            theMap.put(profile.getCustomerPaymentProfileId(), profile);
            
            if(profile.getDefaultPaymentProfile()) {
                defaultCardFirst.add(profile);
            }
              
            else {
            	
                options.add(profile);
            }

        }
        
        // Effectively appends others *after the default option,
        // keeping the default first in the list.
        defaultCardFirst.addAll(options);
        
        this.paymentProfiles = defaultCardFirst;
    }
    
    public List<CustomerPaymentProfile> getAsList() {
        return this.paymentProfiles;
    }
    
    
    public CustomerPaymentProfile getDefault() {
        return this.paymentProfiles != null && this.paymentProfiles.size() > 0 ? this.paymentProfiles[0] : null;
    }
    
    public Integer size() {
        return null == this.paymentProfiles ? 0 : this.paymentProfiles.size();
    }

    public CustomerPaymentProfile get(String paymentProfileId) {
        return theMap.get(paymentProfileId);
    }
}