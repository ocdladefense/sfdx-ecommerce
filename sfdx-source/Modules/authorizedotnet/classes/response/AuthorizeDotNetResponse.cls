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
    // public override void setBody(String body) {
    //     this.body = body;
    // }


    public virtual void deserialize() {

        System.debug('deserialize in auth response class');
        
        //when body is set through constructor this works, but messages contents are null when body is set using setter
        //that may not be true - this code is not deserializing correctly at all
        //all calls are entering the if code block

        Messages m = (Messages)JSON.deserialize(this.getBody(), Messages.class);
        this.messages = m;
        System.debug('messages before null check is '+ this.messages);

        //check if contents of resultCode is null
        //this way works when body is set manually through setter
        if(this.messages.getResultCode()==null){
            AuthorizeDotNetResponse resp = (AuthorizeDotNetResponse)JSON.deserialize(this.getBody(), AuthorizeDotNetResponse.class);
            this.messages = resp.getMessages();
            System.debug('messages set after null check');
            System.debug('messages getter is ' + this.getMessages());
            
        }

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

    //generic ways to access a value that is at the same level as messages

    public String getStringValue(String key){
        Map<String, Object> theMap = (Map<String, Object>)JSON.deserializeUntyped(this.getBody());
        String value = (String)theMap.get(key);
        return value;
    }

    public Boolean getBooleanValue(String key){
        Map<String, Object> theMap = (Map<String, Object>)JSON.deserializeUntyped(this.getBody());
        Boolean value = (Boolean)theMap.get(key);
        return value;
    }


    public static AuthorizeDotNetResponse newFromRequestType(String requestType) {

        String typeName = requestType + 'Response'; // e.g., CreateCustomerPaymentProfileResponse
        // String respMockName = req.requestType + 'MockResponse'; //e.g., CreateCustomerPaymentProfileMockResponse
        System.Type t = Type.forName(typeName);
        System.debug('the type is '+ typeName);
        return (AuthorizeDotNetResponse)t.newInstance();
    }

    

}