public virtual class AuthorizeDotNetResponse extends HttpResponseMessage{    

//public with sharing class AuthorizeDotNetResponse extends HttpResponseMessage{ 
    protected final String RESPONSE_SUCCESS = 'Ok';
    protected final String RESPONSE_FAILURE = 'Error';

    protected Map<String, Object> temp;

    private Map<String, Object> messages = new Map<String, Object>();
    private String resultCode;
    private List<Map<String,String>> message = new List<Map<String,String>>();

    

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

    public String getText (){
        return (String)messages[0].get('text');
    }

    public String getCode (){
        return (String)messages[0].get('code');
    }
    */

    //-------------Testing new methods

    public virtual void deserialize() {
        // Deserialize the JSON string into a Map with String keys and Object values
        Map<String, Object> bodyMap = (Map<String, Object>) JSON.deserializeUntyped(this.body);

        // Retrieve the 'messages' object from the bodyMap
        this.messages = (Map<String, Object>) bodyMap.get('messages');

        // Retrieve the 'resultCode' from the 'messages' map
        this.resultCode = (String) messages.get('resultCode');

        // Retrieve the 'message' list from the 'messages' map
        List<Object> messageList = (List<Object>) messages.get('message');

        // Initialize the message property as a new List<Map<String, String>>
        this.message = new List<Map<String, String>>();

        // Convert each Object in the list to Map<String, String>
        for (Object msgObj : messageList) {
            Map<String, Object> msgMap = (Map<String, Object>) msgObj;

            // Cast each value in msgMap to String
            Map<String, String> stringMsgMap = new Map<String, String>();
            for (String key : msgMap.keySet()) {
                stringMsgMap.put(key, (String)msgMap.get(key));
            }
        this.message.add(stringMsgMap);
        }
    }

    public Map<String, String> getMessage(){
        return (Map<String, String>)message[0];
    }

    public String getText (){
        return (String)message[0].get('text');
    }

    public String getCode (){
        return (String)message[0].get('code');
    }

    //-------------End new methods

    public String getResultCode (){
        return resultCode;
    }

    public Boolean success(){
        return this.getResultCode()==RESPONSE_SUCCESS;
    }


    public static AuthorizeDotNetResponse newFromRequestType(String requestType) {

        String typeName = requestType + 'Response'; // e.g., CreateCustomerPaymentProfileResponse
        // String respMockName = req.requestType + 'MockResponse'; //e.g., CreateCustomerPaymentProfileMockResponse
        System.Type t = Type.forName(typeName);
        System.debug('the type is '+ typeName);
        return (AuthorizeDotNetResponse)t.newInstance();
    }

    public void setIsErrorTest(Boolean isErrorTest){
        this.isErrorTest = isErrorTest;
    }

    public Boolean getIsErrorTest(){
        return this.isErrorTest;
    }

}