public virtual class AuthorizeDotNetRequest extends HttpRequestMessage {



    public Credentials merchantAuthentication = new Credentials('6gSVxaYj397','6FR49pDH5Jjum58g');

    protected String requestType;

    public AuthorizeDotNetRequest(){
        super();
        this.method = null;
         this.headers = null;
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




    public System.JSONGenerator getJsonGenerator() {

        // this will handle the creation fo the requestType.
        // AND will handle the creation fo the merchantAuthentication

        // then it can return to the sub-class for the subclass to finish 
       JSONGenerator gen = JSON.createGenerator(true);

        gen.writeStartObject();
        gen.writeFieldName(this.requestType.uncapitalize()+'Request');
        gen.writeStartObject();
        gen.writeFieldName('merchantAuthentication');
        gen.writeStartObject();
        gen.writeStringField('name', this.merchantAuthentication.getName());
        gen.writeStringField('transactionKey', this.merchantAuthentication.getTransactionKey());
        gen.writeEndObject();
        // gen.writeEndObject();
        // gen.writeEndObject();

        return gen;
    }


    public virtual override String getBody() {
        JSONGenerator gen = this.getJsonGenerator();
        gen.writeEndObject();

        return gen.getAsString();
    }




}