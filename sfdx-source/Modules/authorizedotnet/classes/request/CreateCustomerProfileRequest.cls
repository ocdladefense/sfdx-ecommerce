public class CreateCustomerProfileRequest extends AuthorizeDotNetRequest{
    private CustomerProfile profile;
    private List<Address> shipToList = new List<Address>();
    private String validationMode = 'testMode';

    public CreateCustomerProfileRequest() {
        super('createCustomerProfile');
        this.fields = new Set<String>{'profile', 'shipToList', 'validationMode'};
    }

    public CreateCustomerProfileRequest(CustomerProfile profile) {
        this();
        this.profile= profile;
    }

    public override Set<String> keySet() {
        return new Set<String>{'profile', 'shipToList','validationMode'};
    }

    public override Map<String,Object> toMap() {
        Map<String,Object> tmp = new Map<String,Object>();
        tmp.put('profile', this.profile);
        tmp.put('shipToList', this.shipToList);
        tmp.put('validationMode', this.validationMode);

        return tmp;
    }
    public CustomerProfile getCustomerProfile(){
        return this.profile;
    }

    public String getValidationMode(){
        return this.validationMode;
    }

    public List<Address> getShipToList(){
        return this.shipToList;
    }

    public void setCustomerProfile(CustomerProfile profile){
        this.profile = profile;
    }

    public void setValidationMode(String validationMode){
        this.validationMode = validationMode;
    }

    public void setShipToList (List<Address> shipToList){
        this.shipToList = shipToList;
    }

    public void addToShipToList (Address address){
        this.shipToList.add(address);
    }

}