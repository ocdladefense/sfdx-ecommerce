public with sharing class DeleteShipToAddressController {
    AuthorizeDotNetClient client {get; set;}

    String customerProfileId {get; set;}

    public Contact c {get; set;}

    public String selectedCustomerAddressId {get; set;}

    public Address selectedShipTo {get; set;}

    public DeleteShipToAddressController() {
        Map <String, String> interns = new Map<String,String> {
            'johnDoeAuthDotNetId' =>'905372692',
            'maraAuthDotNetId' => '916376196',
            'maraSfContactId' => '0037h00000uAHSHAA4'
        };
        String contactForTesting = interns.get('maraSfContactId');
        client = new AuthorizeDotNetClient();

        c = [SELECT FirstName, LastName, Email, AuthorizeDotNetCustomerProfileId__c FROM Contact WHERE Id = :contactForTesting];

        customerProfileId = c.AuthorizeDotNetCustomerProfileId__c;

        selectedCustomerAddressId = '916521213';

        loadAddressToDelete();

    }

    public PageReference deleteShipTo() {
       
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
        
        return new Pagereference('/apex/ViewShipToAddress');
    }

    public void loadAddressToDelete(){
        
        GetCustomerShippingAddressRequest req = new GetCustomerShippingAddressRequest();
        req.setCustomerProfileId(customerProfileId);
        req.setCustomerAddressId(selectedCustomerAddressId);

        GetCustomerShippingAddressResponse resp = (GetCustomerShippingAddressResponse)client.send(req);

        if (resp.success()){
            System.debug('retreived address # '+ selectedCustomerAddressId);
            selectedShipTo =resp.getAddress();
        }

    }

    public PageReference redirectToViewShipToAddress() {
        return new Pagereference('/apex/ViewShipToAddress');
    }
}