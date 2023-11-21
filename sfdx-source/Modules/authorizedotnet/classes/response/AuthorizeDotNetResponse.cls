public virtual class AuthorizeDotNetResponse extends HttpResponseMessage{    

    protected Messages messages;

    public final static String RESPONSE_SUCCESS = 'Ok';

    public final static String RESPONSE_FAILURE = 'Error';


    public AuthorizeDotNetResponse() {
    }

    public AuthorizeDotNetResponse(String theBody) {
        this.body = theBody;
        //could we call deserialize here? the string always needs to be in a more readable format
        //this.deserialize();
    }

    public virtual override String getBody(){
        //return this.deserialize();
        return this.body;
    }

    /*
    public virtual void deserialize (){
                //'{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}'
                //in sandbox testing has questionmark symbol before{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}

    
        Map<String, Object> bodyMap = (Map<String, Object>)JSON.deserializeUntyped(this.body);

        Map<String, Object> soapMessages = ( Map<String, Object>)bodyMap.get('messages');
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

        this.temp = bodyMap;
        this.resultCode=resultCode;
        this.messages.add(message);
    }

    public Map<String, String> getMessage(){
        return (Map<String, String>)messages[0];
    }


    */

    //-------------Testing new methods

    public virtual void deserialize() {
        // Deserialize the JSON string into a Map with String keys and Object values
      
        this.messages = (Messages)JSON.deserialize(this.getBody(), Messages.class);
        System.debug('in authresp proper ' + this.messages);
    }

    public Messages getMessages(){
        return this.messages;
    }

    public void setMessages(Messages messages){
        this.messages = messages;
    }

    //-------------End new metho                                                    ds


    public Boolean success(){
        return this.messages.getResultCode() == AuthorizeDotNetResponse.RESPONSE_SUCCESS;
    }


    public static AuthorizeDotNetResponse newFromRequestType(String requestType) {

        String typeName = requestType + 'Response'; // e.g., CreateCustomerPaymentProfileResponse
        // String respMockName = req.requestType + 'MockResponse'; //e.g., CreateCustomerPaymentProfileMockResponse
        System.Type t = Type.forName(typeName);
        System.debug('the type is '+ typeName);
        return (AuthorizeDotNetResponse)t.newInstance();
    }

}