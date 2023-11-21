public class GetCustomerProfileRequest extends AuthorizeDotNetRequest {
    //this makes a request to retrieve all the saved payment profiles for a customer
    private String customerProfileId;
    private Boolean includeIssuerInfo = true;
  

    public GetCustomerProfileRequest() {
        super('getCustomerProfile');
        this.fields = new Set<String>{
            'customerProfileId', 'includeIssuerInfo'
        };
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


    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }
    public String getCustomerProfileId() {
        return this.customerProfileId;
    }

    public Boolean getIncludeIssuerInfo(){
        return this.includeIssuerInfo;
    }

    public void setIncludeIssuerInfo(Boolean includeIssuerInfo){
        this.includeIssuerInfo=includeIssuerInfo;
    }

    // public override String getBody() {

    // }
}