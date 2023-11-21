public class GetCustomerProfileResponse extends AuthorizeDotNetResponse 
 {
    public CustomerProfile profile;
  

    public GetCustomerProfileResponse() {
        super();
    }
    public GetCustomerProfileResponse(String theBody) {
        super(theBody);
    }

    public override void deserialize(){
        super.deserialize();
       GetCustomerProfileResponse tempResp =  (GetCustomerProfileResponse)JSON.deserialize(this.getBody(), GetCustomerProfileResponse.class);
       this.profile = tempResp.getProfile();
    
       
    }

    public CustomerProfile getProfile(){
        return this.profile;
    }

    public void setCustomerProfile(CustomerProfile profile){
        this.profile=profile;
    }


}