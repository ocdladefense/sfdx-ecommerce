public class Credentials extends AuthorizeDotNetType {


    private String name;

    private String transactionKey; 

	private String url;


  
    public Credentials(String name, String transactionKey) {
        this.name = name;
        this.transactionKey = transactionKey;
    }
    
    
    public Credentials(String name, String transactionKey, String url) {
        this(name,transactionKey);
        this.url = url;
    }


    public String getName() {
        return this.name;
    }
    
    
    public override Set<String> keySet() {
        return new Set<String>{'name', 'transactionKey'};
    }


    public String getTransactionKey() {
        return this.transactionKey;
    }
    
    
    public String getUrl() {
        return this.url;
    }
    
    public override Map<String,Object> toMap() {
        return new Map<String,Object>{'name' => this.name, 'transactionKey' => this.transactionKey};
    }


    public static Credentials newFromCustomSettings() {

        Credentials__mdt c = [SELECT Url__c, Data__c FROM Credentials__mdt WHERE DeveloperName = 'AuthorizeDotNet' LIMIT 1];
  
        Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(c.Data__c);

        return new Credentials((String)data.get('name'), (String)data.get('transactionKey'), c.Url__c);
    }
}