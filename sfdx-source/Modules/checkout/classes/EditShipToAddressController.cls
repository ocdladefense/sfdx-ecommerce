public with sharing class EditShipToAddressController {
    AuthorizeDotNetClient client {get; set;}
    String customerProfileId {get; set;}

    public Contact c {get; set;}
    public Address updatedShipTo {get; set;}
    public String selectedCustomerAddressId {get; set;}
    public String tempId {get; set;}
    
    public EditShipToAddressController() {
        Map <String, String> interns = new Map<String,String> {
            'johnDoeAuthDotNetId' =>'905372692',
            'maraAuthDotNetId' => '916376196',
            'maraSandBoxSfContactId' => '0037h00000uAHSHAA4'
        };

        String contactForTesting = interns.get('maraSandBoxSfContactId');

        client = new AuthorizeDotNetClient();

        c = [SELECT FirstName, LastName, Email, AuthorizeDotNetCustomerProfileId__c FROM Contact WHERE Id = :contactForTesting];

        customerProfileId = c.AuthorizeDotNetCustomerProfileId__c;
        updatedShipTo = new Address('Maglor', 'Feanorian', '214 Andrew Lane', 'Maglors-Gap', 'NV', '89521');
        updatedShipTo.setCustomerAddressId('916521213');
        tempId = getSelectedAddressIdFromUrl();
        
    }
    public String getSelectedShipToFromUrl() {
        String temp = ApexPages.currentPage().getParameters().get('addressId');
        return temp!=null? temp : 'not found';
        
    }
   

    public PageReference editShipTo(){
        UpdateCustomerShippingAddressRequest req = new UpdateCustomerShippingAddressRequest(updatedShipTo);
        req.setCustomerProfileId(this.customerProfileId);
        req.setDefaultShippingAddress(false);
        
        System.debug(req.getBody());
        UpdateCustomerShippingAddressResponse resp = (UpdateCustomerShippingAddressResponse)client.send(req);

        if(resp.success()){
            System.debug('success is ' + resp.success());
            return redirectToViewShipToAddress();
        }
        else{
            Messages messages = resp.getMessages();
            Message message = messages.getFirstMessage();
            System.debug(message.getText());
            return new PageReference('/apex/ShipToError');
        }

    }
    public Address sampleShipToAddress(){
        Address shipToSample = new Address('Sebastian', 'Williams-Wilson', '200 Mountain View Dr.', 'Reno', 'NV', '89511');
        return shipToSample;
    }

    public PageReference redirectToViewShipToAddress() {
        return new Pagereference('/apex/ViewShipToAddress');
    }

    public string getSelectedAddressIdFromUrl() {
        return ApexPages.currentPage().getParameters().get('customerAddressid'); 
    } 
}