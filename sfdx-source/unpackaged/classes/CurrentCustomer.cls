public class CurrentCustomer {

    
    /*
String stevensTestContactId = '0037h00000uAHSHAA4';
String contactId = '';

c = Database.query('SELECT FirstName, LastName, Email, AuthorizeDotNetCustomerProfileId__c FROM Contact WHERE Id = :contactId');

customerProfileId = (String)c.get('AuthorizeDotNetCustomerProfileId__c');
*/

/*
*         Map <String, String> interns = new Map<String,String> {
    'johnDoeAuthDotNetId' =>'905372692',
    'maraAuthDotNetId' => '916376196',
    'maraSandBoxSfContactId' => '0037h00000uAHSHAA4'
};
*/

/*
*         // c = [SELECT FirstName, LastName, Email FROM Contact WHERE Id = '0037h00000u1YBpAAM'];
//customerProfileId = '905372692';//c.AuthorizeDotNetCustomerProfileId__c;
//paymentProfileId = '915752253';

// Steven's sandbox 
customerProfileId = '916263569';
*/

public static String    getCustomerProfileId() {
String customerProfileId = ApexPages.currentPage().getParameters().get('customerProfileId');
customerProfileId = null == customerProfileId ? '916376196' : customerProfileId;

return customerProfileId;

}
}