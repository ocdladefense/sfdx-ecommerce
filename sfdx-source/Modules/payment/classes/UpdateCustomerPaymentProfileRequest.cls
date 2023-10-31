public class UpdateCustomerPaymentProfileRequest extends HttpRequestMessage {
    public CustomerPaymentProfile profile;
    public Address address;
    public CreditCard card;

    public UpdateCustomerPaymentProfileRequest(CustomerPaymentProfile profile) {
        this.profile = profile;
    }
    // Overloaded constructor for if only the Address is changed
    public UpdateCustomerPaymentProfileRequest(CustomerPaymentProfile profile, Address newAddress) {
        this.profile = profile;
        this.address = newAddress;
    }
    // Overloaded constructor for if only the CreditCard is changed
    public UpdateCustomerPaymentProfileRequest(CustomerPaymentProfile profile, CreditCard newCard) {
        this.profile = profile;
        this.card = newCard;
    }

    // Overloaded constructor for if both Address and CreditCard are changed
    public UpdateCustomerPaymentProfileRequest(CustomerPaymentProfile profile, Address newAddress, CreditCard newCard) {
        this.profile = profile;
        this.address = newAddress;
        this.card = newCard;
    }

    public String getBody() {
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