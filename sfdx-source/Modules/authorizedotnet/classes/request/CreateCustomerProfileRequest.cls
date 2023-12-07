public class CreateCustomerProfileRequest extends AuthorizeDotNetRequest{
    public CustomerProfile profile;

    public List<AuthNetAddress> shipToList;
    
    public String validationMode = 'testMode';

    public CreateCustomerProfileRequest() {
        super('createCustomerProfile');
        this.fields = new Set<String>{'profile', 'shipToList', 'validationMode'};
    }

    public CreateCustomerProfileRequest(CustomerProfile profile) {
        this();
        this.profile= profile;
    }

    //some classses have keyset some don't
    public override Set<String> keySet() {
        return new Set<String>{'profile', 'shipToList','validationMode'};
    }


    public CustomerProfile getCustomerProfile(){
        return this.profile;
    }

    public String getValidationMode(){
        return this.validationMode;
    }

    public List<AuthNetAddress> getShipToList(){
        if(this.shipToList==null){
            this.shipToList = new List<AuthNetAddress>();
        }
        return this.shipToList;
    }

    public void setCustomerProfile(CustomerProfile profile){
        this.profile = profile;
    }

    public void setValidationMode(String validationMode){
        this.validationMode = validationMode;
    }

    public void setShipToList (List<AuthNetAddress> shipToList){
        this.shipToList = shipToList;
    }

    public void addToShipToList (AuthNetAddress address){
        if(this.shipToList ==null){
            this.shipToList = new List<AuthNetAddress>();
        }
        this.shipToList.add(address);
    }

    public override Map<String,Object> toMap() {
        System.debug('CALLING TO MAP on create profile request');
        Map<String,Object> tmp = new Map<String,Object>();
        tmp.put('profile', this.profile);
        if(this.shipToList!= null)
        {
            tmp.put('shipToList', this.shipToList);
        }
        tmp.put('validationMode', this.validationMode);

        return tmp;
    }

}