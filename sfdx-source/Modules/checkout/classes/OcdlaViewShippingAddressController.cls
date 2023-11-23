public with sharing class OcdlaViewShippingAddressController {
    
    AuthorizeDotNetClient client;
    String customerProfileId;
    //String maraContactId = '0037h00000uAHSHAA4';

    public Contact c {get; set;}
    public List<Address> shipToList {get; set;}
    public String selectedCustomerAddressId {get; set;}
    
    public OcdlaViewShippingAddressController() {

        client = new AuthorizeDotNetClient();
        c = [SELECT FirstName, LastName, Email, AuthorizeDotNetCustomerProfileId__c FROM Contact WHERE Id = '0037h00000uAHSHAA4'];
        //customerProfileId = c.AuthorizeDotNetCustomerProfileId__c;
        
        String default_custProfileId = '905372692';
        customerProfileId=default_custProfileId;
        shipToList = new List<Address>();
        loadShipToList(false);
    }
    public List<Address> getShipToList() {
        
        GetCustomerProfileRequest req = new GetCustomerProfileRequest();
        req.setCustomerProfileId(customerProfileId);

        GetCustomerProfileResponse resp = (GetCustomerProfileResponse)client.send(req);
        CustomerProfile profile = resp.getProfile();
        List<Address> shipToList = profile.getShipToList();

        return shipToList;
    }

    public List<Address> sampleCustomerShipToList(){
        List<Address> addressList = new List<Address>();
        Address shipTo1 = new Address('Ralph', 'Williams', '19645 Andrew Ln', 'Reno', 'NV', '89521');
        Address ShipTo2 = new Address('Sebastian', 'Williams-Wilson', '200 Mountain View Dr.', 'Reno', 'NV', '89511');
        shipTo2.setCompany('Dog Walks by Dogs');
        addressList.add(shipTo1);
        addressList.add(shipTo2);

        return addressList;
    }

    public void loadShipToList(Boolean mock) {
       
        // For testing
        if(mock) {
            this.shipToList = sampleCustomerShipToList();
        }
        else {
            this.shipToList = getShipToList();
        }
        
        //paymentProfiles = sampleEmptyCustomerPaymentProfileList();
    }

    public PageReference redirectToAddShipToAddress() {
        return new PageReference('/apex/OcdlaAddShipToAddress');
    }

    // public PageReference redirectToEditShipToAddress() {
    //     return new PageReference('/apex/OcdlaEditShipToAddress');
    // }

    public PageReference redirectToSavedPaymentMethods() {
        return new Pagereference('/apex/OcdlaViewShippingAddress');
    }

}