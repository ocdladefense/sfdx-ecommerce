public with sharing class SavedShippingAddressesController {

    AuthorizeDotNetClient client {get; set;}


    String customerProfileId;

    public Contact c {get; set;}
    
    public List<AuthNetAddress> shipToList {get; set;}

    public AuthNetAddressCollection shipToCollection {get; set;}
    
    public String customerAddressId {get; set;}

    public String defaultShippingAddressId {get; set;}
    
    private static final Boolean mock = False;
    
    
    
    public SavedShippingAddressesController() {
           
        this.client = new AuthorizeDotNetClient();
     

        customerProfileId = CurrentCustomer.getCustomerProfileId();

        this.shipToCollection = getShipToCollection(customerProfileId);

        if(this.shipToCollection==null){
            this.shipToCollection= new AuthNetAddressCollection();
            system.debug('no list');
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Address list is ' + this.shipToCollection.getAsList().size()));
            this.shipToList =new List<AuthNetAddress>();
        }
        else{
            this.shipToList = mock ? sampleCustomerShipToList() : this.shipToCollection.getAsList();
        }
        

    }
    public PageReference setShippingMethod(){
        Map<String,String> params = ApexPages.currentPage().getParameters();
        String action = params.get('action');
        String customerAddressId = params.get('customerAddressId');
        System.debug(customerAddressId);

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

    public AuthNetAddressCollection getShipToCollection(String customerProfileId) {
        
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
        AuthNetAddressCollection collection = new AuthNetAddressCollection(profile.getShipToList());

        return collection;
    }
    public static List<AuthNetAddress> sampleCustomerShipToList() {
        List<AuthNetAddress> addressList = new List<AuthNetAddress>();
        AuthNetAddress shipTo1 = new AuthNetAddress('Ralph', 'Williams', '19645 Andrew Ln', 'Reno', 'NV', '89521');
        AuthNetAddress ShipTo2 = new AuthNetAddress('Sebastian', 'Williams-Wilson', '200 Mountain View Dr.', 'Reno', 'NV', '89511');
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
    
    public string getDefaultShippingAddressId(){

        String defaultShippingAddressId;

        for (AuthNetAddress address : shipToList)
        {
            GetCustomerShippingAddressRequest req = new GetCustomerShippingAddressRequest();
        
            req.setCustomerAddressId(address.getCustomerAddressId());
            req.setCustomerProfileId(customerProfileId);
    
            Boolean isClientNull = client==null;
            if(isClientNull){
                throw new CheckoutException('AuthorizeDotNetClient must not be null');
            }
            
            GetCustomerShippingAddressResponse resp = (GetCustomerShippingAddressResponse)client.send(req);

            if(resp.success() && resp.getDefaultShippingAddress()){
                defaultShippingAddressId = address.getCustomerAddressId();
                break;
            }
        }
        //not found
        return defaultShippingAddressId;
    }
    public PageReference redirectToAddShippingAddress() {
        return new PageReference('/apex/AddShippingAddress');
    }

    public PageReference redirectToShippingMethod() {
        return new PageReference('/apex/ShippingMethod');
    }

    public PageReference redirectToEditShippingAddress() {
        return new PageReference('/apex/EditShippingAddress');
    }


    public PageReference redirectToSavedShippingAddresses() {
        return new Pagereference('/apex/SavedShippingAddresses');
    }

}