
@isTest
public with sharing class PaymentProfileTestMCW {
    /*@isTest static void testForTest(){
        Test.startTest();
        Integer i = 1;
        Test.stopTest();
        System.assertEquals(1, i);
    }*/

    @isTest 
    static void testCreditCardMaraConstructors() {
        //constructor takes credit card number only
        CreditCardMara validCard = new CreditCardMara('4444222211111111');
        CreditCardMara invalidCard = new CreditCardMara('21');

        System.assert(validCard.isValid());
        System.assert(!invalidCard.isValid());

        //constructor takes credit card number and expiration date only
        CreditCardMara expiredCard = new CreditCardMara('4444222211111111', Date.newInstance(2001, 4, 1));
        CreditCardMara currentCard = new CreditCardMara('4444222211111111', Date.newInstance(2026, 4, 1));

        System.assert(expiredCard.isExpired());
        System.assert(!currentCard.isExpired());

        //constructor takes credit card number, expiration date, and cvv
        CreditCardMara validCVVCard = new CreditCardMara('4444222211111111', Date.newInstance(2026, 4, 1), '123');
        CreditCardMara invalidCVVCard = new CreditCardMara('44', Date.newInstance(2001, 4, 1), '123');
        
        System.assert(validCVVCard.isValid());
        System.assert(!invalidCVVCard.isValid());
        System.assert(!validCVVCard.isExpired());
        System.assert(invalidCVVCard.isExpired());
    }

    @isTest 
    static void testFetchUsersCardsWithSavedCards() {
        Test.startTest();
        AuthorizeDotNetMockResponse mock = new AuthorizeDotNetMockResponse(PaymentGatewayRequestType.GET_CUSTOMER_PAYMENT_PROFILES);

        Test.setMock(HttpCalloutMock.class, mock);

        String customerWithSavedCards = '905372692';

        Map<String,Map<String,String>> paymentProfileWithCards =  CreditCardMara.fetchUsersCards(customerWithSavedCards);
        Test.stopTest();
        //assert list is not empty and has count of 4 for customer with saved cards
        System.assert(!paymentProfileWithCards.isEmpty());
        System.assertEquals(4, paymentProfileWithCards.size());
    }
    @isTest 
    static void testFetchUsersCardsWithNoPaymentProfileSaved() {
        Test.startTest();
        AuthorizeDotNetMockResponse mock = new AuthorizeDotNetMockResponse(PaymentGatewayRequestType.GET_CUSTOMER_PAYMENT_PROFILES);

        Test.setMock(HttpCalloutMock.class, mock);

        String customerNoSavedCards = 'abcd1234';

        Map<String,Map<String,String>> paymentProfileNoCards =  CreditCardMara.fetchUsersCards(customerNoSavedCards);
        Test.stopTest();

        //assert list is empty and has count of 0 for customer with no saved cards
        System.assert(paymentProfileNoCards.isEmpty());
        System.assertEquals(0, paymentProfileNoCards.size());

    }

    @isTest static void testRetrieveSavedCardsOnSavedPaymentProfile() {
        //this tests retrieved saved cards which uses fetchUserCards
        //retreived saved cards should be a list of creditCard objects
        //System.Assert.isInstanceOfType(card, CreditCardMara.class));
    }
    
    @isTest static void testRetrieveSavedCardsWithNoSavedProfile() {
        //this tests retrieved saved cards which uses fetchUserCards
        //retreived saved cards should be a list of creditCard objects
        //when the list is empty what should it do?
        }
    @isTest static void testAddValidNewCardToPaymentProfile() {
        System.assert(1==1);
        //request type = put
        //test that the size of the list is greater than original
    }

    @isTest static void testAddInvalidCardTypeToPaymentProfile() {
        System.assert(1==1);
        //request type = put
        //test that a message was received
        //test that the size of the list is the same as the original
    }

    @isTest static void testAddExpiredCardToPaymentProfile() {
        System.assert(1==1);
        //request type = put
        //test that a message was received
        //test that the size of the list is the same as the original
    }


    @isTest static void testAddExistingCardAsNewToPaymentProfile() {
        System.assert(1==1);
         //request type = put
         //test that a message was received
        //test that the size of the list is the same as the original
    }

    @isTest static void testUpdateExistingCardToPaymentProfile() {

    }

    @isTest static void testChangeDefaultCard() {
        System.assert(1==1);
        //request type = put
        //test that the new default card passes isDefault
        //test that old default card passes !isDefault
    }

    @isTest static void testRemoveCardFromPaymentProfile() {
        System.assert(1==1);
        //request type = put
        //test that the size of the list is less than the original by 1
    }

}