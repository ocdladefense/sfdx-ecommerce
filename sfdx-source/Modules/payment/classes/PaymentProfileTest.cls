// Alex's class for testing fetching and converting credit card information
@isTest
private class PaymentProfileTest {
    // Tests the fetching of a users card(s)
    @isTest static void TestFetchCards() {
        Map<String,Map<String,String>> cards = CreditCard.fetchUsersCards();

        System.assertNotEquals(null, cards);
    }
    // Tests the conversion of JSON cards to the CreditCard class list as well as getters
    @isTest static void ConvertToCardTest() {
        List<CreditCard> cardList = CreditCard.retrieveSavedCards(customerProfileId);

        // Checks if list is not empty
        Assert.areNotEqual(0, cardList.size());
        // Checks each object in the list if it's a CreditCard and its getters work
        for (CreditCard c : cardList) {
            Assert.isInstanceOfType(c, CreditCard);
            Assert.isInstanceOfType(c.getId(), Integer);
            Assert.isInstanceOfType(c.getIsDefault(), Boolean);
            Assert.isInstanceOfType(c.getExpirationDate(), String);
            Assert.isInstanceOfType(c.getCardNumber(), String);
        }
    }
    // Tests the conversion of a list of CreditCard to a list of SelectOptions
    @isTest static void CardsToOptionsTest() {
        List<CreditCard> cardList = CreditCard.retrieveSavedCards(customerProfileId);
        List<SelectOption> optionList = CreditCard.toSelectOptions(cardList);
        // Checks if cardList and optionList aren't empty
        Assert.areNotEqual(null, cardList);
        Assert.areNotEqual(null, optionList);
        // Checks each object in the list if it's a CreditCard
        for (SelectOption o : optionList) {
            Assert.isInstanceOfType(o, SelectOption);
        }
    }
}