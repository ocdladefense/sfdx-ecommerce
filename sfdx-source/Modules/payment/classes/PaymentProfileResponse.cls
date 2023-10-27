public with sharing class PaymentProfileResponse {
    
    private PaymentProfileMessage innerMessage;


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
    public PaymentProfileResponse(){}

    public PaymentProfileResponse (String jsonString) {
        //Map<String, String> respMap = (Map<String, String>)JSON.deserialize(response, Map<String, String>.class);
        Map <String, PaymentProfileMessage> msg = (Map <String, PaymentProfileMessage>)JSON.deserializeStrict(jsonString,  Map <String, PaymentProfileMessage>.class);
        if(msg.get('messages')!=null){
            this.innerMessage=msg.get('messages');
        }
    }

    public PaymentProfileMessage getInnerMessage(){
        return this.innerMessage;
    }
   

    /* 
    //final code snippet that works
    String jsonString = '{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}';
    //payment profile response = what needs to be deserialized
    PaymentProfileResponse resp = new PaymentProfileResponse(jsonString);
    PaymentProfileMessage innerMsg = resp.getInnerMessage();
    String code = innerMsg.getResultCode();
    system.debug(code);                  
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
    
    */
}