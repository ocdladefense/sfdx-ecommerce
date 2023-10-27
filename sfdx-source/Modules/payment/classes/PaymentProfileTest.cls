@isTest
public class PaymentProfileTest {
    /*@isTest static void testForTest(){
        Test.startTest();
        Integer i = 1;
        Test.stopTest();
        System.assertEquals(1, i);
    }*/

    @isTest 
    static void testCreditCardConstructors() {
        //constructor takes credit card number only
        CreditCard validCard = new CreditCard('4444222211111111');
        CreditCard invalidCard = new CreditCard('21');

        System.assert(validCard.isValid());
        System.assert(!invalidCard.isValid());

        //constructor takes credit card number and expiration date only
        CreditCard expiredCard = new CreditCard('4444222211111111', Date.newInstance(2001, 4, 1));
        CreditCard currentCard = new CreditCard('4444222211111111', Date.newInstance(2026, 4, 1));

        System.assert(expiredCard.isExpired());
        System.assert(!currentCard.isExpired());

        //constructor takes credit card number, expiration date, and cvv
        CreditCard validCVVCard = new CreditCard('4444222211111111', Date.newInstance(2026, 4, 1), '123');
        CreditCard invalidCVVCard = new CreditCard('44', Date.newInstance(2001, 4, 1), '123');
        
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

       Map<String, Map<String,String>> paymentProfileWithCards =  CreditCard.fetchUsersCards(customerWithSavedCards);
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

        Map<String, Map<String,String>> paymentProfileNoCards =  CreditCard.fetchUsersCards(customerNoSavedCards);
        Test.stopTest();

        //assert list is empty and has count of 0 for customer with no saved cards
        System.assert(paymentProfileNoCards.isEmpty());
        System.assertEquals(0, paymentProfileNoCards.size());

    }

    @isTest static void testRetrieveSavedCardsOnSavedPaymentProfile() {
        //this tests retrieved saved cards which uses fetchUserCards
        //retreived saved cards should be a list of creditCard objects
        //System.Assert.isInstanceOfType(card, CreditCard.class));

        Test.startTest();
        AuthorizeDotNetMockResponse mock = new AuthorizeDotNetMockResponse(PaymentGatewayRequestType.GET_CUSTOMER_PAYMENT_PROFILES);

        Test.setMock(HttpCalloutMock.class, mock);

        String customerWithSavedCards = '905372692';

        List<CreditCard> cards = CreditCard.retrieveSavedCards(customerWithSavedCards);
        Test.stopTest();

        System.assert(!cards.isEmpty());
        System.assertEquals(4, cards.size());

        //number of expired cards v not expired cards
        //number of valid cards
        Integer numExpiredCards = 0;
        Integer expectedExpiredCards = 1;
        
        for(CreditCard c : cards) {
            if(c.isExpired()) {
                numExpiredCards++;
            }
        }
        System.assertEquals(expectedExpiredCards, numExpiredCards, 'Payment Gateway should have returned at least one expired card for this customer.');
        
        Integer numDefaultCards = 0;
        Integer expectedDefaultCards = 1;
        for(CreditCard c : cards) {
            if(c.getIsDefault()) {
                numDefaultCards++;
            }
        }

        System.assertEquals(expectedDefaultCards, numDefaultCards, 'Payment Gateway should have returned one default card for this customer.');
    }
    
    @isTest static void testRetrieveSavedCardsWithNoSavedProfile() {
        //this tests retrieved saved cards which uses fetchUserCards
        //retreived saved cards should be a list of creditCard objects
        //when the list is empty what should it do?
        Test.startTest();
        AuthorizeDotNetMockResponse mock = new AuthorizeDotNetMockResponse(PaymentGatewayRequestType.GET_CUSTOMER_PAYMENT_PROFILES);

        Test.setMock(HttpCalloutMock.class, mock);

        String customerNoSavedCards = 'abcd1234';

        List<CreditCard> retreivedCards = CreditCard.retrieveSavedCards(customerNoSavedCards);
        Test.stopTest();

        System.assert(retreivedCards.isEmpty());
        System.assertEquals(0, retreivedCards.size());
        
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
    
        //test that the new default card passes isDefault
        //test that old default card passes !isDefault
    }

    @isTest static void testRemoveCardFromPaymentProfile() {

        Test.startTest();
        AuthorizeDotNetMockResponse putMock = new AuthorizeDotNetMockResponse(PaymentGatewayRequestType.DELETE_CUSTOMER_PAYMENT_PROFILE);
        Test.setMock(HttpCalloutMock.class, putMock);

        String customerProfileId = '905372692';
        //delete this card, in test data card is expired
        Integer paymentProfileCardIdToDelete = 905264263;
        CreditCard card = new CreditCard('4444111144441111');
        card.setId(paymentProfileCardIdToDelete);
        AuthorizeDotNetResponse response = card.deleteCardFromPaymentProfile(customerProfileId);
        response.deserialize();
        Test.stopTest();

        String resultCode = response.getResultCode();
        System.debug(resultCode);
        System.assertEquals('Ok', resultCode, 'Successful call to delete should return an Ok result code');


        //call delete on the card

        //AuthorizeDotNetMockResponse putMock = new AuthorizeDotNetMockResponse(PaymentGatewayRequestType.DELETE_CUSTOMER_PAYMENT_PROFILES);

        //Test.setMock(HttpCalloutMock.class, getMock);
      

       
        //test that the size of the list is less than the original by 1
        //test the count of expired cards is 0

/*
        Integer numExpiredCards = 0;
        Integer expectedExpiredCards = 1;
        
        for(CreditCard c : cards) {
            if(c.isExpired()) {
                numExpiredCards++;
            }
        }
        System.assertEquals(expectedExpiredCards, numExpiredCards, 'Payment Gateway should have returned at least one expired card for this customer.');

    }
*/
}}