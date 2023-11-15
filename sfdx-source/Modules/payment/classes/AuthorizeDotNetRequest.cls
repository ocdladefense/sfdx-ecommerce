public virtual class AuthorizeDotNetRequest extends HttpRequestMessage {



    public Credentials merchantAuthentication = new Credentials('6gSVxaYj397','6FR49pDH5Jjum58g');

    protected String requestType;

    protected AuthorizeDotNetType props = new AuthorizeDotNetType();
    /**
     * @constructor Default constructor
     * @description set the method and headers to null so these properties are
     * not serialize as part of the JSON payload.
     */
    public AuthorizeDotNetRequest(String requestType) {
        super();
       this.method = null;
        this.headers = null;
        this.requestType = requestType;
    }



    public String getRequestType() {
        return requestType;
    }



    public virtual override String getBody() {
        JsonPayload payload = new JsonPayload();

        payload.writeStartObject();
        payload.writeFieldName(this.requestType+'Request');
        payload.writeStartObject();
        payload.writeObjectField('merchantAuthentication', this.merchantAuthentication);
   
        for(String prop : this.props.keySet()) {
            Object value = this.props.get(prop);
            if(value instanceOf AuthorizeDotNetType) {
                payload.writeObjectField(prop, (AuthorizeDotNetType)value);
            }
            else {
                payload.writeObjectField(prop, value);
            }
        }

        payload.writeEndObject();
        payload.writeEndObject();

        return payload.getAsString();
    }

    public void setProp(String key, Object value) {
        this.props.put(key, value);
        this.props.addField(key);
    }


}