public with sharing class SavedShippingAddressesController {

    AuthorizeDotNetClient client {get; set;}


    String customerProfileId;

    public Contact c {get; set;}
    
    public List<AuthNetAddress> shipToList {get; set;}

    public String customerAddressId {get; set;}

    public String defaultShippingAddressId {get; set;}
    
    private static final Boolean mock = False;
    
    
    
    public SavedShippingAddressesController() {
           
        this.client = new AuthorizeDotNetClient();
     
        this.customerProfileId = CurrentCustomer.getCustomerProfileId();
        
        // CustomerProfile theProfile = new CustomerProfile(customerProfileId);

        GetCustomerProfileRequest req = new GetCustomerProfileRequest();
        req.setCustomerProfileId(this.customerProfileId);
        GetCustomerProfileResponse resp = (GetCustomerProfileResponse) client.send(req);
        
        CustomerProfile theProfile = this.loadCustomerProfile();

        if(theProfile==null){
            throw new CheckoutException ('customer profile must not be null');
        }

        //method will send getCustomerProfileRequest to get list of shipping addresses 
        //THEN it will iterate through the list calling getCustomerShippingAddressRequest(s) to find the default shipping address
        //then it will construct the address collection
        AuthNetAddressCollection theCollection = theProfile.getShipToCollection();

        //use collection's getDefault method to get the default
        AuthNetAddress theAddress = theCollection.getDefault();

        System.debug(theAddress);
        this.defaultShippingAddressId = theAddress.getCustomerAddressId();

        this.shipToList = theCollection.getAsList();   

        system.debug('default is '+ defaultShippingAddressId);

    }

    public CustomerProfile loadCustomerProfile(){
        GetCustomerProfileRequest req = new GetCustomerProfileRequest();
        req.setCustomerProfileId(this.customerProfileId);
        GetCustomerProfileResponse resp = (GetCustomerProfileResponse) client.send(req);
        
        return resp.success()? resp.getProfile() : null;
    }
    

    public PageReference setShippingMethod(){
        Map<String,String> params = ApexPages.currentPage().getParameters();
        String action = params.get('action');
        String customerAddressId = params.get('customerAddressId');
      
        System.debug('action = ' + action + ' id = '+ customerAddressId);

        Pagereference ShippingMethodPage = new PageReference('/apex/ShippingMethod');
        ShippingMethodPage.setRedirect(true);
        ShippingMethodPage.getParameters().put('action', action);
        if(customerAddressId!=null){
            ShippingMethodPage.getParameters().put('customerAddressId', customerAddressId);
    
        }

        return ShippingMethodPage;
    }
    
    public PageReference editThisAddress() {
        //when the user clicks edit link
        //set the customerAddressId
        
        string customerAddressId = Apexpages.currentPage().getParameters().get('customerAddressId');

        //able to set a parameter
        if(customerAddressId!=null){
            Pagereference page = new PageReference('/apex/ShippingMethod');
            page.setRedirect(true);
            page.getParameters().put('customerAddressId', customerAddressId);
            page.getParameters().put('action', 'update');
            system.debug(page.getParameters());
            return page;
        }
        else {
            return new PageReference('/apex/AddShippingAddress');

        }
    }

    public PageReference deleteThisAddress() {

        //delete directly
        DeleteCustomerShippingAddressRequest req = new DeleteCustomerShippingAddressRequest();
        req.setCustomerProfileId(customerProfileId);

        customerAddressId = Apexpages.currentPage().getParameters().get('customerAddressId');

        req.setCustomerAddressId(customerAddressId);
        String result = req.getBody();

        Boolean isClientNull = client ==null;
        if(isClientNull){
            throw new CheckoutException('AuthorizeDotNetClient must not be null');
        }

        AuthorizeDotNetResponse resp = (AuthorizeDotNetResponse)client.send(req);
        
        if(resp.success()){
            System.debug(customerAddressId + ' has been deleted');
            return new Pagereference(ApexPages.currentPage().getUrl()).setRedirect(true);

        }
        else{
            Messages messages = resp.getMessages();
            Message message = messages.getFirstMessage();
            System.debug(message.getText());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Unable to delete this address. ' + message.getText()));
            return null;
        }


    }
    
    public PageReference redirectToShippingMethod() {
        return new PageReference('/apex/ShippingMethod');
    }

    public PageReference redirectToSavedShippingAddresses() {
        return new Pagereference('/apex/SavedShippingAddresses');
    }

}