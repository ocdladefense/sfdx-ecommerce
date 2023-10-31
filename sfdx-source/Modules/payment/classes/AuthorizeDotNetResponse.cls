public virtual class AuthorizeDotNetResponse extends HttpResponseMessage{    

//public with sharing class AuthorizeDotNetResponse extends HttpResponseMessage{    
    private String resultCode;

    private List <Map<String, Object>> messages = New List <Map<String, Object>>();

    public AuthorizeDotNetResponse() {
    }

    public AuthorizeDotNetResponse(String theBody) {
        this.body = theBody;
        //could we call deserialize here? the string always needs to be in a more readable format
        //this.deserialize();
    }

    public override String getBody(){
        //return this.deserialize();
        return this.body;
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
        Map<String, Object> message = (Map<String, Object>)messages[0];
        //messageItem = {"code":"I00001","text":"Successful."}
        String text = (String)message.get('text');
        //text = 'Successful'
        String code = (String)message.get('code');

        this.resultCode=resultCode;
        this.messages.add(message);
        
        
    }

    public Map<String, String> getMessage(){
        return (Map<String, String>)messages[0];
    }

    public String getText (){
        return (String)messages[0].get('text');
    }

    public String getCode (){
        return (String)messages[0].get('code');
    }

    public String getResultCode (){
        return resultCode;
    }
}