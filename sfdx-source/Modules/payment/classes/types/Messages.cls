public class Messages {

    protected String resultCode;

    protected List<Message> message;
    
    public Messages() {

    }

    public String getResultCode (){
        return resultCode;
    }

    public List<Message> getMessage(){
        return this.message;
    }

    public Message getFirstMessage(){
        return this.message[0];
    }

    public void setResultCode(String resultCode){
        this.resultCode=resultCode;
    }

    public void setMessage( List<Message> message){
       this.message=message;
    }
}