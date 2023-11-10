// https://beyondthecloud.dev/blog/abstract-virtual-interface-in-apex#virtual-method-vs-abstract-method
@JsonAccess(serializable='never' deserializable='never')
public virtual with sharing class HttpMessage {

    protected String body;

    protected Map<String,String> headers;


    protected HttpMessage() {
        this.headers = new Map<String,String>();
    }

    public virtual String getHeader(String key) {
        return this.headers.get(key);
    }

    public virtual Map<String,String> getHeaders() {
        return this.headers;
    }

    public virtual void setHeader(String key, String value) {
        this.headers.put(key,value);
    }

    public virtual void setBody(String body) {
        this.body = body;
    }
   
    public virtual Object deserializeBody() {
        String contentType = this.headers.get('Content-Type');

        String[] textContentTypes = new String[]{
            null, 'text/plain','text/javascript','text/css','text/html'
        };
        if(textContentTypes.contains(contentType)) {
            return this.body;
        }

        if('application/x-www-form-urlencoded' == contentType) {
            return '';// need to parse the body and return a Map.
        }

        if('application/json' == contentType) {
            return JSON.deserialize(this.body, Map<String,String>.class);
        }
        
        return this.body;
    }

    public virtual void serializeBody(String body) {

        this.body = body;
    }

    public virtual String getBody() {
        return this.body;
    }

    public virtual Blob getBodyAsBlob() {
        return Blob.valueOf(this.body);
    }

    public virtual Map<String,String> getBodyAsMap() {
        return (Map<String,String>)JSON.deserialize(this.body, Map<String,String>.class);
    }

    public virtual Dom.Document getBodyDocument() {
        Dom.Document doc = new Dom.Document();
        doc.load(this.body);
        
        return doc;
    }



}