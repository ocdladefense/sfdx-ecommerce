public with sharing class QuickBooksClient extends HttpClient {



    Map<String,String> clientIds = new Map<String,String>{
        'org.ocdla-dev.sync.quickbooks' => 'ABmhzVOY4yX8b0GP4XiQHi6uApU2GSaLKqwnpH8lTUhUmDXdw7'
    };


    Map<String,String> clientSecrets = new Map<String,String>{
        'org.ocdla-dev.sync.quickbooks' => 'IAavioKHTFwLc9TxUsVChH14kJyiDdlnwCtgt6Su'
    };


    public QuickBooksClient() {

    }


    public String getClientId(String clientName) {
        clientName = 'org.ocdla-dv.sync.quickbooks';

        return this.clientIds.get(clientName);

    }


    public String getClientSecret(String clientName) {
clientName = 'org.ocdla-dv.sync.quickbooks';

        return this.clientSecrets.get(clientName);
    }
}