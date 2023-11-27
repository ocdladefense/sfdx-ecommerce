public class Address extends AuthorizeDotNetType {
    private String customerAddressId;
    
    public String firstName {get; set;}

    public String lastName {get; set;}

    public string company {get; set;}

    public String address {get; set;}

    public String city {get; set;}

    public String state {get; set;}

    public String zip {get; set;}

    public String country {get; set;}

    private String phoneNumber {get; set;}

    private String faxNumber {get; set;}

    public String email {get; set;}
    
    public Boolean defaultShippingAddress {get; set;}
    
    private static final String DEFAULT_COUNTRY_CODE = 'US';

    

    



    // Constructors-----------------
    public Address (){}

    public Address(String firstName, String lastName, String address, String city, String state, String zip) {
        this(firstName, lastName, address, city, state, zip, DEFAULT_COUNTRY_CODE);
    }

    public Address(String firstName, String lastName, String address, String city, String state, String zip, String country) {
        
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.city = city;
        this.state = state;
        this.zip = zip;
        this.country = country;
        
    }
  
    
    
    public override String getPrimaryKeyField() {
        return 'customerAddressId';
    }

    public override String getPrimaryKeyValue() {
        return this.customerAddressId;
    }

    public override Set<String> keySet() {
        return new Set<String> {
            'firstName', 'lastName', 'company', 'address', 'city','state','zip','country','phoneNumber','faxNumber','email', 'customerAddressId'
        };
    }
    
    public Boolean isDefault() {
        return null != this.defaultShippingAddress && this.defaultShippingAddress == True;
    }

    // Static Methods------------------------------

    

    // Getters------------------
    public String getCustomerAddressId() {
        return customerAddressId;
    }
    
    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getCompany() {
        return company;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public String getfaxNumber() {
        return faxNumber;
    }

    public String getEmail() {
        return email;
    }

    public String getAddress() {
        return address;
    }

    public String getCity() {
        return city;
    }

    public String getState() {
        return state;
    }

    public String getZip() {
        return zip;
    }

    public String getCountry() {
        return country;
    }
  

    // Setters------------------------
    public void setCustomerAddressId(string customerAddressId){
        this.customerAddressId = customerAddressId;
    }
    
    public void setPhoneNumber(string phoneNumber){
        this.phoneNumber = phoneNumber;
    }
    public void setfaxNumber(string faxNumber){
        this.faxNumber = faxNumber;
    }
    public void setEmail (string email) {
        this.email = email;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setAddress (string address){
        this.address = address;
    }

    public void setCity (string city){
        this.city = city;
    }

    public void setState (string state){
        this.state = state;
    }

    public void setZip (string zip){
        this.zip = zip;
    }

    public void setCountry (string country){
        this.country = country;
    }

    public void setCompany (string company){
        this.company = company;
    }

    public override String toString() {
        return firstName + ' ' + lastName + ', ' + address;
    }
    
}