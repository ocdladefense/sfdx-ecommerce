public class Payment {
    private CreditCard creditCard;

    public Payment(CreditCard card) {
        this.creditCard = card;
    }

    public CreditCard getCreditCard() {
        return this.creditCard;
    }

    public void setCreditCard(CreditCard card) {
        this.creditCard = card;
    }
}