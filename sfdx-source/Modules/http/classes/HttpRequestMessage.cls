public virtual class HttpRequestMessage extends HttpMessage {

    protected String endpoint;

    protected String method;

    protected Map<String,String> params;


    public HttpRequestMessage() {
        super();
    }

    public void setBody(Map<String,String> body) {
        String contentType = this.headers.get('Content-Type');
        
        if(null == contentType || contentType == 'application/javascript') {
            this.body = JSON.serialize(body);
        }
        else if('application/x-www-form-urlencoded' == contentType) {

            this.body = Url.encodeParams(body);
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

    public void addParam(String key, String value) {
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
        
        if(null != this.endpoint) {
            req.setEndpoint(this.endpoint);
        }

        req.setBody(this.body);

        for(String key : this.headers.keySet()) {
            req.setHeader(key, this.headers.get(key));
        }

        return req;
    }




}