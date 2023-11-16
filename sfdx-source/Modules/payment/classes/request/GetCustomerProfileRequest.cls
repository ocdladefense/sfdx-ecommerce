public class GetCustomerProfileRequest extends AuthorizeDotNetRequest {
    //this makes a request to retrieve all the saved payment profiles for a customer
    private String customerProfileId;
    private String includeIssuerInfo = 'true';
  

    public GetCustomerProfileRequest() {
        super();
    }
    public GetCustomerProfileRequest(String customerProfileId){
        this();
        this.customerProfileId=customerProfileId;
        this.requestType = 'GetCustomerProfile';
        // Map<String, String> MERCHANT_AUTHENTICATION = new Map<String, String>{ 
        //     'name'=> '6gSVxaYj397',
        //     'transactionKey'=> '6FR49pDH5Jjum58g'
        // };
        // this.prependBody('merchantAuthentication', MERCHANT_AUTHENTICATION);
        // system.debug('after prepend = ' + this.getBodyAsNativeObject());
        // this.wrapBody(this.requestType);
        // system.debug('after wrap = ' + this.getBodyAsNativeObject());
      

    }
    
    //would this be called in any other way?

    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }
    public String getCustomerProfileId() {
        return this.customerProfileId;
    }

    public string getIncludeIssuerInfo(){
        return this.includeIssuerInfo;
    }

    public void setIncludeIssuerInfo(String includeIssuerInfo){
        this.includeIssuerInfo=includeIssuerInfo;
    }

    public override String getBody() {

        
        JSONGenerator gen = super.getJsonGenerator();

        // Continue processing the JSON for the request.
        gen.writeStringField('customerProfileId', this.customerProfileId);
        gen.writeStringField('includeIssuerInfo', this.includeIssuerInfo);
        gen.writeEndObject();
        gen.writeEndObject();
        // Use the generator to create one or more objects for the payload json,
        // *in the exact order as required by the Authorize.net documentation.
        return gen.getAsString();
    }
}