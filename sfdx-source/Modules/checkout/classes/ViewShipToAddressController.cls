public with sharing class ViewShipToAddressController {

    
    private static AuthorizeDotNetClient client;
    
    String customerProfileId;

    public Contact c {get; set;}
    
    public List<Address> shipToList {get; set;}
    
    public String selectedCustomerAddressId {get; set;}
    
    private static final Boolean mock = False;
    
    
    
    public ViewShipToAddressController() {

           
            client = new AuthorizeDotNetClient();
        
        customerProfileId = CurrentCustomer.getCustomerProfileId();
        
        this.shipToList = mock ? sampleCustomerShipToList() : getShipToList(customerProfileId);
    }
    


    
    
    public PageReference editThisAddress() {
        //when the user clicks edit link
        //set the selectedCustomerAddressId
        

        //able to set a parameter
        if(selectedCustomerAddressId!=null){
            Pagereference editPage = new PageReference('/apex/EditShipToAddress');
            editPage.setRedirect(true);
            editPage.getParameters().put('customerAddressId', selectedCustomerAddressId);
            system.debug(editPage.getParameters());
            return editPage;
        }
        else {
            return new PageReference('/apex/AddShipToAddress');

        }

        //when I test this the url is 
        //https://ocdla--marastore--c.sandbox.vf.force.com/apex/EditShipToAddress?addressId=temp123
    }

    public PageReference deleteThisAddress() {
        //when the user clicks edit link
        //set the selectedCustomerAddressId
        

        //able to set a parameter
        if(selectedCustomerAddressId!=null){
            Pagereference deletePage = new PageReference('/apex/DeleteShipToAddress');
            deletePage.setRedirect(true);
            deletePage.getParameters().put('customerAddressId', selectedCustomerAddressId);
            system.debug(deletePage.getParameters());
            return deletePage;
        }
        else {
            return new PageReference('/apex/AddShipToAddress');

        }

        //when I test this the url is 
        //https://ocdla--marastore--c.sandbox.vf.force.com/apex/EditShipToAddress?addressId=temp123
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
    
    

    public PageReference redirectToAddShipToAddress() {
        return new PageReference('/apex/AddShipToAddress');
    }

    public PageReference redirectToEditShipToAddress() {
        return new PageReference('/apex/EditShipToAddress');
    }

    public PageReference redirectToDeleteShipToAddress() {
        return new PageReference('/apex/DeleteShipToAddress');
    }

    public PageReference redirectToViewShipToAddress() {
        return new Pagereference('/apex/ViewShipToAddress');
    }

}