public class TransactionResponse {


    private static final String TRANSACTION_SUCCESS = '1'; // failure if not transaction_success

    private Map<String,String> body;
    

        
        
    
    public TransactionResponse(Map<String,String> body) {
    	this.body = body;   
    }
    
    public static TransactionResponse newFromResponse(HttpResponse resp) {
        String body = resp.getBody();
        Map<String,String> nbody = (Map<String,String>)JSON.deserialize(body, Map<String,String>.class);
        TransactionResponse nresp = new TransactionResponse(nbody);
        
        return nresp;
    }
    
    
    public Boolean success() {
        return this.getBody().get('TransactionResponseCode') == TRANSACTION_SUCCESS;
    }
    
    public Map<String,String> getBody() {
        return this.body;
    }
    
    
 
}