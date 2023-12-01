public with sharing class ShippingMethodController {
    
    
    AuthorizeDotNetClient client;

    String customerProfileId;

    public Contact c {get; set;}

    public AuthNetAddress shipTo {get; set;}

    public Boolean isDefaultShippingAddress {get; set;}

    public String title {get; private set;}

    public ShippingMethodController() {

        customerProfileId = CurrentCustomer.getCustomerProfileId();

        Map<String,String> params = ApexPages.currentPage().getParameters();
        String action = params.get('action');
        System.debug('ShippingMethodController action: ' + action); 
        
        // Only provided when editing.
        String customerAddressId = params.get('customerAddressId');
    
        
		client = new AuthorizeDotNetClient();
        
        
        // if('new' == action) {
        //     shipTo = new AuthNetAddress();
           
        // } else {
        //     Address address = doLoadAction(customerAddressId);
        //     transferAddress(address);
        // }

        shipTo = new AuthNetAddress();
        this.title='Add a new shipping address';

        if(customerAddressId!=null){
            Address address = doLoadAction(customerAddressId);
            transferAddress(address);
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

        UpdateCustomerShippingAddressRequest req = new UpdateCustomerShippingAddressRequest (shipTo.getAsAddress());
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
        shipTo.setFirstName(addy.getFirstName());
        shipTo.setLastName(addy.getFirstName());
        shipTo.setAddress(addy.getAddress());
        shipTo.setCity(addy.getCity());
        shipTo.setState(addy.getState());
        shipTo.setZip(addy.getZip());
        shipTo.setCountry(addy.getCountry());
        shipTo.setPhoneNumber(addy.getPhoneNumber());
    }
}