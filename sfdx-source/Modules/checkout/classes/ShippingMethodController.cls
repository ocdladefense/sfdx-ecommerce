public with sharing class ShippingMethodController {
    
    
    AuthorizeDotNetClient client;

    String customerProfileId;

    public Contact c {get; set;}

    public AuthNetAddress shipTo {get; set;}

    public Boolean isDefaultShippingAddress {get; set;}

    public String title {get; private set;}

    public ShippingMethodController() {

        shipTo = new AuthNetAddress();

        customerProfileId = CurrentCustomer.getCustomerProfileId();

        Map<String,String> params = ApexPages.currentPage().getParameters();
        String action = params.get('action');
        System.debug('ShippingMethodController action: ' + action); 
        
        // Only provided when editing.
        String customerAddressId = params.get('customerAddressId');
      
        // More testing.
        // if(null == customerAddressId) {
        //     customerAddressId = '915907992';
        // }
        
		client = new AuthorizeDotNetClient();
        
        
        // if('new' == action) {
        //     shipTo = new AuthNetAddress();
           
        // } else {
        //     Address address = doLoadAction(customerAddressId);
        //     transferAddress(address);
        // }
        
        String title = 'Add New Shipping Address';
        
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
    
 


    // Calls CreatePaymentProfile
    
    public Pagereference doCreateAction() {
        //CreateCustomerShippingAddressRequest req = new CreateCustomerShippingAddressRequest(shipTo.getAsAddress());
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

        System.debug(resp.success());

        return new PageReference('/apex/SavedShippingAddresses');
    }
    
    
    public Pagereference doEditAction() {


        //Address billToAddress = new Address('Testy', 'Tester', 'blah 123', 'Springfield', 'OR', '97477');
        UpdateCustomerShippingAddressRequest req = new UpdateCustomerShippingAddressRequest (shipTo.getAsAddress());
        System.debug(req.getBody());

        UpdateCustomerShippingAddressResponse resp = (UpdateCustomerShippingAddressResponse)client.send(req);
        System.debug(resp.success());
        
        return new PageReference('/apex/SavedShippingAddresses');
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