public virtual class AuthorizeDotNetRequest extends HttpRequestMessage {

    protected String requestType;
    
    public AuthorizeDotNetRequest() {
        this.setMethod('POST');
        this.setEndpoint('http://fubar');
        this.headers.put('X-Request-Type',this.requestType);
    }

    public String getRequestType() {
        return this.requestType;
    }
}