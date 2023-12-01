public with sharing class SavedShippingAddressesController {

    AuthorizeDotNetClient client {get; set;}


    String customerProfileId;

    public Contact c {get; set;}
    
    public List<Address> shipToList {get; set;}

    public AddressCollection shipToCollection {get; set;}
    
    public String customerAddressId {get; set;}
    
    private static final Boolean mock = False;
    
    
    
    public SavedShippingAddressesController() {
           
        this.client = new AuthorizeDotNetClient();
     

        customerProfileId = CurrentCustomer.getCustomerProfileId();

        this.shipToCollection = getShipToCollection(customerProfileId);

        if(this.shipToCollection==null){
            this.shipToCollection= new AddressCollection();
            system.debug('no list');
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Address list is ' + this.shipToCollection.getAsList().size()));
            this.shipToList =new List<Address>();
        }
        else{
            this.shipToList = mock ? sampleCustomerShipToList() : this.shipToCollection.getAsList();
        }
        

    }
    
    
    public PageReference editThisAddress() {
        //when the user clicks edit link
        //set the customerAddressId
        
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

    public AddressCollection getShipToCollection(String customerProfileId) {
        
        GetCustomerProfileRequest req = new GetCustomerProfileRequest();
        req.setCustomerProfileId(customerProfileId);
        //AuthorizeDotNetClient tempClient = new AuthorizeDotNetClient();
        Boolean isClientNull = client==null;
        if(isClientNull){
            throw new CheckoutException('AuthorizeDotNetClient must not be null');
        }
        GetCustomerProfileResponse resp = (GetCustomerProfileResponse) this.client.send(req);
        CustomerProfile profile = resp.getProfile();
        if(profile.getShipToList()==null){
            // ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'No saved addresses found. Please add an address.'));
            // return new Pagereference('/apex/AddShippingAddress');
            return null;

        }
        AddressCollection collection = new AddressCollection(profile.getShipToList());

        return collection;
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
    
    public Boolean setDefaultShipToAddress(){
        return null;
    }
    public Boolean isDefaultShippingAddress() {
        string customerAddressId = Apexpages.currentPage().getParameters().get('customerAddressId');

        String defaultAddressId = shipToCollection.getDefault().getCustomerAddressId();
        return defaultAddressId == customerAddressId? true : false;
    }
  
    public PageReference redirectToAddShippingAddress() {
        return new PageReference('/apex/AddShippingAddress');
    }

    public PageReference redirectToEditShippingAddress() {
        return new PageReference('/apex/EditShippingAddress');
    }


    public PageReference redirectToSavedShippingAddresses() {
        return new Pagereference('/apex/SavedShippingAddresses');
    }

}