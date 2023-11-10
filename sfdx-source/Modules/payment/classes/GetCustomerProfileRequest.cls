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

    }
    public override Map<String,Object> getBodyAsNativeObject(){
        Map<String,Object> obj = new Map<String,Object>();

        obj.put('customerProfileId', this.customerProfileId);
        obj.put('includeIssuerInfo', this.includeIssuerInfo);
        return obj;
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
}