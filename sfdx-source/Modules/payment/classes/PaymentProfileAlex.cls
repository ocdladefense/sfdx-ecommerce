// Alex's class for testing fetching and converting credit card information
@isTest
public with sharing class PaymentProfileAlex {
    // Tests the fetching of a users card(s)
    @isTest static void TestFetchCards() {
        Test.startTest();
        CreditCardFetchResponseMock respMock = new CreditCardFetchResponseMock();
        Map<String,Map<String,String>> cards = respMock.savedCreditCardsResponseBody();

        Test.stopTest();
        Assert.areNotEqual(null, cards, 'cards is null');
    }
    // Tests the conversion of JSON cards to the CreditCard class list as well as getters
    @isTest static void ConvertToCardTest() {
        List<CreditCardSteven> cardList = CreditCardSteven.retrieveSavedCards('');
        CreditCardSteven firstCard = cardList[0];

        // Checks if list is not empty
        Assert.areNotEqual(0, cardList.size());
        // Checks each object in the list if it's a CreditCard and its getters work
        Assert.isInstanceOfType(firstCard, CreditCardSteven.class);
        Assert.areEqual(firstCard.getId(), 905372692);
        Assert.areEqual(firstCard.getIsDefault(), true);
        Assert.areEqual(firstCard.getCardNumber(), 'XXXX9711');
    }
    // Tests the conversion of a list of CreditCard to a list of SelectOptions
    @isTest static void CardsToOptionsTest() {
        List<CreditCardSteven> cardList = CreditCardSteven.retrieveSavedCards('');
        List<SelectOption> optionList = CreditCardSteven.toSelectOptions(cardList);
        // Checks if cardList and optionList aren't empty
        Assert.areNotEqual(null, cardList);
        Assert.areNotEqual(null, optionList);
        // Checks each object in the list if it's a CreditCard
    }
}