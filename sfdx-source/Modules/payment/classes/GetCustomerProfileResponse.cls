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
        this.profile = (CustomerProfile)JSON.deserialize(this.getBody(), CustomerProfile.class);
    }

    public CustomerProfile getProfile(){
        return this.profile;
    }
}