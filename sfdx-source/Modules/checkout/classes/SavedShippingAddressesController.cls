public with sharing class SavedShippingAddressesController {

    
    private static AuthorizeDotNetClient client;
    
    String customerProfileId;

    public Contact c {get; set;}
    
    public List<Address> shipToList {get; set;}
    
    public String selectedCustomerAddressId {get; set;}
    
    private static final Boolean mock = False;
    
    
    
    public SavedShippingAddressesController() {

           
            client = new AuthorizeDotNetClient();
        
        customerProfileId = CurrentCustomer.getCustomerProfileId();
        
        this.shipToList = mock ? sampleCustomerShipToList() : getShipToList(customerProfileId);
    }
    


    
    
    public PageReference editThisAddress() {
        //when the user clicks edit link
        //set the selectedCustomerAddressId
        
        string customerAddressId = Apexpages.currentPage().getParameters().get('customerAddressId');

        //able to set a parameter
        if(customerAddressId!=null){
            Pagereference editPage = new PageReference('/apex/EditShippingAddress');
            editPage.setRedirect(true);
            editPage.getParameters().put('customerAddressId', customerAddressId);
            system.debug(editPage.getParameters());
            return editPage;
        }
        else {
            return new PageReference('/apex/AddShippingAddress');

        }
    }

    public PageReference deleteThisAddress() {
        //delete directly
        DeleteCustomerShippingAddressRequest req = new DeleteCustomerShippingAddressRequest();
        req.setCustomerProfileId(customerProfileId);
        req.setCustomerAddressId(selectedCustomerAddressId);

        String result = req.getBody();

        System.debug(result);

        DeleteCustomerShippingAddressResponse resp = (DeleteCustomerShippingAddressResponse)client.send(req);
        
        if(resp.success()){
            System.debug('success is '+ resp.success());
            System.debug(selectedCustomerAddressId + ' has been deleted');
        }
        else{
            Messages messages = resp.getMessages();
            Message message = messages.getFirstMessage();
            System.debug(message.getText());
            return new PageReference('/apex/ShipToError');
        }
        
        return new Pagereference('/apex/SavedShippingAddresses');
    }

    public static List<Address> getShipToList(String customerProfileId) {
        
        GetCustomerProfileRequest req = new GetCustomerProfileRequest();
        req.setCustomerProfileId(customerProfileId);

        GetCustomerProfileResponse resp = (GetCustomerProfileResponse)client.send(req);
        CustomerProfile profile = resp.getProfile();
        List<Address> shipToList = profile.getShipToList();

        return shipToList;
    }

    
    public static List<Address> sampleCustomerShipToList() {
        List<Address> addressList = new List<Address>();
        Address shipTo1 = new Address('Ralph', 'Williams', '19645 Andrew Ln', 'Reno', 'NV', '89521');
        Address ShipTo2 = new Address('Sebastian', 'Williams-Wilson', '200 Mountain View Dr.', 'Reno', 'NV', '89511');
        shipTo2.setCompany('Dog Walks by Dogs');
        addressList.add(shipTo1);
        addressList.add(shipTo2);

        return addressList;
    }
    
    

    public PageReference redirectToAddShippingAddress() {
        return new PageReference('/apex/AddShippingAddress');
    }

    public PageReference redirectToEditShippingAddress() {
        return new PageReference('/apex/EditShippingAddress');
    }

    public PageReference redirectToDeleteShipToAddress() {
        return new PageReference('/apex/DeleteShipToAddress');
    }

    public PageReference redirectToSavedShippingAddresses() {
        return new Pagereference('/apex/SavedShippingAddresses');
    }

}