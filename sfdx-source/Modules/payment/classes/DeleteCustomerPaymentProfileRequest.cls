public class DeleteCustomerPaymentProfileRequest extends HttpRequestMessage {
    private String body;

    public DeleteCustomerPaymentProfileRequest(CustomerPaymentProfile profile) {
        this.body = JSON.serialize(profile, true);
    }
}