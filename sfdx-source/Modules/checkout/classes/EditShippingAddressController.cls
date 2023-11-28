public with sharing class EditShippingAddressController {
    
    AuthorizeDotNetClient client {get; set;}
    
    String customerProfileId {get; set;}

    public Contact c {get; set;}
    
    public Address shipTo {get; set;}
    
    public String customerAddressId {get; set;}
    
    public List<SelectOption> stateOptions {get; public set;}
    
    
    
    public EditShippingAddressController() {
        this.client = new AuthorizeDotNetClient();

        customerProfileId = CurrentCustomer.getCustomerProfileId();

       	this.customerAddressId = ApexPages.currentPage().getParameters().get('customerAddressId');

        if(this.customerAddressId==null){
            throw new CheckoutException();
        }
  

        shipTo = loadShipTo(customerAddressId);

        this.stateOptions = getStateOptions();
        // Also we need something for dates.
    }


    public Address loadShipTo(String addressId){
        GetCustomerShippingAddressRequest req = new GetCustomerShippingAddressRequest();
        req.setCustomerAddressId(addressId);
        req.setCustomerProfileId(customerProfileId);
        System.debug(req.getBody());
        GetCustomerShippingAddressResponse resp = (GetCustomerShippingAddressResponse)client.send(req);
       
        if(resp.success()) {
            System.debug('success is ' + resp.success());
            return resp.getAddress();
        }
        else {
            Messages messages = resp.getMessages();
            Message message = messages.getFirstMessage();
            
            throw new CheckoutException(message.getText());
        }
    }
   

    public PageReference editShipTo() {

        // Address shipToSubmit = updatedShipTo;
   
        UpdateCustomerShippingAddressRequest req = new UpdateCustomerShippingAddressRequest();
        // System.debug(req.getBody());
        //System.debug(updatedShipTo);
        
        req.setCustomerProfileId(customerProfileId);

        //System.debug(req.getBody());

        req.setAddress(shipTo);
        System.debug(req.getBody());

        //req.setDefaultShippingAddress(false);
        
        UpdateCustomerShippingAddressResponse resp = (UpdateCustomerShippingAddressResponse)client.send(req);

        if(resp.success()) {
            System.debug('success is ' + resp.success());
            return redirectToSavedShippingAddresses();
        }
        else {
            Messages messages = resp.getMessages();
            Message message = messages.getFirstMessage();
            System.debug(message.getText());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter value'));
            return null;
            //display error message on page and refresh page
            //return new PageReference('/apex/ShipToError');
        }

    }
    
    
    
    public Address sampleShipToAddress(){
        Address shipToSample = new Address('Sebastian', 'Williams-Wilson', '200 Mountain View Dr.', 'Reno', 'NV', '89511');
        return shipToSample;
    }

    public PageReference redirectToSavedShippingAddresses() {
        return new Pagereference('/apex/SavedShippingAddresses');
    }



    public List<SelectOption> getStateOptions() {
        List<SelectOption> stateOptions = States.getAsSelectOptions();

        return stateOptions;
    }

}