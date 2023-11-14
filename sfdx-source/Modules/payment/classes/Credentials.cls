public class Credentials extends AuthorizeDotNetType{



    private String name;

    private String transactionKey; 

    public Credentials(String name, String transactionKey) {
        this.name = name;
        this.transactionKey = transactionKey;
        this.orderedFieldList = new List<String> {'name', 'transactionKey'};
    }

    public override String toString() {

         String credentials = '{"name":"6gSVxaYj397","transactionKey":"6FR49pDH5Jjum58g"}';
        // super class
       // String wrapper = '{"deleteCustomerPaymentProfileRequest":{"merchantAuthentication":'+credentials+payload+'}';
    
       return credentials;
    }

    public String getName() {
        return this.name;
    }

    public String getTransactionKey() {
        return this.transactionKey;
    }
}