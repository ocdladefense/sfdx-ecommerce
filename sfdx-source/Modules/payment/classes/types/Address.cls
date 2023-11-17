public virtual class Address extends AuthorizeDotNetType {
    
    
    protected String firstName;

    protected String lastName;

    //company used in shipping address requests
    protected String company;

    protected String address;

    protected String city;

    protected String state;

    protected String zip;

    protected String country;

    protected String phoneNumber;

    protected String faxNumber;

    protected String email;

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
        this.fields = new Set<String> {
            'firstName', 'lastName', 'company','address', 'city','state','zip','country','phoneNumber','faxNumber','email'
        };
    }
  

    // Static Methods------------------------------

    

    // Getters------------------
    
    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
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

    public String getCompany(){
        return company;
    }
    

    // Setters------------------------
    
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

    public void setCompany(String company){
        this.company = company;
    }

    
}