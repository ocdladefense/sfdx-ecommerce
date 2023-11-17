public with sharing class PaymentProfileRequest {
    private Map<String, String> merchantAuthentication;
    private String customerProfileId;
    private Integer customerPaymentProfileId;

    //should be a constant and pulled from env file?
    private string name = '5KP3u95bQpv';
    private string transactionKey = '346HZ32z3fP4hTG2';

    public PaymentProfileRequest() {
        this.merchantAuthentication = new Map<String, String> {'name'=>this.name, 
        'transactionKey'=>this.transactionKey};
    }
    public PaymentProfileRequest(String customerProfileId, Integer customerPaymentProfileId) {
        this.merchantAuthentication = new Map<String, String> {'name'=>this.name, 
        'transactionKey'=>this.transactionKey};
        this.customerPaymentProfileId = customerPaymentProfileId;
        this.customerProfileId = customerProfileId;
    }
  /*
    public Map<String, String> getMerchantAuthentication {
        Map<String, String> body = {'name'=>this.name, 'transactionKey'=>this.transactionKey};
        return body;
    }
                                                                            
 {
        'deleteCustomerPaymentProfileRequest=> {
            'merchantAuthentication'=> {
                'name'=>'5KP3u95bQpv',
                'transactionKey': '346HZ32z3fP4hTG2'
            },
            'customerProfileId'=> customerProfileId,
            'customerPaymentProfileId'=> cardId
            }
        }

    */
    
}


