
public class CreateTransactionRequest extends AuthorizeDotNetRequest {

    private AuthNetTransaction transactionRequest;


    
    
    public CreateTransactionRequest() {
        super('createTransaction');
        this.fields = new Set<String>{'transactionRequest'};
    }

    public CreateTransactionRequest(AuthNetTransaction tx) {
        this();
        this.transactionRequest = tx;
    }
    

    public void setTransaction(AuthNetTransaction tx) {
        this.transactionRequest = tx;
    }
    
    
    public override Map<String,Object> toMap() {

        return new Map<String,Object>{'transactionRequest' => this.transactionRequest};
    }
    

    
    
    
    public static CreateTransactionRequest fromSalesforceData(Decimal amount, Map<String,String> ccData, Map<String,String> billingData, Map<String,String> shippingData, Map<String,String> otherData) {
        if (null == shippingData) {
            // shippingData = new Map<String, String>();
        }
        
        if (null == billingData) {
            // billingData = new Map<String, String>();
        }
        
        if(null == otherData) {
            // otherData = new Map<String,String>();
        }
        
        return null;
        /*
         * 
		'AuthorizeDotNetCustomerProfileId__c' => '',
		'authNetPaymentProfileDescription' => '',
		'authNetPaymentProfileId' => '',
		'authNetCreatePaymentProfile' => 'false',
*/

        /*
        Map<String, String> params = new Map<String, String> {
		
		
		'amount' => String.valueOf(amount),
		
		'AuthorizeDotNetCustomerProfileId__c' => '',
		'authNetPaymentProfileDescription' => '',
		'authNetPaymentProfileId' => '',
		'authNetCreatePaymentProfile' => 'false',
        
		'BillingFirstName' => billingData.get('FirstName'),
		'BillingLastName' => billingData.get('LastName'),
		'BillingStreet' => billingData.get('BillingStreet'),
		'BillingCity' => billingData.get('BillingCity'),
		'BillingStateCode' => billingData.get('BillingStateCode'),
		'BillingPostalCode' => billingData.get('BillingPostalCode'),
		'BillingEmail' => billingData.get('email'),
		'BillingCountryCode' => billingData.get('countryCode'),
		
		'ShippingStreet' => shippingData.get('ShippingStreet'),
		'ShippingCity' => shippingData.get('ShippingCity'),
		'ShippingStateCode' => shippingData.get('ShippingStateCode'),
		'ShippingPostalCode' => shippingData.get('ShippingPostalCode'),
		'ShippingCountryCode' => shippingData.get('countryCode'),
		
		'ccNum' => ccData.get('ccNum'),
		'ccExp' => ccData.get('ccExp'),
		'ccCode' => ccData.get('ccCode')
        };

		String orderNumber = otherData.get('OrderNumber');
		params.put('OrderNumber', orderNumber);
        
        // Create a map to be converted to JSON
        TransactionRequest req = new TransactionRequest(); 
        req.setParams(params);
       
        return req;
        */
    }
    
    

    

    

}