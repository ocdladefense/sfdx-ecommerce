public class Message extends AuthorizeDotNetType{

    protected String code;

    protected String text;


    public Message() {
        this.fields = new Set<String> {
            'code', 'text'
        };
    }


    public String getCode (){
        return this.code;
    }

    public String getText (){
        return this.text;
    }

    public void setCode(String code){
        this.code = code;
    }

    public void setText(String text){
        this.text = text;
    }

}