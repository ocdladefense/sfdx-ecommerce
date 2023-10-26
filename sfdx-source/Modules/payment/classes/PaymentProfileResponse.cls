public with sharing class PaymentProfileResponse {
    
    private Map<String, AuthorizeDotNetResponseMessagesBody> messages;

   
    public Map<String,String> body;
    //top level string
	public String messages;

	public String resultCode;
    //key for messageBody
    public List<String> message;

    public Map<String, String> messageBody;
    //or
	public class messageBody {
		String code;
		String text;
	}
	//and
	public messageBody msgBody;

    //strongly typed classes works in anon mode
    //saved untracked file on Mara's local machine
    //copied here as comment so I can access it through the remote repo
    /*
    String jsonString = '{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}';
    public class MessageBody {
		String code;
		String text;
	}
    public class Contents {
        String resultCode;
        public List<MessageBody> message;
    }
    public class Example{
        public Contents messages;
    }
Example ex = (Example)JSON.deserialize(jsonString, Example.class);
*/

/**Untyped version 
 * able to deserialize one level, but get assignment errors trying to parse the next level
//this works
String jsonString2 = '{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}';
Map<String, Object> messages = (Map<String, Object>)JSON.deserializeUntyped(jsonString2);
System.debug(messages);

//this does not
Map<String, Object> messageLvl2= (Map<String, Object>)JSON.deserializeUntyped(messages);
System.debug(messageLvl2);
*/
    
    public PaymentProfileResponse() {

    }
    public PaymentProfileResponse(Map<String,String> body) {
        this.body = body;
    }
    //copied from transaction response class
    public static PaymentProfileResponse newFromResponse(HttpResponse resp) {
        String body = resp.getBody();
        Map<String,String> nbody = (Map<String,String>)JSON.deserialize(body, Map<String,String>.class);
        PaymentProfileResponse nresp = new PaymentProfileResponse(nbody);
        
        return nresp;
    }
   

    


    /**    public static Map<String,Map<String, String>> deletedCardBodyResponse(HttpRequest req) {
        /**   from authorize.net documentation sample resp                                                             
    {
        "messages": {
            "resultCode": "Ok",
            //this will be either "Ok" or "Error"
            "message": [
                {
                    "code": "I00001",
                    //first letter of code is type of response
                    //i is information
                    //e is for error
                    "text": "Successful."
                }
            ]
        }
    }
    //this looks like when run through json.stringify
    String response = '{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}';
    
    //example class version of a json file

    */
}