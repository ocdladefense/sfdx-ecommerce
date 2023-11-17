public class Messages extends AuthorizeDotNetType{

    protected String resultCode;

    protected List<Message> message;
    
    public Messages() {
        this.fields = new Set<String> {
            'resultCode', 'message'
        };
    }

    public override Map<String,Object> toMap() {
        Map<String,Object> tmp = new Map<String,Object>();
        tmp.put('resultCode', this.resultCode );
        tmp.put('message', this.message);
        return tmp;
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