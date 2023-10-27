public with sharing class AuthorizeDotNetResponse {
    private String body;
    
    private String resultCode;

    private List <Map<String, String>> messages = New List <Map<String, String>>();

    public AuthorizeDotNetResponse(String theJson) {
        this.body = theJson;
    }

    public void deserialize (){
                //'{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}'

        Map<String, Object> body = (Map<String, Object>)JSON.deserializeUntyped(this.body);

        Map<String, Object> soapMessages = ( Map<String, Object>)body.get('messages');
        //soapMessages = {"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}
        String resultCode = (String)soapMessages.get('resultCode');
        //resultCode = "Ok"
        List<Object> messages = ( List<Object>)soapMessages.get('message');
        //messages = [
            // {"code":"I00001","text":"Successful."}
            //]
        Map<String, String> message = (Map<String, String>)messages[0];
        //messageItem = {"code":"I00001","text":"Successful."}
        String text = message.get('text');
        //text = 'Successful'
        String code = message.get('code');

        this.resultCode=resultCode;
        this.messages.add(message);
        
        
    }

    public Map<String, String> getMessage(){
        return messages[0];
    }

    public String getText (){
        return messages[0].get('text');
    }

    public String getCode (){
        return messages[0].get('code');
    }

    public String getResultCode (){
        return resultCode;
    }
}