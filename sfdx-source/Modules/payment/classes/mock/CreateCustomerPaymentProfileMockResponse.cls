public class CreateCustomerPaymentProfileMockResponse extends AuthorizeDotNetResponse implements IMockResponse {
    public CreateCustomerPaymentProfileMockResponse() {
        // Setup all of your mock data here.
    }

    public override String getBody(String custProfileId) {
        
        body = JSON.serialize(createCustomerProfileSuccessResponse());
        return body;
    }

    public Object createCustomerProfileSuccessResponse() {
        // construct a response of type Map<String, Object> that is consistant with the sample response in the documentation
        // will move this work to authorizedotnetclient class

        // Constructs the message list
        List<Map<String, String>> messageList = new List<Map<String, String>>{
            new Map<String, String>{
                'code' => 'I00001',
                'text' => 'Successful.'
            }
        };
        
        // Constructs the messages object
        Map<String, Object> messages = new Map<String, Object>{
            'resultCode' => 'Ok',
            'message' => messageList
        };
        
        // Constructs the response object
        Map<String, Object> response = new Map<String, Object>{
            'customerProfileId' => '527262',
            'customerPaymentProfileId' => '87',
            'validationDirectResponse' => '1,1,1,This transaction has been approved.,AF94HU,Y,10586,none,Test transaction for ValidateCustomerPaymentProfile.,0.00,CC,auth_only,none,John,Doe,,123 Main St.,Bellevue,WA,98004,US,000-000-0000,,email@example.com,,,,,,,,,0.00,0.00,0.00,FALSE,none,76247385B849148C0C6E0C205A6BEFFA,P,2,,,,,,,,,,,XXXX1111,Visa,,,,,,,0TN1VE648DFCJSHQ81GZH9F,,,,,,,,,,',
            'messages' => messages
        };
        
        return response;  // Casting Map<String, Object> to Object
    }

    public Object createCustomerProfileErrorResponse() {

        // Constructs the message list
        List<Map<String, String>> messageList = new List<Map<String, String>>{
            new Map<String, String>{
                'code' => 'E00040',
                'text' => 'The record cannot be found..'
            }
        };
        
        // Constructs the messages object
        Map<String, Object> messages = new Map<String, Object>{
            'resultCode' => 'Error',
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