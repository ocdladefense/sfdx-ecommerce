public class QuickBooksController {

    public List<Map<String,String>> contacts {get; private set;}
    
    
    public QuickBooksController() {
        
        QueryRequest req = new QueryRequest();
        req.setQuery('select * from Customer Where Metadata.LastUpdatedTime > \'2023-08-01\'');
        
        String clientId = (String)Cache.Org.get('local.Default.clientId');
        String clientSecret = (String)Cache.Org.get('local.Default.clientSecret');
        QuickBooksClient client = new QuickBooksClient(clientId, clientSecret);
        
        HttpResponseMessage resp = client.send(req);
        
          
        String body = resp.getBody();
        
        System.debug(body);
        
        List<Map<String,String>> contacts = new List<Map<String,String>>();
        
    }
}