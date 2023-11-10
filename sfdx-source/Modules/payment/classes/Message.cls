public class Message {

    protected String text;
    protected String code;

    public Message() {

    }

    public virtual void deserialize() {
        // does this need something here?

    }

    public String getText (){
        return this.text;
    }

    public String getCode (){
        return this.code;
    }

    public void setCode(String code){
        this.code = code;
    }

    public void setText(String text){
        this.text = text;
    }

}