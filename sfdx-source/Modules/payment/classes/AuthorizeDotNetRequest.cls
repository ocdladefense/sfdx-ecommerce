public virtual class AuthorizeDotNetRequest extends HttpRequestMessage {

    protected String requestType;

    protected Map<String, Object> nativeObject;
    //set the properties on this
    
    protected Map<String,String> params;
    
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

    //obj will be the merch auth
    // operating on nativeObject
    public void prependBody(String key, Map<String, Object> obj) {

        if(null == this.nativeObject) {
            this.nativeObject = this.getBodyAsNativeObject();
        }
        
        Map<String, Object> out = new Map<String, Object>();

        out.put(key, obj);
        system.debug('----out is '+ out);
        out.putAll(this.nativeObject);
        system.debug('----out is '+ out);
        
        this.setBodyAsNativeObject(out);
        system.debug('----n-o is '+ this.getBodyAsNativeObject());
    }

    // operating on native nativeObject
    public void wrapBody(String reqType) {

        if(null == this.nativeObject) {
            this.nativeObject = this.getBodyAsNativeObject();
        }

        Map<String, Object> out = new Map<String, Object>();

        out.put(reqType, this.nativeObject);
        this.setBodyAsNativeObject(out);
    }

    public virtual Map<String,Object> getBodyAsNativeObject() {
        return this.nativeObject;
    }

    public virtual void setBodyAsNativeObject(Map<String,Object> obj) {
      this.nativeObject=obj;
    }
    //testing - got error void addParams(String, String) from the type AuthorizeDotNetRequest
    public override void addParam(String key, String value) {
        this.params.put(key,value);
    }

}