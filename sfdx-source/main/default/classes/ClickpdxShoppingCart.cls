global without sharing class ClickpdxShoppingCart extends ClickpdxOpportunity {

    public ClickpdxShoppingCartStatus status {get;private set;}

    public String errorMessage {get;private set;}
    
    // Legacy attribute for Visualforce action methods.
    public String responseData {get{
        if(null == this.response){
            return JSON.serialize('{}');
        }
        return JSON.serialize(this.response);
    }private set;}
    
    public ClickpdxCartResponse response {get;private set;}

    public Boolean hasErrors {get;private set;}
    
    final static Boolean ENABLE_LOAD_CART_FROM_SESSION = True;
    
    final static String CART_SUCCESSFULLY_CHECKED_OUT = 'Closed Won';
    
    // @var MONTHS_VALID
    // @type Integer
    // @description
    //   Integer indicating how many months from today's date
    //   the Opportunity will remain in an Open state.  
    final static Integer MONTHS_VALID = 2;
     
    public Id forOpportunityId {
        public get {return forOpportunityId;}
        public set {
            forOpportunityId = value;
            if(null != value){
                this.cart = getOpportunitySObject(value);
                this.cartItems = ClickpdxCartItem.loadFromOpportunityId(this.cart.Id);
                this.a = [SELECT Id, Name FROM Account WHERE Id = :this.cart.AccountId];
                this.status = ClickpdxShoppingCartStatus.CART_COOKIE_PERSISTED;
                ClickpdxShoppingCartCookie.setShoppingCartId(this.getId());
            }
        }
        
    }
  
	
    public Id getId(){
        return this.cart.Id;
    }
    
    
    
    public ClickpdxShoppingCart(){

        if(null == ClickpdxShoppingCartCookie.getShoppingCartId()){
			super(new Account(Id = OrgOcdla.getGuestCheckoutAccountId()));
            // upsert this.cart;
        }
        
        else if(ENABLE_LOAD_CART_FROM_SESSION && null != ClickpdxShoppingCartCookie.getShoppingCartId()){

            // If the shopping cart is dead for some reason, deleted on the backend 
            //  or otherwise invalid.
            try {
                this.cart = getOpportunitySObject(ClickpdxShoppingCartCookie.getShoppingCartId());
                this.cartItems = ClickpdxCartItem.loadFromOpportunityId(this.cart.Id);
                this.a = [SELECT Id, Name FROM Account WHERE Id = :this.cart.AccountId];
                this.status = ClickpdxShoppingCartStatus.CART_COOKIE_PERSISTED;
            } catch(ClickpdxOpportunityException e){
                ClickpdxShoppingCartCookie.invalidateShoppingCartCookie(this.cart.Id);
                this.a = new Account(Id = OrgOcdla.getGuestCheckoutAccountId());
                this.cart = this.getOpportunitySObject(this.a); 
                this.cartItems = new Map<String,ClickpdxCartItem>();
            } 
        }
    }
    
    public static ClickpdxShoppingCart loadFromOpportunityId(String opportunityId){
        ClickpdxShoppingCart theOpp;
        
		return new ClickpdxShoppingCart(opportunityId);
    }
    

    public ClickpdxShoppingCart(String opportunityId){
        super(opportunityId);
    }
    
    public static Id getShoppingCartId() {
    	return ClickpdxShoppingCartCookie.getShoppingCartId();   
    }
    
    
    public ClickpdxShoppingCart(Account acc){
        super(acc);
        
        if(ENABLE_LOAD_CART_FROM_SESSION && null != ClickpdxShoppingCartCookie.getShoppingCartId()){
            this.cart = getOpportunitySObject(ClickpdxShoppingCartCookie.getShoppingCartId());
        } else {
            this.cart = this.getOpportunitySObject(this.a);
        }

        this.cartItems = new Map<String,ClickpdxCartItem>();
    }
    
    public ClickpdxShoppingCart(Account acc, String opportunityName){
        super(acc, opportunityName);

        this.cart = this.getOpportunitySObject(this.a);

        this.cartItems = new Map<String,ClickpdxCartItem>();
    }


    protected override Opportunity getOpportunitySObject(Account a){
    	return this.getOpportunitySObject(a,'OCDLA Shopping Cart');
    }
    
    public Opportunity getOpportunitySObect(){
        return this.cart;
    }
    
    public Opportunity getOpportunitySObject(Account a, String opportunityName){
		Opportunity opp = new Opportunity();
    	opp.CloseDate = date.today().addMonths(MONTHS_VALID);
    	opp.Name = opportunityName;
    	opp.StageName = 'Prospecting';
    	opp.AccountId = a.Id;
    	opp.Pricebook2Id = OrgOcdla.getStdPriceBookId();
        return opp;
    }

   
    public ClickpdxCartItem getItem(String key){
        return this.cartItems.get(key);
    }
    
    public PageReference checkout(){
        PageReference checkout = OrgOcdla.CHECKOUT_PAGE;
        
        if(null != checkout){
            checkout.setRedirect(true);
            checkout.getParameters().put('id',ClickpdxShoppingCartCookie.getShoppingCartId());
        }
        
        return checkout;
    } 
    


    
    /**
     * ACTIONS
     * *
     */
    
    public PageReference addAction(){
        return doCartAction('add');
    }
    
    public PageReference updateAction(){
        return doCartAction('update');
    }
    
    public PageReference removeFromCartAction(){
		return doCartAction('remove');
    }

    public PageReference addRelatedItems(){
        return doCartAction('addRelatedItems');
    }
    
    public PageReference refreshAction(){
        return doCartAction('refresh');
    }
    
    public PageReference persistAction(){
        return doCartAction('persist');
    }
    
    public PageReference persist(){
        return doCartAction('persist');
    }

	
    public PageReference doCartAction(String action){
        // The parameters passed to this page:
        // oppLineItemId - the id of a given Opportunity Product; would be used to update that line item in the cart; default, empty string.
        // clientId - the local js id given to this line item; default, empty string.
        // pricebookEntryId - the pricebookEntryId of the Product2 to be added to the cart; should never be empty.
        // quantity - the number of this item to add to the cart; default, '1'.
        // firstName - a given first name to attach to this line item; default, empty string; for event registrations this is the "badge name."
        // lastName - a given last name to attach to this line item; default, empty string.
        // email - the specified email to attach to this line item; default, empty string; should be used as a lookup to an existing Contact;
        //   otherwise, should be used to create a new Contact in the AMS.
        try {
            this.response = doAction(action,ApexPages.currentPage().getParameters());
            // throw new ClickpdxShoppingCartException('There was a test error.'); 
        } catch(ClickpdxShoppingCartInvalidFormException xform){
            this.response = new ClickpdxCartResponse();
            if(null != xform.getProduct()){
                this.response.affectedItems.add(xform.getProduct());
            }
            this.response.addError(xform);
        } catch(ClickpdxShoppingCartException shopx){
            this.response = new ClickpdxCartResponse();
            if(null != shopx.getProduct()){
                this.response.affectedItems.add(shopx.getProduct());
            }
            this.response.addError(shopx);
        }  catch(Exception e){
            this.response = new ClickpdxCartResponse();
            this.response.addError(e);
        }
        return null;
    }
    
    public ClickpdxCartResponse doAction(String action, Map<String,Object> params){
        ClickpdxCartResponse response;
        
    
        response = new ClickpdxCartResponse();
        List<ClickpdxCartItem> affectedItems;
        
         
        if(action == 'refresh'){
            
        }
        else if(action == 'persist'){
            String userAgent = (null != params.get('userAgent') && ((String)params.get('userAgent')).trim() != '') ? (String)params.get('userAgent') : 'Unknown';
            
            Id cartId = save(userAgent);
            
            
            ClickpdxShoppingCartCookie.setShoppingCartId(this.cart.Id);
        }
        else if(action == 'add'){
            affectedItems = ClickpdxCartActionAddToCart.doAction(this,params);
        }
        else if(action == 'update'){
            affectedItems = ClickpdxCartActionAddToCart.doAction(this,params);
        }
        else if(action == 'remove'){
            affectedItems = ClickpdxCartActionRemoveFromCart.doAction(this,params);                
        }
        this.save(); 
        response.affectedItems = affectedItems;
        response.attachCart(this);
        
        
        return response;
    }


    
    public ClickpdxCartItem removeItem(ClickpdxCartItem item){
       return this.cartItems.remove(item.key());
    }


	@testVisible
    public void addItem(ClickpdxCartItem item){
        this.cartItems.put(item.key(),item);
    }
    
    public Id save(){
        return this.save(null);
    }
    
    
    public Id save(String userAgent){
        if(null == this.cart){
            throw new ClickpdxShoppingCartException('Shopping cart SObject is null.');
        }
        this.cart.UserAgent__c = userAgent;
    	upsert this.cart;
        

            
        for(ClickpdxCartItem l :this.cartItems.values()){
            l.opportunityId = this.getId();
            l.save();
        }

        return this.getId();
    }
    
    
    
    @RemoteAction
    global static Id persistCartRemote(){
        Opportunity cart;
        
        cart = new Opportunity();//RecordTypeId = recordTypeId);
        cart.StageName = 'Prospecting';
        cart.Name = 'OCDLA Shopping Cart';
        cart.CloseDate = System.today()+30;
        cart.AccountId = OrgOcdla.getGuestCheckoutAccountId();
        
        
        upsert cart;

        
        return cart.Id;
    }
    
    
    
    @RemoteAction
    public static Boolean hasShippableProducts(Id cartId){
        List<OpportunityLineItem> lines = [SELECT Id, Product2.IsShippable__c FROM OpportunityLineItem WHERE OpportunityId = :cartId];
        
        for(OpportunityLineItem line :lines){
            if(line.Product2.IsShippable__c) return True;
        }
        
        return False;
    }

    

    
    



    
    
    
    /**
     * 
     * @method - removeCartItem
     * 
     * @description - delete an OpportunityLineItem from the Salesforce platform.
     * 
     * @param - Id lineId - the OpportunityLineItem Id to be deleted.
     * 
     * throws Id not found Exception; in cases where the underlying Opportunity has been deleted; or when
     *   the OpportunityLineItem has already been deleted.
     * 
     */
    @RemoteAction
    public static void removeCartItem(Id lineId){
        if(null == lineId){
            throw new CartItemDoesNotExistException('That item doesn\'t exist in your Shopping Cart.');
        }
        List<OpportunityLineItem> forDelete;
		forDelete = [SELECT Id FROM OpportunityLineItem WHERE Id = :lineId];
        
        ClickpdxCartItem theLine = new ClickpdxCartItem();

        
        if(forDelete.size() < 1){
            throw new CartItemDoesNotExistException('The referenced item does not exist in this Shopping Cart.');
        }
        
        else {
            theLine.opportunityLineItemId = forDelete[0].Id;
			theLine.del();
        }
    }


    public static ClickpdxShoppingCart loadFromSessionShoppingCartId(){
        String shoppingCartId = ClickpdxShoppingCartCookie.getShoppingCartId();
        
        if(null == shoppingCartId){
			throw new ClickpdxShoppingCartException('Shopping Cart Id is null.');
        }
		return null != shoppingCartId ? new ClickpdxShoppingCart(shoppingCartId) : null;
    }
    

    // Convert a Shopping Cart Opportunity to "Won" Stage after successful Checkout.
    public PageReference convertOpportunityToWon(){
        try{
            Id opportunityId = ClickpdxShoppingCartCookie.getShoppingCartId();
            
            Opportunity opp = new Opportunity(Id=opportunityId, StageName=CART_SUCCESSFULLY_CHECKED_OUT);
            update opp;
            
            ClickpdxShoppingCartCookie.invalidateShoppingCartCookie(null);
            
            
        } catch(Exception e){
            this.hasErrors = True;
            this.errorMessage = e.getTypeName()+': '+e.getMessage() + ' '+e.getStackTraceString();
            return null;
        }
        
        return null;
    }

    
    public Integer count(){
        return this.cartItems.size();
    }
    

    

 
    public class CartItemDoesNotExistException extends Exception {}
}