public virtual class AuthorizeDotNetRequest extends HttpRequestMessage {

    protected String requestType;

    protected Map<String, Object> nativeObject;
    //set the properties on this

    //this is needed to preserve changes after calling prepend and wrap
    protected Map<String, Object> nativeobjectForResponse;
    
    protected Map<String,String> params;
    
    public AuthorizeDotNetRequest() {
        this.headers.put('X-Request-Type',this.requestType);
        this.nativeobjectForResponse = this.getBodyAsNativeObject();
        //system.debug('--in constructor nofr is '+this.nativeobjectForResponse);
    }

    public String getRequestType() {
        return this.requestType;
    }


    public override String getBody(){
        Map<String,Object> obj = this.getBodyAsNativeObjectForResponse();
        //System.debug(JSON.serialize(obj, true));
        return JSON.serialize(obj, true);
    }


    //obj will be the merch auth
    // operating on non-virtual nativeObjectForResponse
    public void prependBody(String key, Map<String, Object> obj) {

        if(null == this.nativeObject) {
            this.nativeObject = this.getBodyAsNativeObject();
            this.nativeobjectForResponse = this.getBodyAsNativeObject();
        }
        
        Map<String, Object> out = new Map<String, Object>();

        out.put(key, obj);
        //system.debug('----out is '+ out);
        out.putAll(this.nativeobjectForResponse);
        //system.debug('----out is '+ out);
        this.nativeobjectForResponse=out;
        //system.debug('----after prepend nofr is  '+ this.getBodyAsNativeObjectForResponse());

    }

    // operating on native nativeObject
    public void wrapBody(String reqType) {

        if(null == this.nativeObject) {
            this.nativeObject = this.getBodyAsNativeObject();
            this.nativeobjectForResponse = this.getBodyAsNativeObject();

        }

        Map<String, Object> out = new Map<String, Object>();

        out.put(reqType, this.nativeobjectForResponse);
        this.nativeobjectForResponse = out;
        //system.debug('---- after wrap nofr is '+ this.getBodyAsNativeObjectForResponse());

        //this.setBodyAsNativeObject(this.getBodyAsNativeObjectForResponse());
        //system.debug('----native object with setter is '+ this.getBodyAsNativeObject()); 


    }

    public virtual Map<String,Object> getBodyAsNativeObject() {
        return this.nativeObject;
    }

    public Map<String,Object> getBodyAsNativeObjectForResponse() {
        return this.nativeobjectForResponse;
    }

    public virtual void setBodyAsNativeObject(Map<String,Object> obj) {
      this.nativeObject=obj;
    }
    //testing - got error void addParams(String, String) from the type AuthorizeDotNetRequest
    public override void addParam(String key, String value) {
        this.params.put(key,value);
    }



}