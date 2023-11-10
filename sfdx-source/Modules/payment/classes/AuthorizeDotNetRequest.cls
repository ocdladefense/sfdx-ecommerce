public virtual class AuthorizeDotNetRequest extends HttpRequestMessage {



    // public Credentials merchantAuthentication = new Credentials('6gSVxaYj397','6FR49pDH5Jjum58g');

    public static String requestType;


    /**
     * @constructor Default constructor
     * @description set the method and headers to null so these properties are
     * not serialize as part of the JSON payload.
     */
    public AuthorizeDotNetRequest() {
        super();
       this.method = null;
        this.headers = null;
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
        gen.writeStringField('merchantAuthentication');
        gen.writeStartObject();
        gen.writeStringField('name', variableFromSuperClass);
        gen.writeStringField('transactionKey', variableFromSueprClass);
        gen.writeEndObject();

        return gen;
    }
    public override String getBody() {
        requestType += 'Request';
        String payload = JSON.serialize(this,True);
        //System.debug(merchantAuthentication);
        payload = payload.substring(1, payload.length()-1);

                 String credentials = '{"name":"6gSVxaYj397","transactionKey":"6FR49pDH5Jjum58g"}';
        // super class
        String wrapper = '{"deleteCustomerPaymentProfileRequest":{"merchantAuthentication":'
            +credentials + ','
            +payload+'}}';

        return wrapper;
        // return JSON.serialize(new Map<String,AuthorizeDotNetRequest>{requestType => this}, True);
      
    }




}