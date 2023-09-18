public virtual class HttpClient {

    public final Map<String,String> endpoints;


    public HttpClient() {

    }

    public virtual HttpResponse send(HttpRequestMessage req) {

        Http client = new Http();
        
        return client.send(req.getAsHttpRequest());
    }

    public String getEndpoint(String key) {
        return endpoints.get(key);
    }
}