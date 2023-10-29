public class GetCustomerProfileRequest extends HttpRequestMessage {
    //this makes a request to retrieve all the saved payment profiles for a customer
    private final String GET_CUSTOMER_ENDPOINT = 'https://appdev.ocdla.org/customer/905372692/cards';
    private Map<String, Object> reqBody;

    public GetCustomerProfileRequest(String customerProfileId) {
        this.setMethod('POST');
        this.setEndpoint(GET_CUSTOMER_ENDPOINT);
        this.reqBody = new Map<String, Object>{
            'getCustomerProfileRequest'=>new Map<String,Object>{
                'customerProfileId'=> customerProfileId,
                'includeIssuerInfo'=>true
            }
        };
        this.body = JSON.serialize(this.reqBody, true);
    }
}