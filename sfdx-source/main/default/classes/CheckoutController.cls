public without sharing class CheckoutController extends CommunityController {
    
    
    public String errorMessage { get; private set; }
    
    public CheckoutController() {
        errorMessage = '';
    }
    
    
    Map<Boolean,PageReference> redirects = new Map<Boolean,PageReference>{
        True => Page.OrderConfirmation,
        False => Page.OrderConfirmation
    };
    
    
    public PageReference ProcessPaymentWithRedirect() {
        
        Boolean result;
        
        PageReference next = Page.OrderConfirmation;
        
        Map<String,Object> formData = GetFormData();
        
        try{
            
            result = ProcessPayment(formData);
            next = redirects.get(result);
            
            
						// Orders.Save(body);
        
            
            
            
            
            // PaymentInstrument.Save(body);
		// ISObject pi = pi.save();
        // ISObject pi = pi.remove();
        
        // Wrapper-class implements ISObject so it can save and remove data.
        String iSObjectName = 'PaymentInstrument';
        
        System.Type t = System.Type.forName(iSObjectName);
        ISObject storage = (ISObject) t.newInstance();
        storage.setData(formData);
        storage.save();
				
            
            
            
            return next;
        
        } catch(Exception e) {
            result = false;
            this.errorMessage = e.getMessage();
            return next;
        }
    }
    
    
    /**
     * We can save payment methods for users, accounts, and contacts by using "EntityId"
     */
    public Boolean ProcessPayment(Map<String,Object> formData){
        formData.put('entityId', (String)Session.GetCurrentEntityId());
        String data = PrepareFormData(formData);
        
        String packageMessenger = 'ProcessPayment';
        Type t = Type.forName(packageMessenger);
        
        Callable payment = (Callable) t.newInstance();
        
        return (Boolean) payment.call('process',new Map<String,Object> { 'data' => data });
    }
    
    
    
    public String PrepareFormData(Map<String,Object> formData){
        return json.serialize(formData);
    }
    
    
    
    public Map<string,object> GetFormData(){
        return ApexPages.currentPage().getParameters();
    }
    
    
    
    
}