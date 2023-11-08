public virtual class AuthorizeDotNetResponse extends HttpResponseMessage{    

//public with sharing class AuthorizeDotNetResponse extends HttpResponseMessage{ 
    protected final String RESPONSE_SUCCESS = 'Ok';
    protected final String RESPONSE_FAILURE = 'Error';

    protected Map<String, Object> temp;

    private String validationDirectResponse;
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
        Map<String, Object> bodyMap = (Map<String, Object>) JSON.deserializeUntyped(this.body);

        this.validationDirectResponse = (String) bodyMap.get('validationDirectResponse');

        this.messages = (Map<String, Object>) bodyMap.get('messages');
        this.resultCode = (String) messages.get('resultCode');

        List<Object> messageList = (List<Object>) messages.get('message');
        this.message = new List<Map<String, String>>();

        for (Object msgObj : messageList) {
            Map<String, Object> msgMap = (Map<String, Object>) msgObj;

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

    public String getValidationDirectResponse() {
        return this.validationDirectResponse;
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
        return (AuthorizeDotNetResponse)t.newInstance();
    }
}