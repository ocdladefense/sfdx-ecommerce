// https://beyondthecloud.dev/blog/abstract-virtual-interface-in-apex#virtual-method-vs-abstract-method
public virtual with sharing class HttpMessage {

    protected String body;

    protected Map<String,String> headers;


    protected HttpMessage() {
        this.headers = new Map<String,String>();
    }

    public String getHeader(String key) {
        return this.headers.get(key);
    }

    public void setHeader(String key, String value) {
        this.headers.put(key,value);
    }

    public void setBody(String body) {
        this.body = body;
    }

    public String getBody() {
        return this.body;
    }

    public Blob getBodyAsBlob() {
        return Blob.valueOf(this.body);
    }

    public Dom.Document getBodyDocument() {
        Dom.Document doc = new Dom.Document();
        doc.load(this.body);
        
        return doc;
    }



}