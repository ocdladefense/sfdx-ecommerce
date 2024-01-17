public class GetCustomerProfileResponse extends AuthorizeDotNetResponse {
    
    public CustomerProfile profile;
  



    public GetCustomerProfileResponse() {
        super();
    }


    public GetCustomerProfileResponse(String theBody) {
        super(theBody);
    }


    public CustomerProfile getProfile(){
        return this.profile;
    }


    public void setCustomerProfile(CustomerProfile profile){
        this.profile = profile;
    }


}