@isTest
public with sharing class PaymentProfileTest {
    
    @isTest static void testCreditCardConstructor() {
        String cardNumber = '121223233434';
        Date expirationDate = Date.newInstance(2028, 4, 1);
        String firstName = 'Kevin';
        String lastName = 'Striker';

        CreditCard card = new CreditCard(cardNumber, expirationDate, firstName, lastName);

        System.assertEquals(cardNumber, card.getCardNumber());
        System.assertEquals(expirationDate, card.getExpirationDate());
        System.assertEquals(firstName, card.getFirstName());
        System.assertEquals(lastName, card.getLastName());
    }
}