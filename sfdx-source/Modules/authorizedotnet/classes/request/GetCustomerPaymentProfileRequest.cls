public class GetCustomerPaymentProfileRequest extends AuthorizeDotNetRequest {
    public String customerProfileId;

    public String customerPaymentProfileId;

    private Boolean unmaskExpirationDate = true;





    public GetCustomerPaymentProfileRequest() {
        super('getCustomerPaymentProfile');
    }



    public GetCustomerPaymentProfileRequest(CustomerPaymentProfile profile) {
        this();
        this.customerPaymentProfileId = profile.getCustomerPaymentProfileId();
    }


    public override Set<String> keySet() {
        return new Set<String>{'customerProfileId', 'customerPaymentProfileId', 'unmaskExpirationDate'};
    }

    public override String getPrimaryKeyField() {
        return 'customerPaymentProfileId';
    }

    public override String getPrimaryKeyValue() {
        return this.customerPaymentProfileId;
    }
    

    public void setCustomerProfileId(String customerProfileId) {
        this.customerProfileId = customerProfileId;
    }

    public void setCustomerPaymentProfileId(String customerPaymentProfileId) {
        this.customerPaymentProfileId = customerPaymentProfileId;
    }

    public Boolean getUnmaskExpirationDate(){
        return this.unmaskExpirationDate;
    }

    public void setUnmaskExpirationDate(Boolean unmaskExpirationDate){
        this.unmaskExpirationDate=unmaskExpirationDate;
    }

}