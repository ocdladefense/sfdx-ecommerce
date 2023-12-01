public with sharing class ShippingMethodController {
    
    
    AuthorizeDotNetClient client;

    String customerProfileId {get; set;}
    String customerAddressId {get; set;}

    public Contact c {get; set;}

    public AuthNetAddress shipTo {get; set;}

    public Address addy {get;set;}

    public Boolean isDefaultShippingAddress {get; set;}

    public String title {get; private set;}

    public string action{get; set;}

    public ShippingMethodController() {

        customerProfileId = CurrentCustomer.getCustomerProfileId();

        Map<String,String> params = ApexPages.currentPage().getParameters();
        action = params.get('action');
        System.debug('ShippingMethodController action: ' + action); 
        
        // Only provided when editing.
        customerAddressId = params.get('customerAddressId');
        System.debug(customerAddressId + 'is passed in');
        
		client = new AuthorizeDotNetClient();
        
        shipTo = new AuthNetAddress();
        this.title='Add a new shipping address';
        if('update' == action) {
            Address address = doLoadAction(customerAddressId);
            transferAddress(address);
            system.debug(shipTo);
            this.title = 'Edit Shipping Address';
        }        
    }
    
    
    public Address doLoadAction(String customerAddressId) {
        GetCustomerShippingAddressRequest req = new GetCustomerShippingAddressRequest();
        req.setCustomerAddressId(customerAddressId);
        req.setCustomerProfileId(customerProfileId);

        Boolean isClientNull = client==null;
        if(isClientNull){
            throw new CheckoutException('AuthorizeDotNetClient must not be null');
        }
        
        GetCustomerShippingAddressResponse resp = (GetCustomerShippingAddressResponse)client.send(req);
        System.debug(resp.getBody());
        return resp.getAddress();
    }
    
 


    // Calls CreateShippingAddress
    
    public Pagereference doCreateAction() {
        //CreateCustomerShippingAddressRequest req = new CreateCustomerShippingAddressRequest(shipTo.getAsAddress());
        if(shipTo.zip==null || shipTo.zip==''){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter a zip code. ' ));
            return null;
        }
        
        //create request has authnetaddress right now
        CreateCustomerShippingAddressRequest req = new CreateCustomerShippingAddressRequest(shipTo);
        req.setCustomerProfileId(customerProfileId);
        req.setDefaultShippingAddress(isDefaultShippingAddress);

        System.debug('Add req.getBody' + req.getBody());

        Boolean isClientNull = client==null;
        if(isClientNull){
            throw new CheckoutException('AuthorizeDotNetClient must not be null');
        }

        CreateCustomerShippingAddressResponse resp = (CreateCustomerShippingAddressResponse)client.send(req);

        if(resp.success()){
            system.debug('new address id is ' + resp.getCustomerAddressId());
            return new PageReference('/apex/SavedShippingAddresses');
        }
        else{
            Messages messages = resp.getMessages();
            Message message = messages.getFirstMessage();
            String messageText = message.getText();
            
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'Unable to add this address. ' + messageText));
            return null;

        }

    }
    
    
    public Pagereference doEditAction() {

        // if(shipTo.getCustomerAddressId==null){
        //     shipTo.setCustomerAddressId(customerAddressId);
        // }
        shipTo.setCustomerAddressId(customerAddressId);
        UpdateCustomerShippingAddressRequest req = new UpdateCustomerShippingAddressRequest (shipTo.getAsAddress());
        req.setCustomerProfileId(customerProfileId);
        
        System.debug(req.getBody());

        UpdateCustomerShippingAddressResponse resp = (UpdateCustomerShippingAddressResponse)client.send(req);
        System.debug(resp.success());

        if(resp.success()){
            return new PageReference('/apex/SavedShippingAddresses');
        }
        else{
            Messages messages = resp.getMessages();
            Message message = messages.getFirstMessage();
            System.debug(message.getText());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Unable to update this address. ' + message.getText()));
            return null;
        }
    }

    
    
    public PageReference cancel() {
        return new PageReference('/apex/SavedShippingAddresses');
    }

    public void transferAddress(Address addy) {
        shipTo = new AuthNetAddress();
        if(addy.getFirstName()!=null){
            shipTo.setFirstName(addy.getFirstName());
        }
        if(addy.getLastName()!=null){
            shipTo.setLastName(addy.getLastName());
        }
        if(addy.getAddress()!=null){
            shipTo.setAddress(addy.getAddress());
        }
        if(addy.getCity()!=null){
            shipTo.setCity(addy.getCity());
        }
        if(addy.getState()!=null){
            shipTo.setState(addy.getState());
        }
        if(addy.getZip()!=null){
            shipTo.setZip(addy.getZip());
        }
        if(addy.getCountry()!=null){
            shipTo.setCountry(addy.getCountry());
        }
        if(addy.getPhoneNumber()!=null){
            shipTo.setPhoneNumber(addy.getPhoneNumber());
        }
        if(addy.getCompany()!=null){
            shipTo.setCompany(addy.getCompany());
        }
    }
}