public class GetCustomerProfileRequest extends AuthorizeDotNetRequest {
    //this makes a request to retrieve all the saved payment profiles for a customer
    private String customerProfileId;
    private Boolean unmaskExpirationDate = true;
  

    public GetCustomerProfileRequest() {
        super('getCustomerProfile');
        this.fields = new Set<String>{
            'customerProfileId', 'unmaskExpirationDate'
        };
    }
    public GetCustomerProfileRequest(String customerProfileId){
        this();
        this.customerProfileId=customerProfileId;
    }


    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }
    public String getCustomerProfileId() {
        return this.customerProfileId;
    }

    public Boolean getUnmaskExpirationDate(){
        return this.unmaskExpirationDate;
    }

    public void setUnmaskExpirationDate(Boolean unmaskExpirationDate){
        this.unmaskExpirationDate=unmaskExpirationDate;
    }
}