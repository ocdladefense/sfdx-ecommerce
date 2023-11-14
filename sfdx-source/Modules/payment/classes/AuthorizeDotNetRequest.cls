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
        

        // Continue processing the JSON for the request.
        //payload.writeStringField('customerProfileId', this.customerProfileId);

        //payload.writeObjectField('address', this.address);
        for(String prop : this.props.getOrderedFieldList()) {
            Object value = this.props.get(prop);
            if(value instanceOf AuthorizeDotNetType) {
                payload.writeObjectField(prop, (AuthorizeDotNetType)value);
            }
            else {
                payload.writeObjectField(prop, value);

            }
        }
        //payload.writeBooleanField('defaultShippingAddress', getDefaultShippingAddress());
        payload.writeEndObject();
        payload.writeEndObject();
        // Use the generator to create one or more objects for the payload json,
        // *in the exact order as required by the Authorize.net documentation.
        return payload.getAsString();
    }

    public void setProp(String key, Object value) {
        this.props.setProp(key, value);
        this.props.addField(key);
    }


}