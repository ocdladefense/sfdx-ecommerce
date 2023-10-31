public virtual class HttpClient {

    public final Map<String,String> endpoints;

    protected Map<String,String> headers = new Map<String,String>();


    public HttpClient() {

    }

    public HttpResponseMessage send(HttpRequestMessage r) {

        Http client = new Http();
        HttpRequest req = r.getAsHttpRequest();

        HttpResponse resp = client.send(req);
  
        return new HttpResponseMessage(resp);
    }

    public String getEndpoint(String key) {
        return endpoints.get(key);
    }

    public void addHeader(String key, String value) {
        this.headers.put(key,value);
    }
}