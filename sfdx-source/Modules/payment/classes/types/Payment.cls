public class Payment extends AuthorizeDotNetType {
    private CreditCard creditCard;

    public Payment(CreditCard card) {
        this.creditCard = card;
        this.fields = new Set<String> {
            'creditCard'
        };
    }

    public CreditCard getCreditCard() {
        return this.creditCard;
    }

    public void setCreditCard(CreditCard card) {
        this.creditCard = card;
    }

    public override Map<String,Object> toMap() {
        return new Map<String,Object>{'creditCard' => this.creditCard};
    }
}