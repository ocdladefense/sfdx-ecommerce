public class Payment extends AuthorizeDotNetType {
    private CreditCard creditCard;

    public Payment() {
        
    }

    public Payment(CreditCard card) {
        this.creditCard = card;
        
    }

    public CreditCard getCreditCard() {
        return this.creditCard;
    }

    public void setCreditCard(CreditCard card) {
        this.creditCard = card;
    }

    public override Map<String,Object> toMap() {
        this.fields = new Set<String> {
            'creditCard'
        };
        return new Map<String,Object>{'creditCard' => this.creditCard};
    }
}