public class Credentials extends AuthorizeDotNetType {


 
    private String name;

    private String transactionKey; 

    public Credentials(String name, String transactionKey) {
        this.name = name;
        this.transactionKey = transactionKey;
        this.fields = new Set<String> {'name', 'transactionKey'};
    }



    public String getName() {
        return this.name;
    }

    public String getTransactionKey() {
        return this.transactionKey;
    }
}