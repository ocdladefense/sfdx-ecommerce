public with sharing class CreateCustomerProfileResponse extends AuthorizeDotNetResponse{
    private String customerProfileId;
    
    public CreateCustomerProfileResponse() {
        super();
    }

    public CreateCustomerProfileResponse(String theBody) {
        super(theBody);
    }

    public String getCustomerProfileId(){
        return this.customerProfileId;
    }
    
}