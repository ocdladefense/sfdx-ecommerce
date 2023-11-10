public  class Payload {

/*
    public Map<String,String> merchantAuthentication = new Map<String, String>{ 
        'name'=> '6gSVxaYj397',
        'transactionKey'=> '6FR49pDH5Jjum58g'
    };
*/

    //private String foo = 'bar';


    private AuthorizeDotNetRequest deleteCustomerPaymentProfileRequest;



    public Payload(AuthorizeDotNetRequest req){
        this.deleteCustomerPaymentProfileRequest = req;
    }

    public override String toString() {
        return '';
    }
}