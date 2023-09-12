public class TransactionClient {
    
    
    private static final String GATEWAY_SANDBOX_URL = 'membertest.ocdla.org';
    
    private static final String GATEWAY_PRODUCTION_URL = 'members.ocdla.org';
    
    
    public TransactionClient() {

    }
      
    
    // Customer has input all data fields.
    public static TransactionResponse doPayment(Decimal amount, Map<String,String> ccData, String orderNumber, Map<String,String> billingData, Map<String,String> shippingData) {
        // create params map and merge all maps into it


        TransactionRequest req = TransactionRequest.fromSalesforceData(amount, ccData, orderNumber, billingData, shippingData);
          
        String domain = getDomain();
        
        AuthorizeDotNetClient2 client = new AuthorizeDotNetClient2(domain);
          
        return client.send(req);
    }  
    
    
    public static String getDomain(){
        Organization org = [SELECT Id, InstanceName, IsSandbox FROM Organization WHERE Id = :UserInfo.getOrganizationId()];
        
        // Ocdla_Apps__c profileSettings = Ocdla_Apps__c.getValues(UserInfo.getUserId());
        // Ocdla_Apps__c orgDefaults = Ocdla_Apps__c.getOrgDefaults();
        
        return org.IsSandbox ? GATEWAY_SANDBOX_URL  : GATEWAY_PRODUCTION_URL;
    }
    
    
    // Customer didn't input extra shipping data; exclude from doPayment.
    public static TransactionResponse doPayment(Decimal amount, Map<String,String> ccData, String orderNumber, Map<String,String> billingData) {
        return doPayment(amount, ccData, orderNumber, billingData, null);
    }
    
    // Customer used saved cc; exclude billingData and shippingData.
    public static TransactionResponse doPayment(Decimal amount, Map<String,String> ccData, String orderNumber) {
        return doPayment(amount, ccData, orderNumber, null, null);
    }
    
    // Customer used saved cc; exclude billingData and shippingData, and no order to process.
    public static TransactionResponse doPayment(Decimal amount, Map<String,String> ccData) {
        return doPayment(amount, ccData, null, null, null);
    }
    
    
}