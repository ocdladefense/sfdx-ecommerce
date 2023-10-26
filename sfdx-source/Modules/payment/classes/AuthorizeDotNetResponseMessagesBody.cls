public with sharing class AuthorizeDotNetResponseMessagesBody {
    private String resultCode;

    private List <Map<String, String>> message;
    
    public AuthorizeDotNetResponseMessagesBody() {
    }

    public String getResultCode(){
        return this.resultCode;
    }

    public List<Map <String, String>> getMessage (){
        return this.message;
    }

    public void setResultCode(String resultCode){
        this.resultCode = resultCode;

    }

    public void setMessage (List<Map<String, String>> message){
        this.message = message;
    }
}