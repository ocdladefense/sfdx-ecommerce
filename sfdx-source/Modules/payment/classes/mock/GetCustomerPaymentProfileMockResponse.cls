public class GetCustomerPaymentProfileMockResponse extends AuthorizeDotNetResponse implements IMockResponse {

    public GetCustomerPaymentProfileMockResponse() {

    }
    
    public String getBody(String custProfileId) {
        
        body = JSON.serialize(getCustomerProfileSuccessResponse());
        return body;
    }

    public Object getCustomerProfileSuccessResponse() {
        // construct a response of type Map<String, Object> that is consistant with the sample response in the documentation
        // will move this work to authorizedotnetclient class

        // Constructs the paymentProfile string
        Map<String,Object> creditCard = new Map<String,Object> {
            'cardNumber' => 'XXXX1111',
            'expirationDate' => 'XXXX',
            'cardType' => 'Visa',
            'issuerNumber' => '411111'
        };

        Map<String,Object> billTo = new Map<String,Object>{
            'phoneNumber' => '000-000-0000',
            'firstName' => 'John',
            'lastName' => 'Doe',
            'address' => '123 Main St.',
            'city' => 'Bellevue',
            'state' => 'WA',
            'zip' => '98004',
            'country' => 'US'
        };

        Map<String,Object> payment = new Map<String,Object>{
            'creditCard' => creditCard,
            'originalNetworkTransId' => '0TN1VE648DFCJSHQ81GZH9F',
            'originalAuthAmount' => 0,
            'billTo' => billTo
        };

        Map<String,Object> paymentProfile = new Map<String,Object>{
            'customerProfileId' => '527262',
            'customerPaymentProfileId' => '87',
            'payment' => payment
        };

        // Constructs the message list
        List<Map<String, String>> messageList = new List<Map<String, String>>{
            new Map<String, String>{
                'code' => 'I00001',
                'text' => 'Successful.'
            }
        };
        
        // Constructs the messages object
        Map<String, Object> messages = new Map<String, Object>{
            'resultCode' => RESPONSE_SUCCESS,
            'message' => messageList
        };
        
        // Constructs the response object
        Map<String, Object> response = new Map<String, Object>{
            'paymentProfile' => paymentProfile,
            'messages' => messages
        };
        
        return response;  // Casting Map<String, Object> to Object
    }

    public Object createCustomerProfileErrorResponse() {

        // Constructs the paymentProfile string
        Map<String,Object> creditCard = new Map<String,Object> {
            'cardNumber' => 'XXXX1111',
            'expirationDate' => 'XXXX',
            'cardType' => 'Visa',
            'issuerNumber' => '411111'
        };

        Map<String,Object> billTo = new Map<String,Object>{
            'phoneNumber' => '000-000-0000',
            'firstName' => 'John',
            'lastName' => 'Doe',
            'address' => '123 Main St.',
            'city' => 'Bellevue',
            'state' => 'WA',
            'zip' => '98004',
            'country' => 'US'
        };

        Map<String,Object> payment = new Map<String,Object>{
            'creditCard' => creditCard,
            'originalNetworkTransId' => '0TN1VE648DFCJSHQ81GZH9F',
            'originalAuthAmount' => 0,
            'billTo' => billTo
        };

        Map<String,Object> paymentProfile = new Map<String,Object>{
            'customerProfileId' => '527262',
            'customerPaymentProfileId' => '87',
            'payment' => payment
        };

        // Constructs the message list
        List<Map<String, String>> messageList = new List<Map<String, String>>{
            new Map<String, String>{
                'code' => 'E00040',
                'text' => 'The record cannot be found..'
            }
        };
        
        // Constructs the messages object
        Map<String, Object> messages = new Map<String, Object>{
            'resultCode' => RESPONSE_FAILURE,
            'message' => messageList
        };
        
        // Constructs the response object
        Map<String, Object> response = new Map<String, Object>{
            'validationDirectResponse' => '1,1,1,This transaction has been approved.,A554SC,Y,120008524471,none,Test transaction for ValidateCustomerPaymentProfile.,0.00,CC,auth_only,none,John,Doe,,123 Main St.,Bellevue,WA,98004,US,000-000-0000,,email@example.com,,,,,,,,,0.00,0.00,0.00,FALSE,none,,P,2,,,,,,,,,,,XXXX1111,Visa,,,,,,,08Y6U2SBAHO74MLKSRPXN9N,,,,,,,,,,',
            'messages' => messages
        };
        
        return response;  // Casting Map<String, Object> to Object

    }
}