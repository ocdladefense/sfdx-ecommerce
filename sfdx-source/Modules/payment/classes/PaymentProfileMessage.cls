public with sharing class PaymentProfileMessage {
    private String resultCode;

    private List <Map<String, String>> message;

    public PaymentProfileMessage() {

    }

    public String getResultCode(){
        return this.resultCode;
    }

    public List<Map<String,String>> getMessage(){
        return this.message;
    }
}