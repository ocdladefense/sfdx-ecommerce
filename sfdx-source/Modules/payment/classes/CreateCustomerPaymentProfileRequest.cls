public class CreateCustomerPaymentProfileRequest extends HttpRequestMessage {



    public CreateCustomerPaymentProfileRequest(CustomerPaymentProfile profile) {
        this.body = JSON.serialize(profile, true);
    }
}