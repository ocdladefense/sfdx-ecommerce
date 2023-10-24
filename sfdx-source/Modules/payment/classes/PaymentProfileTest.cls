// Alex's class for testing fetching and converting credit card information
@isTest
public class PaymentProfileTest {
     
    
    // Tests the fetching of a users card(s)
    @isTest
    static void TestFetchCards() {

        AuthorizeDotNetMockResponse respMock = new AuthorizeDotNetMockResponse(PaymentGatewayRequestType.GET_CUSTOMER_PAYMENT_PROFILES);
        Test.setMock(HttpCalloutMock.class, respMock);
        
        Test.startTest();
        List<CreditCard> cards = CreditCard.retrieveSavedCards('905372692');
 
        Test.stopTest();
        System.assertNotEquals(null, cards, 'Cards is null.');
        System.assert(cards.size() == 4);
        
        Integer numExpiredCards = 0;
        Integer expectedExpiredCards = 1;
        
        for(CreditCard c : cards) {
            if(c.isExpired()) {
                numExpiredCards++;
            }
        }
        // Number of expired versus not-expired cards.
        // Number of valid versus not-valid cards.
        // 
        System.assertEquals(expectedExpiredCards, numExpiredCards, 'Payment Gateway should have returned at least one expired card for this customer.');
    }
    
    /*
    // Tests the conversion of JSON cards to the CreditCard class list as well as getters
    @isTest
    static void ConvertToCardTest() {
        List<CreditCard> cardList = CreditCard.retrieveSavedCards('');
        CreditCard firstCard = cardList[0];

        // Checks if list is not empty
        Assert.areNotEqual(0, cardList.size());
        // Checks each object in the list if it's a CreditCard and its getters work
        Assert.isInstanceOfType(firstCard, CreditCardSteven.class);
        Assert.areEqual(firstCard.getId(), 905372692);
        Assert.areEqual(firstCard.getIsDefault(), true);
        Assert.areEqual(firstCard.getCardNumber(), 'XXXX9711');
    }
    
    
    // Tests the conversion of a list of CreditCard to a list of SelectOptions
    @isTest
    static void CardsToOptionsTest() {
        List<CreditCard> cardList = CreditCard.retrieveSavedCards('');
        List<SelectOption> optionList = CreditCard.toSelectOptions(cardList);
        // Checks if cardList and optionList aren't empty
        Assert.areNotEqual(null, cardList);
        Assert.areNotEqual(null, optionList);
        // Checks each object in the list if it's a CreditCard
    }
*/
}