public virtual class AuthorizeDotNetResponse extends HttpResponseMessage{    

    protected Messages messages;

    public final static String RESPONSE_SUCCESS = 'Ok';

    public final static String RESPONSE_FAILURE = 'Error';




    public AuthorizeDotNetResponse() {}


    public AuthorizeDotNetResponse(String theBody) {
        this.body = theBody;
    }


    public virtual override String getBody() {
        return this.body;
    }


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


    public Messages getMessages() {
        return this.messages;
    }


    public void setMessages(Messages messages) {
        this.messages = messages;
    }


    public Boolean success() {
        return this.messages.getResultCode() == AuthorizeDotNetResponse.RESPONSE_SUCCESS;
    }


    public String getStringValue(String key) {
        Map<String, Object> theMap = (Map<String, Object>)JSON.deserializeUntyped(this.getBody());
        String value = (String)theMap.get(key);

        return value;
    }
       

}