public virtual class AuthorizeDotNetRequest extends HttpRequestMessage {

    protected String requestType;

    protected Map<String, Object> nativeObject;
    //set the properties on this
    
    public AuthorizeDotNetRequest() {
        this.headers.put('X-Request-Type',this.requestType);
    }

    public String getRequestType() {
        return this.requestType;
    }

    public override String getBody(){
        return JSON.serialize(body, true);
    }

    //obje will be the merch auth
    public void prepend(Map<String, Object> obj){
        Map<String, Object> out = new Map<String, Object>();

        out.put('merchantAuthentication', obj);

        out.putAll(body);

        

    }

}