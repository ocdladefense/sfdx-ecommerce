public virtual without sharing class Customer {


    public User theUser;
    
	public Contact theContact;
    
    public Account theAccount;
    
    private String customerProfileId;
    
    public String firstName {get; set;}
    
    public String lastName {get; set;}
    
    public String email {get; set;}
    
    
    /**
     * Build the correct Customer object based on whether the current user
     * is a Community User or not
     
    public static Customer GetCustomer() {
    
        if(Session.IsCommunityUser()) {
            
            Contact c = Session.GetCurrentContact();
        	return new CommunityCustomer(c);
        
        } else {
            
        	User u = Session.GetCurrentUser();
            return new StaffCustomer(u);
        
        }

    }
*/

    public Customer() {}    
    
    
    public Customer(String customerProfileId) {
		this.customerProfileId = customerProfileId;
    }
    
    
    
    public String getCustomerProfileId() {
        return this.customerProfileId;
    }
    
    
    
    public CustomerProfile getCustomerProfile() {
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();
        
        GetCustomerProfileRequest req = new GetCustomerProfileRequest();
        req.setCustomerProfileId(customerProfileId);

        GetCustomerProfileResponse resp = (GetCustomerProfileResponse)client.send(req);

        return resp.getProfile();
    }

}