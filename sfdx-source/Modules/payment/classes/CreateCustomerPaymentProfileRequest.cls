public class CreateCustomerPaymentProfileRequest extends HttpRequestMessage {



    public CreateCustomerPaymentProfileRequest(CustomerPaymentProfile profile) {
        this.setMethod('POST');
        this.setEndpoint('http://fubar');
        this.body = JSON.serialize(profile, true);
    }
}