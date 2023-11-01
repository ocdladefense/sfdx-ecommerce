public class CreateCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {



    public CreateCustomerPaymentProfileRequest(CustomerPaymentProfile profile) {
        this.setMethod('POST');
        this.setEndpoint('http://fubar');
        this.body = JSON.serialize(profile, true);
    }
}