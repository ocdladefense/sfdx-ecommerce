public class ShippingAddress extends Address{

    private String customerAddressId;

    //this is first in address fields for GetCustomerShippingAddressResponse
    //this last in address fields for UpdateCustomerShippingAddressRequest

    public ShippingAddress() {
        super();
    }

    public ShippingAddress (Address address, String requestType){
        this.firstName = address.getFirstName();
        this.lastName = address.getLastName();
        this.address = address.getAddress();
        this.city = address.getCity();
        this.state = address.getState();
        this.zip = address.getZip();
        this.country = address.getCountry();
        this.company = address.getCompany();
        this.phoneNumber= address.getPhoneNumber();
        this.faxNumber = address.getfaxNumber();
        this.email = address.getEmail();

        if(requestType == 'getCustomerShippingAddress'){
            this.setGetResponseFields();
        }
        else if(requestType == 'updateCustomerShippingAddress' ){
            this.setUpdateRequestFields();
        }
        else{
            //same as in address constructor
            this.fields = new Set<String> {
                'firstName', 'lastName', 'company','address', 'city','state','zip','country','phoneNumber','faxNumber','email'
            };
        }
    }

    public ShippingAddress(String firstName, String lastName, String address, String city, String state, String zip){
        super(firstName, lastName, address, city, state, zip);
    }

    public ShippingAddress(String firstName, String lastName, String address, String city, String state, String zip, String country){
        super(firstName, lastName, address, city, state, zip, country);
    }

    public void setUpdateRequestFields(){
        this.fields = new Set<String> {
            'firstName', 'lastName', 'company','address', 'city','state','zip','country','phoneNumber','faxNumber','email', 'customerAddressId'
        };
    }

    public void setGetResponseFields(){
        this.fields = new Set<String> {
            'customerAddressId','firstName', 'lastName', 'company','address', 'city','state','zip','country','phoneNumber','faxNumber','email'
        };
    }

    public String getCustomerAddressId(){
        return this.customerAddressId;
    }

    public void setCustomerAddressId(String customerAddressId){
        this.customerAddressId = customerAddressId;
    }
}