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
        Map<String,Object> obj = this.getBodyAsNativeObject();
        return JSON.serialize(obj, true);
    }

    //obje will be the merch auth
    // operating on nativeObject
    public void prepend(Map<String, Object> obj){
        Map<String, Object> out = new Map<String, Object>();

        out.put('merchantAuthentication', obj);

        out.putAll(this.nativeObject);

        
        this.nativeObject = out;
    }

    // operating on native nativeObject
    public void wrap(String reqType) {
        Map<String, Object> out = new Map<String, Object>();

        out.put(reqType, this.nativeObject);
        this.nativeObject = out;

    }

    public virtual Map<String,Object> getBodyAsNativeObject() {
        return this.nativeObject;
    }

}