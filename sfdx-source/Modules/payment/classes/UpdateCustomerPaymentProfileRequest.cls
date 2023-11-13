public class UpdateCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    private String customerProfileId;
    public CustomerPaymentProfile paymentProfile;
    public String validationMode;
    // Default profile id for our testing
    public String DEFAULT_PROFILE_ID = '905372692';

    public UpdateCustomerPaymentProfileRequest() {
        // testMode: Card data is validated using simple mathematical checks to confirm that it appears to be valid
        this.validationMode = 'testMode';
    }
    // Might only need this constructor since billTo and payment are both in here
    public UpdateCustomerPaymentProfileRequest(CustomerPaymentProfile profile) {
        this();
        this.customerProfileId = DEFAULT_PROFILE_ID;
        this.paymentProfile = profile;
    }
    // Overloaded constructor for if only the Address is changed
    public UpdateCustomerPaymentProfileRequest(CustomerPaymentProfile profile, Address newAddress) {
        this();
        this.customerProfileId = DEFAULT_PROFILE_ID;
        this.paymentProfile = profile;
        this.paymentProfile.setBillTo(newAddress);
    }
    // Overloaded constructor for if only the CreditCard is changed
    public UpdateCustomerPaymentProfileRequest(CustomerPaymentProfile profile, CreditCard newCard) {
        this();
        this.customerProfileId = DEFAULT_PROFILE_ID;
        this.paymentProfile = profile;
        this.paymentProfile.setCard(newCard);
    }

    // Overloaded constructor for if both Address and CreditCard are changed
    public UpdateCustomerPaymentProfileRequest(CustomerPaymentProfile profile, Address newAddress, CreditCard newCard) {
        this();
        this.customerProfileId = DEFAULT_PROFILE_ID;
        this.paymentProfile = profile;
        this.paymentProfile.setBillTo(newAddress);
        this.paymentProfile.setCard(newCard);
    }

    
    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }

    /*
    public override String getBody() {
        // body for request, look below method
        return '{"customerProfileId": "10000",' +
            '"paymentProfile": {' +
                '"billTo": {' +
                    '"firstName": "John",' +
                    '"lastName": "Doe",' +
                    '"company": "",' +
                    '"address": "123 Main St.",' +
                    '"city": "Bellevue",' + 
                    '"state": "WA",' +
                    '"zip": "98004",' +
                    '"country": "US",' +
                    '"phoneNumber": "000-000-0000",' +
                    '"faxNumber": ""' +
                '},' +
                '"payment": {' +
                    '"creditCard": {' +
                        '"cardNumber": "' + this.profile.getCard().getCardNumber() +'",' +
                        '"expirationDate": "2026-01"' +
                    '}' +
                '},' +
                '"defaultPaymentProfile": false,' +
                '"customerPaymentProfileId": "20000"' +
            '}';
    }
    */

    /* -- Update request for body --
        "customerProfileId": "10000",
        "paymentProfile": {
            "billTo": {
                "firstName": "John",
                "lastName": "Doe",
                "company": "",
                "address": "123 Main St.",
                "city": "Bellevue",
                "state": "WA",
                "zip": "98004",
                "country": "US",
                "phoneNumber": "000-000-0000",
                "faxNumber": ""
            },
            "payment": {
                "creditCard": {
                    "cardNumber": "4111111111111111",
                    "expirationDate": "2026-01"
                }
            },
            "defaultPaymentProfile": false,
            "customerPaymentProfileId": "20000"
    */
}