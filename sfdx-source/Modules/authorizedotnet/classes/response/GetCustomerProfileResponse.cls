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
        system.debug('in resp meassages is ' + this.getMessages());
        this.profile = (CustomerProfile)JSON.deserialize(this.getBody(), CustomerProfile.class);
    }

    public CustomerProfile getProfile(){
        return this.profile;
    }

    public void setCustomerProfile(CustomerProfile profile){
        this.profile=profile;
    }
}