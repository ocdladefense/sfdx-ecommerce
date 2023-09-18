public class HttpRequestMessage extends HttpMessage {

    private String endpoint;

    private String method;

    private Map<String,String> params;


    public HttpRequestMessage() {
        super();
    }

    public String getEndpoint() {
        return this.endpoint + (this.params != null ? this.getParamsAsQueryString() : '');
    }

    public void setEndpoint(String endpoint) {
        this.endpoint = endpoint;
    }

    public void setMethod(String httpVerb) {
        this.method = httpVerb;
    }

    public void addParam(String key) {
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
        req.setBody(this.body);
        req.setEndpoint(this.endpoint);
        
        for(String key : this.headers.keySet()) {
            req.setHeader(key, this.headers.get(key));
        }

        return req;
    }




}