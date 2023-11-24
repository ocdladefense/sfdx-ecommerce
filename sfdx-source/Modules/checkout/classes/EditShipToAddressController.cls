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
       
        selectedCustomerAddressId = getSelectedAddressIdFromUrl();

        updatedShipTo=loadShipToCurrentId();
        //updatedShipTo.setCustomerAddressId(selectedCustomerAddressId);

        
    }
    public String getSelectedShipToFromUrl() {
        String temp = ApexPages.currentPage().getParameters().get('addressId');
        return temp!=null? temp : 'not found';
        
    }

    public Address loadShipToCurrentId(){
        GetCustomerShippingAddressRequest req = new GetCustomerShippingAddressRequest();
        req.setCustomerAddressId(selectedCustomerAddressId);
        req.setCustomerProfileId(customerProfileId);
        System.debug(req.getBody());
        GetCustomerShippingAddressResponse resp = (GetCustomerShippingAddressResponse)client.send(req);
        
        if(resp.success()){
            System.debug('success is ' + resp.success());
            return resp.getAddress();
        }
        else{
            Messages messages = resp.getMessages();
            Message message = messages.getFirstMessage();
            System.debug(message.getText());
            return null;
        }
    }
   

    public PageReference editShipTo(){

        // Address shipToSubmit = updatedShipTo;
   
        UpdateCustomerShippingAddressRequest req = new UpdateCustomerShippingAddressRequest();
        // System.debug(req.getBody());
        //System.debug(updatedShipTo);
        
        req.setCustomerProfileId(customerProfileId);

        //System.debug(req.getBody());

        req.setAddress(updatedShipTo);
        System.debug(req.getBody());
        System.debug('XXXX- address id');
        System.debug(updatedShipTo.getCustomerAddressId());
        System.debug('XXXX - address keySet...');
        System.debug(updatedShipTo.keySet());
        System.debug('XXXX - Update request keys...');
        System.debug(req.keySet());
        System.debug('XXXX - req body...');
        System.debug(req.getBody());
        //req.setDefaultShippingAddress(false);
        
        UpdateCustomerShippingAddressResponse resp = (UpdateCustomerShippingAddressResponse)client.send(req);

        if(resp.success()){
            System.debug('success is ' + resp.success());
            return redirectToViewShipToAddress();
        }
        else{
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

    public PageReference redirectToViewShipToAddress() {
        return new Pagereference('/apex/ViewShipToAddress');
    }

    public string getSelectedAddressIdFromUrl() {
        return ApexPages.currentPage().getParameters().get('customerAddressid'); 
    } 
}