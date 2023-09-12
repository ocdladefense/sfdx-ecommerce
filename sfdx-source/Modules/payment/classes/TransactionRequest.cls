public class TransactionRequest {

    // Combination of card, billing and shipping data.
    // This is the actual collection sent to the card processor.
    private Map<String,String> params = new Map<String,String>();
    
    private Map<String,String> shipto = null;
    
    private Map<String,String> billto = null;
    
    private Map<String,String> creditCard = null;
    
    private Decimal amount;
    
    
    public TransactionRequest() {
        
    }
    
    public TransactionRequest(String url) {
        
    }
    
    
    public void setParams(Map<String,String> params) {
        this.params = params;
    }
    
    public HttpRequest toHttpRequest() {
        
        HttpRequest req = new HttpRequest();
        //Set HTTPRequest Method
        req.setMethod('POST');

        

        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
        // Set the HTTPRequest body	
        String body = formatBody(this.params);
        if(null != body) {
        	req.setBody(body);
        }
        
        return req;
    }
    
    public void setCreditCard(Map<String,String> card) {
        this.creditCard = card;
    }
    
    public void setAmount(Decimal amount) {
        this.amount = amount;
    }
    
    
    public void setBillToAddress(Map<String,String> address) {
        
        this.billto = address;
    }
    
    
    public void setShipToAddress(Map<String,String> address) {
        this.shipto = address;
    }
    
    
    
    
    public static TransactionRequest fromSalesforceData(Decimal amount, Map<String,String> ccData, Map<String,String> billingData, Map<String,String> shippingData, Map<String,String> otherData) {
        if (null == shippingData) {
            shippingData = new Map<String, String>();
        }
        
        if (null == billingData) {
            billingData = new Map<String, String>();
        }
        
        if(null == otherData) {
            otherData = new Map<String,String>();
        }
        
        
        /*
         * 
		'AuthorizeDotNetCustomerProfileId__c' => '',
		'authNetPaymentProfileDescription' => '',
		'authNetPaymentProfileId' => '',
		'authNetCreatePaymentProfile' => 'false',
*/

        
        Map<String, String> params = new Map<String, String> {
		
		
		'amount' => String.valueOf(amount),
		
		'AuthorizeDotNetCustomerProfileId__c' => '',
		'authNetPaymentProfileDescription' => '',
		'authNetPaymentProfileId' => '',
		'authNetCreatePaymentProfile' => 'false',
        
		'BillingFirstName' => billingData.get('firstName'),
		'BillingLastName' => billingData.get('lastName'),
		'BillingStreet' => billingData.get('street'),
		'BillingCity' => billingData.get('city'),
		'BillingStateCode' => billingData.get('stateCode'),
		'BillingPostalCode' => billingData.get('postalCode'),
		'BillingEmail' => billingData.get('email'),
		'BillingCountryCode' => billingData.get('countryCode'),
		
		'ShippingStreet' => shippingData.get('street'),
		'ShippingCity' => shippingData.get('city'),
		'ShippingStateCode' => shippingData.get('stateCode'),
		'ShippingPostalCode' => shippingData.get('postalCode'),
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
    }
    
    
    public String formatBody(String fieldName,String fieldValue){
        return fieldName+'='+EncodingUtil.urlEncode(fieldValue, 'UTF-8');
    }
    
	// parameter acts like a clone()    
    public String formatBody(Map<String,String> ccVals){
        List<String> postBody = new List<String>();
        
        if(null == ccVals) return null;
        
        for(String key: ccVals.keySet()) {
            if('' == key) continue;
            if(null == ccVals.get(key)) continue;
            postBody.add(key+'='+EncodingUtil.urlEncode(ccVals.get(key), 'UTF-8'));
        }

        return String.join(postBody,'&');                 
    }
    

    
}