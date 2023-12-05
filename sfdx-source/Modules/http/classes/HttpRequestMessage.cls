
public virtual class HttpRequestMessage extends HttpMessage {

    protected String endpoint;

    protected String method = 'GET';

    protected Map<String,String> params;


    public HttpRequestMessage() {
        super();
        params = new Map<String,String>();
    }

    public void setBody(Map<String,String> body) {
        String contentType = this.headers.get('Content-Type');
        
        if(null == contentType || contentType == 'application/json') {
            this.body = JSON.serialize(body);
        }
        else if('application/x-www-form-urlencoded' == contentType) {

            this.body = HttpUrl.encodeParams(body);
        }
        else throw new HttpException('PARSE_ERROR: Cannot convert body to the specified content-type.');
    }


    public virtual String getEndpoint() {
        return this.endpoint + (this.params != null ? this.getParamsAsQueryString() : '');
    }

    public virtual void setEndpoint(String endpoint) {
        this.endpoint = endpoint;
    }

    public virtual void setMethod(String httpVerb) {
        this.method = httpVerb;
    }

    public virtual void addParam(String key) {
        this.addParam(key, null);
    }

    public virtual void addParam(String key, String value) {
        this.params.put(key,value);
    }

    public Map<String,String> getParams() {
        return this.params;
    } 

    public String getParamsAsQueryString() {
        String result = '';

        for(String key : this.params.keySet()) {
            String value = this.params.get(key);
            String[] parts = new String[]{key,this.params.get(key)};
            
            result += value == null ? key : String.join(parts,'&');
        }

        return result;
    }


    public HttpRequest getAsHttpRequest() {
        HttpRequest req = new HttpRequest();
        req.setMethod(this.method);
        

        req.setEndpoint(this.getEndpoint());

        if(this.getMethod() != 'GET') {
       	    req.setBody(this.getBody());
        }
        
        for(String key : this.headers.keySet()) {
            req.setHeader(key, this.headers.get(key));
        }

        return req;
    }

    public String getMethod() {
        return this.method;
    }

    //temp
    public void setParams(String key, string value) {
        this.params.put(key,value);
    } 


    public String formatBody(String fieldName,String fieldValue){
        return fieldName+'='+EncodingUtil.urlEncode(fieldValue, 'UTF-8');
    }
    
	// parameter acts like a clone()    
    public String formatBody(Map<String,String> ccVals){
        List<String> postBody = new List<String>();
        
        if(null == ccVals) return null;
        
        for(String key: ccVals.keySet()) {
            if('' == key) continue;
            if(null == ccVals.get(key)) continue;
            postBody.add(key+'='+EncodingUtil.urlEncode(ccVals.get(key), 'UTF-8'));
        }

        return String.join(postBody,'&');                 
    }


}