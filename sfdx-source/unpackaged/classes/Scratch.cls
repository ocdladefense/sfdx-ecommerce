
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
        Message message = messages.getMessage();
        System.debug(message.getText());


    }

    public void createCustomerShippingAddress() {

        Address billTo = new Address('Jose', 'Berna', '214 NW Monroe Ave', 'Corvallis', 'OR', '97330');
        CreateCustomerShippingAddressRequest req = new CreateCustomerShippingAddressRequest(billTo);
        req.setCustomerProfileId('1223');
        req.setAddress(billTo);
        req.setDefaultShippingAddress(true);


        String result = req.getBody();

        System.debug(result);

        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        AuthorizeDotNetResponse resp = client.send(req);

        System.debug(resp);

        Messages messages= resp.getMessages();
        Message message = messages.getMessage();
        System.debug(message.getText());
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



    public void createCustomerPaymentProfile() {

        Address billTo = new Address('Jose', 'Berna', '214 NW Monroe Ave', 'Corvallis', 'OR', '97330');

        CreditCard card = new CreditCard('4111111111111111','11/2024');

        CustomerPaymentProfile paymentProfile = new CustomerPaymentProfile(card,billTo);
        // Create an instance of the request object.
        // Call the approppriate constructors,
        // and any appropriate methods.
        CreateCustomerPaymentProfileRequest req = new CreateCustomerPaymentProfileRequest(paymentProfile);
        req.setCustomerProfileId('905372692');
        

       System.debug(req.getBody());

        // Instantiate the client.
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        AuthorizeDotNetResponse resp = client.send(req);

        System.debug(resp.getBody());
        System.assert(resp.success());
    }


    public createCustomerPaymentProfileRequest() {


        
        Address billTo = new Address('Jose', 'Berna', '214 NW Monroe Ave', 'Corvallis', 'OR', '97330');
        CreditCard card = new CreditCard('4111111111111111', '10/2014');

        CustomerPaymentProfile profile = new CustomerPaymentProfile(card, billTo);

        CreateCustomerPaymentProfileRequest req = new CreateCustomerPaymentProfileRequest(profile);

        String result = req.getBody();

        System.debug(result);
    }


public String deleteCustomerPaymentProfile(String customerProfileId){
        //set up a client
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

    
        //make the request message
        DeleteCustomerPaymentProfileRequest req = new DeleteCustomerPaymentProfileRequest(this, customerProfileId);
      
        //send the request and receive the response
        HttpResponseMessage resp = client.send(req);

        //get the message from the response and parse
        String body = resp.getBody();

        AuthorizeDotNetResponse message = new AuthorizeDotNetResponse(body);
       
        //send resultCode
        return message.getResultCode();
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

    public Scratch() {
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