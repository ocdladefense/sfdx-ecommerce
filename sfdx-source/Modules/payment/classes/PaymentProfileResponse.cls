public with sharing class PaymentProfileResponse {
    //PaymentProfileResponse wraps PaymentProfileMessage 

    private PaymentProfileMessage messages;

    public PaymentProfileResponse(){}
    
    public PaymentProfileResponse(PaymentGatewayRequestType msg){
        this.messages=msg;
    }

    public PaymentProfileResponse (String jsonString) {
        Map <String, PaymentProfileMessage> msg = (Map <String, PaymentProfileMessage>)JSON.deserializeStrict(jsonString,  Map <String, PaymentProfileMessage>.class);
        if(msg.get('messages')!=null){
            this.messages=msg.get('messages');
        }
    }

    public PaymentProfileMessage getMessages(){
        return this.messages;
    }
    
    public String getResultCode(){
        return this.messages.getResultCode();
    }

    /* 
    //final code snippet that works when run anonymously
    String jsonString = '{"messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}';
    //payment profile response = what needs to be deserialized
    PaymentProfileResponse resp = new PaymentProfileResponse(jsonString);
    PaymentProfileMessage innerMsg = resp.getmessages();
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