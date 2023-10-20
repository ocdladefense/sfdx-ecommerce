@isTest
public with sharing class PaymentProfileTestSteven {
    @isTest static void testCreditCardStevenConstructor() {
        Test.startTest();
        Integer id = 905263202;
        String cardNumber = '121223233434';
        Date expirationDate = Date.newInstance(2028, 4, 1);
        String firstName = 'Kevin';
        String lastName = 'Striker';

        CreditCardSteven card = new CreditCardSteven(cardNumber, expirationDate, firstName, lastName, id);
        Test.stopTest();

        System.assertEquals(cardNumber, card.getCardNumber());
        System.assertEquals(expirationDate, card.getExpirationDate());
        System.assertEquals(firstName, card.getFirstName());
        System.assertEquals(lastName, card.getLastName());
    }

    @isTest static void testFetchUsersCards() {
        Test.startTest();
        CreditCardFetchResponseMock mock = new CreditCardFetchResponseMock();

        Test.setMock(HttpCalloutMock.class, mock);

        String customerProfileId = '905372692';
        String cardId = '905264262';
        String cardNumber = 'XXXX4532';
        String expirationDate = '2024-08';
        String firstName = 'John';
        String lastName = 'Doe';
        
        Map<String,Map<String,String>> creditCards =  CreditCardSteven.fetchUsersCards(customerProfileId);
        Map<String,String> card = creditCards.get(cardId);
        Test.stopTest();

        System.assertNotEquals(null, creditCards);
        System.assert(!creditCards.isEmpty());
        System.assertEquals(cardNumber, card.get('cardNumber'));
        System.assertEquals(expirationDate, card.get('expirationDate'));
        System.assertEquals(firstName, card.get('firstName'));
        System.assertEquals(lastName, card.get('lastName'));
    }

    @isTest static void testRetrieveSavedCards() {
        Test.startTest();
        CreditCardFetchResponseMock mock = new CreditCardFetchResponseMock();

        Test.setMock(HttpCalloutMock.class, mock);

        String customerProfileId = '905372692';
        String cardNumber = 'XXXX4532';
        Date expirationDate = Date.newInstance(2024, 8, 1);
        String firstName = 'John';
        String lastName = 'Doe';
        
        List<CreditCardSteven> creditCards =  CreditCardSteven.retrieveSavedCards(customerProfileId);
        CreditCardSteven card = creditCards[3]; // this card was added first but ended up at end of list of cards
        Test.stopTest();

        System.assertNotEquals(null, creditCards);
        System.assert(!creditCards.isEmpty());
        System.assertEquals(cardNumber, card.getCardNumber());
        System.assertEquals(expirationDate, card.getExpirationDate());
        System.assertEquals(firstName, card.getFirstName());
        System.assertEquals(lastName, card.getLastName());
    }

    @isTest static void testToSelectOptions() {
        Test.startTest();
        CreditCardFetchResponseMock mock = new CreditCardFetchResponseMock();

        Test.setMock(HttpCalloutMock.class, mock);

        String customerProfileId = '905372692';
        List<CreditCardSteven> creditCards =  CreditCardSteven.retrieveSavedCards(customerProfileId);
        List<SelectOption> cardValues = new List<SelectOption>(CreditCardSteven.toSelectOptions(creditCards));
        List<SelectOption> expectedOptions = new List<SelectOption>{
            new SelectOption('XXXX4532', '2024-08'),
            new SelectOption('XXXX4632', '2023-08(expired)'),
            new SelectOption('XXXX4786', '2043-08'),
            new SelectOption('XXXX4912', '2025-08')
        };
        
        Test.stopTest();

        System.assertEquals(expectedOptions.size(), cardValues.size());
    }
}