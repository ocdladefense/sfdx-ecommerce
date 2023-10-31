public class CustomerPaymentProfileList {
    public CustomerPaymentProfileList() {

    }

    public static List<CustomerPaymentProfile> fromMapData(List<Map<String,String>> profiles) {        
    
        // Map<String,Map<String, String>> fetchedCards =  fetchUsersCards(customerProfileId);

        List<CreditCard> savedCards = new List<CreditCard> {};
        
        for (Map<string,string> card : profiles) {
            Integer id = Integer.valueOf(card.get('id'));
            List<String> dateParts = card.get('expirationDate').split('-');
            Integer year = Integer.valueOf(dateParts[0]);
            Integer month = Integer.valueOf(dateParts[1]);
            Date expDate = Date.newInstance(year, month, 1);
            String cardNum = card.get('cardNumber');
            String firstName = card.get('firstName');
            String lastName = card.get('lastName');

            CreditCard theCard = new CreditCard(cardNum, expDate);

            savedCards.add(theCard);
        }
        return savedCards;

    }
}