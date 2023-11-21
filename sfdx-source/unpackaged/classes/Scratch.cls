
public with sharing class Scratch {



    public void createCustomerShippingAddressFromBaseClass() {

        Address billTo = new Address('Jose', 'Berna', '214 NW Monroe Ave', 'Corvallis', 'OR', '97330');
        AuthorizeDotNetRequest req = new AuthorizeDotNetRequest('createCustomerShippingAddress');
        req.put('customerProfileId', '1234');
        req.put('address', billTo);
        req.put('defaultShippingAddress',true);


        String result = req.getBody();

        System.debug(result);
    }





    public void createCustomerShippingAddress() {
        String default_custProfileId = '905372692';
        Address billTo = new Address('Ralph', 'Williams', '214 Andrew Lane', 'Reno', 'NV', '89521');
        CreateCustomerShippingAddressRequest req = new CreateCustomerShippingAddressRequest(billTo);
        req.setCustomerProfileId('905372692');
        req.setAddress(billTo);
        req.setDefaultShippingAddress(false);

        String result = req.getBody();

        System.debug(result);

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();
        CreateCustomerShippingAddressResponse resp = (CreateCustomerShippingAddressResponse)client.send(req);

        System.debug('success is '+ resp.success());
        System.debug('addressId from response is ' + resp.getCustomerAddressId());
        System.debug(resp);

        //for next call 916168863
    }


public void updateCustomerShippingAddress() {
        String default_custProfileId = '905372692';
        String customerAddressId = '916168863';
        Address newAddress = new Address('Ralph', 'Williams', '19645 Andrew Lne', 'Reno', 'NV', '89521');
        newAddress.setPhoneNumber('541-555-5555');
        newAddress.setCompany('Good Dog Business');
        newAddress.setCustomerAddressId(customerAddressId);
        
        updateCustomerShippingAddressRequest req = new updateCustomerShippingAddressRequest(newAddress);
        req.setCustomerProfileId('905372692');
        req.setAddress(newAddress);
        req.setDefaultShippingAddress(false);

        String result = req.getBody();

        System.debug(result);

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();
        UpdateCustomerShippingAddressResponse resp = (UpdateCustomerShippingAddressResponse)client.send(req);

        System.debug('success is '+ resp.success());
        System.debug(resp);

        //for next call 916168863
    }
    public void updateCustomerShippingAddressWithNoChanges() {
        String default_custProfileId = '905372692';
        String customerAddressId = '916168863';
        Address newAddress = new Address('Ralph', 'Williams', '19645 Andrew Lne', 'Reno', 'NV', '89521');
        newAddress.setPhoneNumber('541-555-5555');
        newAddress.setCompany('Good Dog Dog Business');
        newAddress.setCustomerAddressId(customerAddressId);
        
        updateCustomerShippingAddressRequest req = new updateCustomerShippingAddressRequest(newAddress);
        req.setCustomerProfileId('905372692');
        req.setAddress(newAddress);
        req.setDefaultShippingAddress(false);

        String result = req.getBody();

        System.debug(result);

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();
        UpdateCustomerShippingAddressResponse resp = (UpdateCustomerShippingAddressResponse)client.send(req);

        System.debug('success is '+ resp.success());
        System.debug(resp);

        //does not produce error - sends back success
    }

    public void getCustomerShippingAddress() {
        String default_custProfileId = '905372692';
        String customerAddressId = '916168863';
       
        GetCustomerShippingAddressRequest req = new GetCustomerShippingAddressRequest();
        req.setCustomerProfileId('905372692');
        req.setCustomerAddressId(customerAddressId);

        String result = req.getBody();

        System.debug(result);

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();
        GetCustomerShippingAddressResponse resp = (GetCustomerShippingAddressResponse)client.send(req);

        System.debug('success is '+ resp.success());
        Address theAddress = resp.getAddress();
        List<String> subscriptionIds = resp.getSubscriptionIds();
        System.debug('subscriptions is null? ' + subscriptionIds==null);
        System.debug(theAddress.getCompany());
        System.debug(resp);


        //does not produce error - sends back success
    }

    public void deleteCustomerShippingAddress() {
        String default_custProfileId = '905372692';
        String customerAddressId = '916168863';
       
        DeleteCustomerShippingAddressRequest req = new DeleteCustomerShippingAddressRequest();
        req.setCustomerProfileId(default_custProfileId);
        req.setCustomerAddressId(customerAddressId);

        String result = req.getBody();

        System.debug(result);

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();
        DeleteCustomerShippingAddressResponse resp = (DeleteCustomerShippingAddressResponse)client.send(req);

        System.debug('success is '+ resp.success());
        
        System.debug(resp);

        //try to get the deleted address by id
        GetCustomerShippingAddressRequest req = new GetCustomerShippingAddressRequest();
        req.setCustomerProfileId('905372692');
        req.setCustomerAddressId('916168863');
        //AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        GetCustomerShippingAddressResponse getResp = (GetCustomerShippingAddressResponse)client.send(req);

        System.debug('success is '+ getResp.success());
        Messages messages = getResp.getMessages();
        Message message = messages.getFirstMessage();
        String text = message.getText();
        System.debug(text);
        System.assertEquals(false, getResp.success(), 'the get request should come back as an error because there is no matching address id');



        //does not produce error - sends back success
    }


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


    public void getCustomerProfile(){
        GetCustomerProfileRequest req = new GetCustomerProfileRequest();
        req.setCustomerProfileId('905372692');
        System.debug(req.getBody());

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        GetCustomerProfileResponse resp = (GetCustomerProfileResponse)client.send(req);
        resp.deserialize();
        CustomerProfile profile = resp.getProfile();
        List<Address> shipToList = profile.getShipToList();
        system.debug('number of shipping addresses is ' + shipToList.size());
        //system.debug(profile);

    }


    public void createCustomerPaymentProfile() {

        Address billTo = new Address('Sebastian', 'Berna', '214 NW Monroe Ave', 'Corvallis', 'OR', '97330');

        CreditCard card = new CreditCard('4111111111111122','11/2024');

        CustomerPaymentProfile paymentProfile = new CustomerPaymentProfile(card,billTo);
        // Create an instance of the request object.
        // Call the approppriate constructors,
        // and any appropriate methods.
        CreateCustomerPaymentProfileRequest req = new CreateCustomerPaymentProfileRequest(paymentProfile);
        req.setCustomerProfileId('905372692');
        System.debug(req.getBody());

        // Instantiate the client.
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        CreateCustomerPaymentProfileResponse resp = (CreateCustomerPaymentProfileResponse)client.send(req);

        System.debug(resp.getBody());
        System.debug(resp.getCustomerProfileId());
        System.debug(resp.getCustomerPaymentProfileId());

        System.assert(resp.success());
    }





    //call to AuthorizeDotNet getCustomerProfileRequest to retrieve full profile with list of saved payment profiles
    public static List<CustomerPaymentProfile> getPaymentProfileList(String customerProfileId){
        
        List<CustomerPaymentProfile> profiles = new List<CustomerPaymentProfile>();
        
        //set up a client
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

    
        //make the request message
        GetCustomerProfileRequest req = new GetCustomerProfileRequest(customerProfileId);
      
        //send the request and receive the response
        HttpResponseMessage resp = client.send(req);

        //get the message from the response and parse
        String respBody = resp.getBody();
       
        Map<String, Object> body = (Map<String, Object>)JSON.deserializeUntyped(respBody);

        //key is profile
        Map<String, Object> soapProfile = (Map<String, Object>)body.get('profile');

        //get list of payment profiles
        List<Object> paymentProfiles = (List<Object>)soapProfile.get('paymentProfiles');
        
        //for each profile in the list, make a new profile object with billto and payment
        //ignore "originalNetworkTransId" and 'originalAuthAmount'

        for (Object p : paymentProfiles) {
            //first hold paymentprofile id in variable
            Map<String, Object> paymentProfile = (Map<String, Object>)p;
            String customerPaymentProfileId = (String)paymentProfile.get('customerPaymentProfileId');

            //next make new address and set the fields
            Map<String, Object> billTo = (Map<String, Object>)paymentProfile.get('billTo');
            Address theAddress = CustomerPaymentProfile.newAddressFromMap(billTo);
            //next deserialize payment into a map string object
            Map<String, Object> payment = (Map<String, Object>)paymentProfile.get('payment');
            CreditCard theCard=CustomerPaymentProfile.newCardFromPaymentMap(payment);

            //make new customerpayment profile
            CustomerPaymentProfile profile = new CustomerPaymentProfile(theCard,theAddress);
            //add to list of profiles
            profiles.add(profile);
        }
        

        //use AuthorizeDotNetResponse to parse messages
 
        //deserialize 
        //AuthorizeDotNetResponse message = new AuthorizeDotNetResponse(body);
        
                                                            

      return profiles; 
    }

    /*   
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