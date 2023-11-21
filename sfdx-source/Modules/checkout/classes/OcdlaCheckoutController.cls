global without sharing class OcdlaCheckoutController extends CommunityController {
	
    public static Id GUEST_CHECKOUT_ACCOUNT_ID;

    Opportunity opp {get; private set;}
    
    Order order {get; private set;}

    public Contact customer {get; public set;}
    
    public Boolean isSandbox {get; private set;}
    
    public Boolean isLoggedIn {get; private set;}
    
    public String shoppingCartSummary {get;private set;}
    
    public String cartId {get; public set;}
    
    public Boolean isFreeCart {get;private set;}
    
    public Boolean hasShippableProducts {get {return hasShippableProducts(this.cartId);}private set;}
    
    public Boolean renderPayment {get;private set;}

    public Boolean isPaid {get;private set;} 
    
    public Map<String, String> billingData {get;public set;}
    
    public Map<String, String> shippingData {get;public set;}
    //customer inputs this NOT saved creditcard data
    public Map<String, String> ccData {get;public set;}
    //will be list of saved credit cards
    //this doesn't use the credit card class YET
    //TO DO should be List <CreditCard>
    public List <Map<string, string>> creditCards {get;public set;}
    
    public Map<String, String> defaultCard {get;public set;}
    
    public List <SelectOption> cardOptions {get;public set;}

    public List<SelectOption> stateOptions {get; public set;}
    
    public string paymentProfileId {get;public set;}
        
    // Deprecate this field
    public String firstName {public get;private set;}
    // Deprecate this field
    public String lastName {public get;private set;}
    // Deprecate this field
    public String mailingStreet {public get;private set;}
    // Deprecate this field
    public String mailingCity {public get;private set;}
    // Deprecate this field
    public String mailingPostalCode {public get;private set;}
    // Deprecate this field
    public String ccNum {public get;private set;}
    // Deprecate this field
    public String ccExp {public get;private set;}
    // Deprecate this field
    public String ccCode {public get;private set;}
    
    public Boolean getRenderPayment(){
        return this.renderPayment;
    }
    
    

    public Boolean getIsPaid(){
        return this.IsPaid;
    }

    private static Boolean hasShippableProducts(Id cartId){
        List<OpportunityLineItem> lines = [SELECT Id, Product2.IsShippable__c FROM OpportunityLineItem WHERE OpportunityId = :cartId];
        
        for(OpportunityLineItem line :lines){
            if(line.Product2.IsShippable__c) return True;
        }
        
        return False;
    }

    private static Id getGuestCheckoutAccountId(){
        if(null != GUEST_CHECKOUT_ACCOUNT_ID) return GUEST_CHECKOUT_ACCOUNT_ID;
        Account a = [SELECT Id, Name FROM Account WHERE NAME LIKE '%Guest Checkout%' LIMIT 1];
        GUEST_CHECKOUT_ACCOUNT_ID = a.Id;
        return GUEST_CHECKOUT_ACCOUNT_ID;
    }

    private static Boolean isSandbox(){
        Organization myOrg = [SELECT Id, IsSandbox FROM Organization WHERE Id = :UserInfo.getOrganizationId()];
        
        return myOrg.IsSandbox;
    }
    
    
    public PageReference checkoutAsGuest() {
        System.debug('am I being called???');
        System.debug('Hallo!!');
        
		
        //PageReference nextPage = Page.OcdlaCheckoutPayment;
        Pagereference nextPage=null;
        Map<String,String> params = nextPage.getParameters();
        
        params.put('id', this.cartId);

        
        // Collect FirstName, LastName, Email, AccountId.
        // 
        // Creating a new Contact in our CRM with the above values.
        

        
        // Creates guest contact, attaches to opportunity, inserts contact, then updates opportunity all in one go
        // customer = ClickpdxCheckoutGuestController.generateGuestCheckoutContact(customer, this.cartId);
        this.customer.AccountId = getGuestCheckoutAccountId();
        upsert this.customer;
        
        // Guest customer now has an Id, which we want to associate with the underlying Opportunity.
        attachAccount(this.customer, this.cartId);
        
        
        // Reading documentation to figure out how to redirect.
        // return Page.Whatever (where Whatever is the name of the next page in the "flow");
        nextPage.setRedirect(False);
        return nextPage;
    }

    
    
    public OcdlaCheckoutController(ApexPages.StandardController controller){}
    
    
    private List<SelectOption> getStateOptions() {
        List<SelectOption> stateOptions = States.getAsSelectOptions();

        return stateOptions;
    }

    
    public OcdlaCheckoutController() {
        //super('CheckoutCommunityConfig');

		Map<String,String> params = ApexPages.CurrentPage().getParameters();
        System.debug(params);

        this.setupCustomer();
        //TO DO add ref to customer profile id
        //customerProfileId='905372692';
        //note current contact's id is in AuthorizeDotNetCustomerProfileId__c in Contact
        //this.creditCards = CreditCard.retrieveSavedCards(customerProfileId);
        //this.cardOptions = CreditCard.toSelectOptions(this.creditCards);
        

        this.stateOptions = getStateOptions();

        if (this.defaultCard == null) {
            this.defaultCard = new Map<string, string>();
        }
        this.billingData = new Map<String, String>();
        this.billingData.put('BillingFirstName', this.defaultCard.get('firstName'));
        this.billingData.put('BillingLastName', this.defaultCard.get('lastName'));
        this.billingData.put('BillingStreet', this.defaultCard.get('address'));
        this.billingData.put('BillingCity', this.defaultCard.get('city'));
        this.billingData.put('BillingPostalCode', this.defaultCard.get('zip'));
        this.billingData.put('BillingStateCode', this.defaultCard.get('state'));
        
        this.shippingData = new Map<String, String>();
        this.shippingData.put('ShippingStreet', '42 Sherman Wallaby Way');
        this.shippingData.put('ShippingCity', 'Eugene');
        this.shippingData.put('ShippingPostalCode', '12345');
        this.shippingData.put('ShippingStateCode', 'OR');
        
        if (this.ccData == null) {
            this.ccData = new Map<String, String>();
            this.ccData.put('ccNum', '4111111111111111');
            this.ccData.put('ccExp', '08/2026');
            this.ccData.put('ccCode', '123');
        }
        
        
        // Fill the above data in at the setupCustomer() method
        
        // Why do we need to check if Sandbox.  Could be legit, but let's find out the *why!
        this.isSandbox = isSandbox();
        // Id cartId = params.get('cartId') != null ? params.get('cartId') : '0060500000CtjjBAAR';
        this.cartId = params.get('id');
        this.opp = Database.query('SELECT Id, Name, Amount, StageName, AccountId, Contact__c, Pricebook2Id FROM Opportunity WHERE Id = :cartId');
        
        this.isPaid = this.opp.StageName == 'Closed Won' ? True : False;
        
        this.isFreeCart = !(this.opp.Amount > 0.00);
        
        this.hasShippableProducts = False;
        
        this.renderPayment = !this.isPaid ? True : False;
    }
        
    public void setupCustomer() {
        // Remember, for guest users, this evaluates to the OCDLA Member Community User, which doesn't have an associated Contact.
        User u = [SELECT Id, ContactId FROM User WHERE Id = :UserInfo.getUserId()];
        
        if(null == u.ContactId) {
            this.isLoggedIn = False;
            // this.customer = [SELECT Id, AccountId, FirstName, LastName, Email FROM Contact WHERE AccountId = :OrgOcdla.getGuestCheckoutAccountId() LIMIT 1];
            this.customer = [SELECT Id, AccountId, FirstName, LastName, Email FROM Contact WHERE Id = '0030500000VU3SzAAL' LIMIT 1];
            this.firstName = this.customer.FirstName;
            this.lastName = this.customer.LastName;
            
        } else {
            this.isLoggedIn = True;
        	// this.customer = [SELECT Id, AccountId, FirstName, LastName, Email FROM Contact WHERE Id = :u.ContactId];
            this.customer = getLoggedInUserData(u.ContactId);
            this.firstName = this.customer.FirstName;
            this.lastName = this.customer.LastName;
            this.mailingStreet = this.customer.MailingStreet;
            this.mailingCity = this.customer.MailingCity;
            this.mailingPostalCode = this.customer.MailingPostalCode;
        }
    }
    
    public PageReference redirectIfSobjectError(){
		return OrgOcdla.redirectTo(OrgOcdla.SHOPPING_CART_REGENERATE_OPPORTUNITY_PAGE);
    }
    
    @RemoteAction
    global static Boolean attachAccount(Contact c, String oppId){
        Id accountId;
        
        // accountId = 
        Opportunity opp = new Opportunity(Id = oppId, AccountId = c.AccountId, Contact__c=c.Id);
        update opp;
        return True;
    }
    
        
    public String getCartName(){
        return this.opp.Name;
    }
    
    public String getCartSummary(){
        return this.shoppingCartSummary;
    }
    
    public String getCartTotal(){
        return String.valueOf(this.opp.Amount);
    }
    
    public String getOrderEmail(){
        Boolean isGuestAccount = False;
        String email = this.customer.Email;
        
        return email;
    }

    
    public Contact getLoggedInUserData(string customerId) {
        // will return the contact object of the logged in user, see checkOrderEmail return below
        // because it's a static function we can't use class variables like billToContact
        // UserInfo may be tied to the class and possibly not usable in static functions
        // we will have another function to get the saved CCs after getting the logged in user
        Contact c = [SELECT FirstName, LastName, Email, MailingStreet, MailingPostalCode, MailingCity, Ocdla_Address_Line_1__c, 
                          Ocdla_Address_Line_2__c, MailingStateCode, AccountId, Account.Name FROM Contact WHERE Id = :customerId];
        
        // could probably add a check here to make sure the contact isn't empty or something
        
        return c;
    }
    
    public void preSubmitPayment() {
        System.debug('yoyoyoyo');
        this.order = this.processOrderStub();
    }
    
    public PageReference submitPayment() {
        System.debug(this.billingData);
        
        TransactionRequest req = new TransactionRequest();
        req.setAmount(this.opp.Amount);
        req.setCreditCard(this.ccData);
        req.setBillToAddress(this.billingData);
        req.setShipToAddress(this.shippingData);

        AuthorizeDotNetClient client = new AuthorizeDotNetClient(AuthorizeDotNetClient.GATEWAY_SANDBOX_URL);
        
        TransactionResponse resp = client.send(req);

        
        
        //Map<String, String> newData = transact.getResponse();
        
        if (!resp.success()) {
            // do errors
            // noo
            System.debug(this.ccData);
            System.debug(resp.getBody());
            return null;
        }
        
       
        
        // if..else
        // success
		order = this.finalizeOrder(order.Id, resp.getBody());    
        
        
        // 
        // Takes billing and shipping information using billingData and shippingData and ccData
        // Submits all information to the credit card processing controller (OcdlaCCAuthorize controller) using static function
        // Get result from submitting data
        // if..else success, redirect to order confirmation page. else, "you failed"
		// if success, calls processOrderStub first, that gets opportunity (which we wont have to do because we call all of this serverside)
        //         
		PageReference nextPage = Page.OrderConfirmation;
        Map<String,String> params = nextPage.getParameters();
        // processOrderStub() - make sure we can successfully convert the shopping cart into an order
        // Note: This does NOT create order items. We only create order items when we finalize the order.
        // 
        // OcdlaCCAuthorize. - process cc data.
        // 
        // finalizeOrder() - creates the order with the verified data.
        
        
        string theOrderId = order.Id;
        params.put('id', theOrderId);
        
        // Reading documentation to figure out how to redirect.
        // return Page.Whatever (where Whatever is the name of the next page in the "flow");
        nextPage.setRedirect(True);
        return nextPage;        
    }
    
    public Order processOrderStub(){
        // get opportunity id (shopping cart id)
        // format billing data into map<string, string>
        // construct billing data (billingfirstname, billinglastname, billingaddress, etc)
        Order o;
		System.debug(this.billingData);
        System.debug(this.shippingData);
        o = ClickpdxOrder.newFromShoppingCart(this.opp, this.billingData, this.shippingData);
        upsert o;
        
        return [SELECT Id, OrderNumber, EffectiveDate, Status, OpportunityId, AccountId, BillToContactId,
                               ShipToContactId, PriceBook2Id FROM Order WHERE Id = :o.Id];
    }
    
    public Order finalizeOrder(String orderId, Map<String,String> ccResp){
        
        Order o = new Order();
        o.Id = orderId;
        o.Payment_Info__c = JSON.serialize(ccResp);
        o.Origin__c = 'Web Order';
        
        update o; //actually updates
        
		ClickpdxOrder.draftOrderLinesFromShoppingCart(o.Id);
        
		ClickpdxOrder.activateOrder(orderId);
        
        return [SELECT Id, Payment_Info__c, Origin__c FROM Order WHERE Id = :orderId];
    }

    
    @RemoteAction
    global static List<Contact> checkOrderEmail(String email){
       String out = email.trim();
        
       Map<String,String> resp = new Map<String,String>();
        
       List<Contact> c = [SELECT FirstName, LastName, Email, MailingStreet, MailingPostalCode, MailingCity, Ocdla_Address_Line_1__c, 
                          Ocdla_Address_Line_2__c, MailingStateCode, AccountId, Account.Name FROM Contact WHERE Email = :out OR OrderApi__Work_Email__c = :out];
       
       return c;
    }

    
    
    @RemoteAction
    global static Contact generateGuestCheckoutContact(Contact c, Id oppId){
        String firstName = c.FirstName;
        String lastName = c.LastName;
        String emails = c.Email;
        
        
        
        
        Contact guest = new Contact(AccountId = getGuestCheckoutAccountId(), 
                                    FirstName = c.FirstName,
                                    LastName = c.LastName,
                                    Email = c.Email,
                                    OrderApi__Work_Email__c = c.Email);
        
        insert guest;
        attachAccount(guest,oppId);
        return guest;
    }    
	
}