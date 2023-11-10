public with sharing class Messages {
    protected String resultCode;
    protected List<Message> message;
    
    public Messages() {

    }

    public virtual void deserialize() {
        // does this need something here?

    }
    public String getResultCode (){
        return resultCode;
    }

    public List<Message> getMessage(){
        return this.message;
    }

    public void setResultCode(String resultCode){
        this.resultCode=resultCode;
    }

    public void setMessage( List<Message> message){
       this.message=message;
    }
}