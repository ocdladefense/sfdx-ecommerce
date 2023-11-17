





public with sharing class Scratch {
   
    

    public void deleteCustomerPaymentProfile() {

        
        // Create an instance of the request object.
        // Call the approppriate constructors,
        // and any appropriate methods.
        DeleteCustomerPaymentProfileRequest req = new DeleteCustomerPaymentProfileRequest();
        req.setCustomerProfileId('905372692');
        req.setCustomerPaymentProfileId('915360041');
        

       System.debug(req.getBody());

        // Instantiate the client.
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        AuthorizeDotNetResponse resp = client.send(req);

        System.assert(resp.success());
    }

    public void createCustomerShippingAddressFromBaseClass() {
        string CUSTOMER_PROFILE_ID = '905372692';

        Address billTo = new Address('Jose', 'Berna', '214 NW Monroe Ave', 'Corvallis', 'OR', '90000');
        AuthorizeDotNetRequest req = new AuthorizeDotNetRequest('createCustomerShippingAddress');
        req.put('customerProfileId', CUSTOMER_PROFILE_ID);
        req.put('address', billTo);
        req.put('defaultShippingAddress',true);


        String result = req.getBody();

        System.debug(result);

                // Instantiate the client.
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        AuthorizeDotNetResponse resp = client.send(req);

        System.debug(resp);

        Messages messages= resp.getMessages();
        Message message = messages.getFirstMessage();
        System.debug(message.getText());


    }

    public void createCustomerShippingAddress() {

        Address billTo = new Address('Jose', 'Berna', '214 NW Monroe Ave', 'Corvallis', 'OR', '97330');
        CreateCustomerShippingAddressRequest req = new CreateCustomerShippingAddressRequest(billTo);
        req.setCustomerProfileId(CUSTOMER_PROFILE_ID);
        req.setAddress(billTo);
        req.setDefaultShippingAddress(true);


        String result = req.getBody();

        System.debug(result);
    }

    public void getCustomerShippingAddressFromBaseClass() {

        AuthorizeDotNetRequest req = new AuthorizeDotNetRequest('getCustomerShippingAddress');
        req.put('customerProfileId', '1234');
        req.put('customerAddressId', '5678');

        String result = req.getBody();

        System.debug(result);
    }

    public void getCustomerShippingAddress() {

        GetCustomerShippingAddressRequest req = new GetCustomerShippingAddressRequest();
        req.setCustomerAddressId('5678');
        req.setCustomerProfileId('1234');

        String result = req.getBody();

        System.debug(result);
    }

    public void updateCustomerShippingAddressFromBaseClass() {

        AuthorizeDotNetRequest req = new AuthorizeDotNetRequest('updateCustomerShippingAddress');
        req.put('customerProfileId', '1234');
        Address newAddress = new Address('J.', 'Berna', '214 NW Monroe Ave', 'Albany', 'OR', '97330');
        newAddress.setCompany('OCDLA');
        //in order for request
        req.put('customerProfileId', '1234');
        req.put('address', newAddress);
        req.put('defaultShippingAddress', false);
       
        String result = req.getBody();

        System.debug(result);
    }

    public void updateCustomerShippingAddress() {

        UpdateCustomerShippingAddressRequest req = new UpdateCustomerPaymentProfileRequest();
        req.setCustomerProfileId('1234');
        Address newAddress = new Address('J.', 'Berna', '214 NW Monroe Ave', 'Albany', 'OR', '97330');
        newAddress.setCompany('OCDLA');
        //in order for request
        req.setAddress(newAddress);

       
        String result = req.getBody();

        System.debug(result);
    }






    public Scratch() {



        String getRequestString = '{"getCustomerProfileRequest": {"merchantAuthentication": {"name": "6gSVxaYj397","transactionKey": "6FR49pDH5Jjum58g"},"customerProfileId": "905372692","includeIssuerInfo": "true"}}';

        String fromDoc = '{ "authenticateTestRequest": { "merchantAuthentication": {"name": "6gSVxaYj397", "transactionKey": "6FR49pDH5Jjum58g" }}}';

        Http client4 = new Http();
        //HttpRequestMessage req4 = new HttpRequestMessage();
        HttpRequest req4 = new HttpRequest();

        req4.setEndpoint('https://apitest.authorize.net/xml/v1/request.api');
        req4.setMethod('POST');
        req4.setHeader('Content-Type', 'application/json');
        req4.setBody(getRequestString);

        HttpResponse resp4 = client4.send(req4);
        //AuthorizeDotNetRespone resp4 = (AuthorizeDotNetRespone)client4.send(req4);

        system.debug(resp4);

        //should be done in client
        String respBodyString = resp4.getBody().replace('\uFEFF', '');
        //String respBodyString = resp4.getBody();
        //System.debug('is alphanumeric '+ respBody4.isAlphanumeric());
        GetC authResp = new AuthorizeDotNetResponse(respBodyString);
        authResp.deserialize();
        System.debug(authResp);
        System.debug('get text is '+ authResp.getText());


        //    if(!this.body.isAlphanumeric()){
        //    this.body = this.body.replace('\uFEFF', '');
        //    System.debug('entered if');
        // }

    }


    /*


The documentation for {!list} is for the VisualForce Standard List Controller. This controller is available to the page if recordSetVars is included as an attribute on the apex:page

list : Returns a PageReference object of the standard list page, based on the most recently used list filter for that object when the filterId is not specified by the user.

Other standard actions you can use on list controllers are:
    */
public PageReference returnToListView() { 
    return new ApexPages.Action('{!List}').invoke();
}

    public PageReference doSomething() {




        String lista = '{!list}';
        String cancel = '{!cancel}';
        String first = '{!first}';
        String last = '{!last}';
        String next = '{!next}';
        String previous = '{!previous}';
        String quicksave = '{!quicksave}';
        String save = '{!save}';


    }
}