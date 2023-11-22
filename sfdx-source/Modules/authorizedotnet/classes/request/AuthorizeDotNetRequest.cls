public virtual class AuthorizeDotNetRequest extends HttpRequestMessage implements IOrderedMap {



    public Credentials merchantAuthentication = new Credentials('6gSVxaYj397','6FR49pDH5Jjum58g');

    protected String requestType;

    protected Map<String,Object> props = new Map<String,Object>();

    protected Set<String> fields = new Set<String>(); 

    protected Set<String> ignoredFields = new Set<String>();

    // protected AuthorizeDotNetType props = new AuthorizeDotNetType();

    public void put(String key, Object value) {
        this.props.put(key,value);
        this.fields.add(key);
    }

    public Object get(String key) {
        return this.props.get(key);
    }
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
   

        payload.writeObjectFields(this);
        



        payload.writeEndObject();
        payload.writeEndObject();

        return payload.getAsString();
    }



    public virtual Set<String> keySet() {
        return this.fields;
    }

    // For use with IOrderedMap.
    public virtual Map<String,Object> toMap() {
        if(this.props.values().size() > 0) {
            return this.props;
        }

        // This is a base implementation and *should be overridden.
        // It that can only be used
        // if the requests members are primitive types.
        // Deserializing eliminates types like Address, Payment, CreditCard, CustomerPaymentProfile, etc.
        String theJson = JSON.serialize(this);
        return (Map<String,Object>)JSON.deserializeUntyped(theJson);
    }

    public void addField(String field) {
        this.fields.add(field);
    }

    public void setFields(Set<String> fields) {
        this.fields = fields;
    }


    public Set<String> getIgnoredFields() {
        return this.ignoredFields;
    }

    public void ignoreField(String fieldName) {
        if(this.ignoredFields == null) {
            this.ignoredFields = new Set<String>();
        }

        this.ignoredFields.add(fieldName);
    }



}