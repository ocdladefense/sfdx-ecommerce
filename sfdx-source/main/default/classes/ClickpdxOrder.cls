global without sharing class ClickpdxOrder {

    
    Id orderId;
    
    List<OrderItem> theItems;
    
    Order theOrder;
    
    public static Boolean TRIGGER_IS_EXECUTING = False;
    
    public ClickpdxOrder(){
        theOrder = new Order();
        theOrder.Pricebook2Id = ClickpdxCore.Application.config.getStdPriceBookId();
        theOrder.EffectiveDate = System.today();
        theOrder.Status = 'Draft';
        theItems = new List<OrderItem>();
    }
    
    public ClickpdxOrder(Id accountId){
        this();
        theOrder.AccountId = accountId;
    }
    

    public static Order newFromShoppingCart(Opportunity opp){
   		return newFromShoppingCart(opp, new Map<String,String>());   
    }
    

    
    public static Order newFromShoppingCart(Opportunity opp, Map<String,String> billingData){
        Order o = new Order();
        o.EffectiveDate = System.today();
        o.Status = 'Attempted Payment';
        o.OpportunityId = opp.Id;
        o.AccountId = opp.AccountId;
        o.PriceBook2Id = opp.Pricebook2Id;
 
        
        // List of Billing fields to update on the Order.
        o.BillToContactId = opp.Contact__c;
        o.BillingStreet = billingData.get('BillingStreet');
        o.BillingCity = billingData.get('BillingCity');
        o.BillingPostalCode = billingData.get('BillingPostalCode');
        o.BillingStateCode = billingData.get('BillingStateCode');
        o.BillingCountryCode = 'US';
        // o.CCNumber__c = billingData.get('ccNum') == null ? null : billingData.get('ccNum').substring(12);
        
         
        // List of Shipping fields to update on the Order.
        o.ShipToContactId = opp.Contact__c;
        o.ShippingStreet = billingData.get('ShippingStreet');
        o.ShippingCity = billingData.get('ShippingCity');
        o.ShippingStateCode = billingData.get('ShippingStateCode');
        o.ShippingPostalCode = billingData.get('ShippingPostalCode');
		o.ShippingCountryCode = 'US';
        

        
        return o;
    }
    
    public static Order newFromShoppingCart(Opportunity opp, Map<String, String> billingData, Map<String, String> shippingData) {
         Order o = new Order();
        o.EffectiveDate = System.today();
        o.Status = 'Attempted Payment';
        o.OpportunityId = opp.Id;
        o.AccountId = opp.AccountId;
        o.PriceBook2Id = opp.Pricebook2Id;
 
        
        // List of Billing fields to update on the Order.
        o.BillToContactId = opp.Contact__c;
        o.BillingStreet = billingData.get('BillingStreet');
        o.BillingCity = billingData.get('BillingCity');
        o.BillingPostalCode = billingData.get('BillingPostalCode');
        o.BillingStateCode = billingData.get('BillingStateCode');
        o.BillingCountryCode = 'US';
        // o.CCNumber__c = billingData.get('ccNum') == null ? null : billingData.get('ccNum').substring(12);
        
         
        // List of Shipping fields to update on the Order.
        o.ShipToContactId = opp.Contact__c;
        o.ShippingStreet = shippingData.get('ShippingStreet');
        o.ShippingCity = shippingData.get('ShippingCity');
        o.ShippingStateCode = shippingData.get('ShippingStateCode');
        o.ShippingPostalCode = shippingData.get('ShippingPostalCode');
		o.ShippingCountryCode = 'US';
        

        
        return o;
    }
    
    
    webservice static Id draftOrderFromShoppingCart(Id oppId){
        Opportunity theOpp = [SELECT Id, Pricebook2Id, AccountId FROM Opportunity WHERE Id = :oppId];
        List<Order> related = [SELECT Id, OpportunityId FROM Order WHERE OpportunityId = :oppId LIMIT 1];
        
        System.debug(theOpp);
        
        Contact c = [SELECT Id, Name, Email FROM Contact where AccountId = :theOpp.AccountId LIMIT 1];
        Order theOrder;
         

        theOrder = new Order();
        theOrder.Id = null == related ? null : (0 == related.size() ? null : related[0].Id);
        theOrder.OpportunityId = oppId;
        theOrder.AccountId = theOpp.AccountId;
        theOrder.BillToContactId = c.Id;
        theOrder.EffectiveDate = System.today();
        theOrder.Status = 'Draft';
        if(null == related || 0 == related.size()){
            theOrder.Pricebook2Id = theOpp.Pricebook2Id;
        }
        
        upsert theOrder;
        
        draftOrderLinesFromShoppingCart(theOrder.Id);
        
        return theOrder.Id;
    }
          
    
    public static Map<Id,Boolean> hasShippableItems(Map<Id,Order> orders){
        Boolean PRODUCT_NEEDS_SHIPPING = True;
        
        List<OrderItem> lines;
        Map<Id,Boolean> isShippableMap = new Map<Id,Boolean>();
        
        for(Id oId :orders.keySet()){
            isShippableMap.put(oId,False); // Start by assuming no Shippable Items.
        }
        
        lines = new List<OrderItem>();
        
        lines.addAll([SELECT Id, OrderId, Product2.IsShippable__c FROM OrderItem WHERE OrderId = :orders.keySet()]);
        
        for(OrderItem line :lines){
            if(line.Product2.IsShippable__c) {
                isShippableMap.put(line.OrderId,PRODUCT_NEEDS_SHIPPING);
            }
        }
        
        return isShippableMap;
    }

    public static void draftOrderLinesFromShoppingCart(Id orderId){
        Order thisOrder;
        List<OrderItem> orderLines;
        Contact c = null;

        thisOrder = null == orderId ? new Order() : [SELECT Id, OpportunityId, BillToContactId, Status FROM Order WHERE Id = :orderId];
            
        if(null != thisOrder && null != thisOrder.BillToContactId){
            c = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE Id = :thisOrder.BillToContactId];
        }   
            
        orderLines = [SELECT Id FROM OrderItem WHERE OrderId = :orderId];
        
        if(null != orderLines && orderLines.size() > 0) {
            delete orderLines;
            // Why are we saving the Order if it doesn't have any lines
            //   alternatively, why are we saving the Order if are only nuking it's related Order Products?
            upsert thisOrder;
        }
        


        Map<Id,OpportunityLineItem> cartItems = new Map<Id,OpportunityLineItem>([SELECT Id, Data__c, FirstName__c, LastName__c, Email__c, 
					Quantity, Product2Id, Description, PricebookEntryId, UnitPrice, Contact__c, ParentLineId__c,
					Product2.IsShippable__c FROM OpportunityLineItem
					WHERE OpportunityId = :thisOrder.OpportunityId]);
        
        Map<Id,OrderItem> oppLineItemsToOrderItems = new Map<Id,OrderItem>();
        
        
        for(OpportunityLineItem li :cartItems.values()){
            OrderItem o = new OrderItem();

            o.OrderId = thisOrder.Id;
            o.Quantity = li.Quantity;
            o.Data__c = li.Data__c;
            o.Description = li.Description;
            o.UnitPrice = li.UnitPrice;
            o.Contact__c = li.Contact__c != null ? li.Contact__c : (c == null ? null : c.Id);
            o.FirstName__c = li.FirstName__c != null ? li.FirstName__c : (c == null ? null : c.FirstName);
            o.LastName__c = li.LastName__c != null ? li.LastName__c : (c == null ? null : c.LastName);
			o.Email__c = li.Email__c;
            o.Product2Id = li.Product2Id;
            o.PricebookEntryId = li.PricebookEntryId;
            o.ParentLineId__c = li.ParentLineId__c;
            oppLineItemsToOrderItems.put(li.Id,o);
        }
        
        insert oppLineItemsToOrderItems.values();
        
        for(Id relatedOppId : oppLineItemsToOrderItems.keySet()){
            Id parentIdKey; // The key to retrieving the actual Parent Line ID.
            Id actualParentId; // The actual Id value of the retrieved Parent Line record.
            
            parentIdKey = oppLineItemsToOrderItems.get(relatedOppId).ParentLineId__c;
            
            // No need to update this line if there was never a reference to a Parent Line.
            if(null == parentIdKey || null == oppLineItemsToOrderItems.get(parentIdKey)) continue; 
            
            actualParentId = oppLineItemsToOrderItems.get(parentIdKey).Id;
            OrderItem forUpdate = oppLineItemsToOrderItems.get(relatedOppId);
            forUpdate.ParentLineId__c = actualParentId;
        }

        upsert oppLineItemsToOrderItems.values();
    }
    
    
    
    @RemoteAction
    public static void activateOrder(Id orderId){
        Order oNew = [SELECT Id, Payment_Info__c, Origin__c, Status FROM Order WHERE Id = :orderId];
        oNew.Status = 'Posted Payment';
        update oNew; 
    }
    
    
    public OrderItem addItem(OrderItem line){
        
        this.theItems.add(line);
        return line;
    }
    
    public OrderItem addEventTicket(Product2 p){

        return new OrderItem();        
    }
    
    public ClickpdxOrder save(){
        upsert theOrder;
        
        for(OrderItem item :theItems){
            item.OrderId = theOrder.Id;
        }
        
		insert theItems;
        return this;
    }
    
    webservice static Order createPaidOfficeEventOrder(Id eventId, Id accountId){
        ClickpdxOrder o = new ClickpdxOrder(accountId);
        OcdlaEvent theEvent = new OcdlaEvent(eventId);
        
        List<Contact> contacts = [SELECT Id, Ocdla_Member_Status__c, FirstName, LastName, Email FROM Contact WHERE AccountId = :accountId 
                                 AND Ocdla_Current_Member_Flag__c = True ORDER BY LastName];
        
        for(Contact c :contacts){
            OrderItem item;
            if(null == c.Ocdla_Member_Status__c) continue;
            item = theEvent.createOrderItem(c);
            if(null != item) o.theItems.add(item);
        }
        
        o.save();
        
        return o.theOrder;
    }
    
}