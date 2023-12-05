public with sharing class AddShippingAddressController {
   
    AuthorizeDotNetClient client {get; set;}
    String customerProfileId {get; set;}

    public Contact c {get; set;}
    public AuthNetAddress shipTo {get; set;}
    //public List<Address> shipToList {get; set;}
    //public String selectedCustomerAddressId {get; set;}
    public List<SelectOption> stateOptions {get; public set;}
    
    public AddShippingAddressController() {
        this.client = new AuthorizeDotNetClient();

        customerProfileId = CurrentCustomer.getCustomerProfileId();
    
        shipTo = new AuthNetAddress();

        this.stateOptions = getStateOptions();
       
    }

    // public List<Address> getShipToList() {
        
    //     GetCustomerProfileRequest req = new GetCustomerProfileRequest();
    //     req.setCustomerProfileId(customerProfileId);
    //     Boolean isClientNull = client==null;
    //     if(isClientNull){
    //         throw new CheckoutException('AuthorizeDotNetClient must not be null');
    //     }
    //     GetCustomerProfileResponse resp = (GetCustomerProfileResponse)client.send(req);
    //     CustomerProfile profile = resp.getProfile();
    //     List<Address> shipToList = profile.getShipToList();

    //     return shipToList;
    // }

    // public List<Address> sampleCustomerShipToList(){
    //     List<Address> addressList = new List<Address>();
    //     Address shipTo1 = new Address('Ralph', 'Williams', '19645 Andrew Ln', 'Reno', 'NV', '89521');
    //     Address ShipTo2 = new Address('Sebastian', 'Williams-Wilson', '200 Mountain View Dr.', 'Reno', 'NV', '89511');
    //     shipTo2.setCompany('Dog Walks by Dogs');
    //     addressList.add(shipTo1);
    //     addressList.add(shipTo2);

    //     return addressList;
    // }

    // public void loadShipToList(Boolean mock) {
       
    //     // For testing
    //     if(mock) {
    //         this.shipToList = sampleCustomerShipToList();
    //     }
    //     else {
    //         this.shipToList = getShipToList();
    //     }
        
    //     //paymentProfiles = sampleEmptyCustomerPaymentProfileList();
    // }

    public Pagereference addShipTo(){

        //add avalidation
        AuthNetAddress newShipTo = shipTo;
        if(newShipTo.getLastName()!=null){
            System.debug('name is not null');
        }

        CreateCustomerShippingAddressRequest req = new CreateCustomerShippingAddressRequest(newShipTo);
        req.setCustomerProfileId(this.customerProfileId);
        req.setAddress(newShipTo);
        req.setDefaultShippingAddress(false);

        Boolean isClientNull = client==null;
        if(isClientNull){
            throw new CheckoutException('AuthorizeDotNetClient must not be null');
        }

        CreateCustomerShippingAddressResponse resp = (CreateCustomerShippingAddressResponse)client.send(req);

        if(resp.success()){
            system.debug('new address id is ' + resp.getCustomerAddressId());
            return redirectToSavedShippingAddresses();
        }
        else{
            Messages messages = resp.getMessages();
            Message message = messages.getFirstMessage();
            String messageText = message.getText();
            
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,messageText));
            return null;
        //display error message on page and refresh page
        //return new PageReference('/apex/ShipToError');

        }
    }

    public Map<string,object> GetFormData(){
        Map<string,object> theMap = ApexPages.currentPage().getParameters();
        System.debug(theMap);
        System.debug(shipTo);
        return theMap;
    }

    public PageReference redirectToAddShippingAddress() {
        return new PageReference('/apex/AddShippingAddress');
    }


    public PageReference redirectToSavedShippingAddresses() {
        return new Pagereference('/apex/SavedShippingAddresses');
    }

    public List<SelectOption> getStateOptions() {
        List<SelectOption> stateOptions = States.getAsSelectOptions();

        return stateOptions;
    }



}