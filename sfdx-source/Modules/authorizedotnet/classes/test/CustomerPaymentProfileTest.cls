@isTest 
public class CustomerPaymentProfileTest {
    public CustomerPaymentProfileTest() {

    }

    @isTest static void paymentProfileVariableConstructors() {
        // Testing CreditCard constructors
        CreditCard card = new CreditCard();
        card = new CreditCard('4444222211111111');
        card = new CreditCard('4444222211111111', '04/2026');
        card = new CreditCard('4444222211111111', '04/2026', '123');

        // Testing Address constructors
        Address address = new Address();
        address = new Address('Sebastian', 'Berna', '214 NW Monroe Ave', 'Corvallis', 'OR', '97330');
        address = new Address('Sebastian', 'Berna', '214 NW Monroe Ave', 'Corvallis', 'OR', '97330', 'US');

        // Testing Payment constructors
        Payment payment = new Payment();
        payment = new Payment(card);

        // Testing CustomerPaymentProfile constructors
        CustomerPaymentProfile paymentProfile = new CustomerPaymentProfile();
        paymentProfile = new CustomerPaymentProfile(card, address);
    }

    @isTest static void creditCardValidation() {
        // Constructor a valid and invalid card
        CreditCard validCard = new CreditCard('4444222211111111', '04/2026', '123');
        CreditCard invalidCard = new CreditCard('44','04/2001', '123');
        
        // Testing valid card
        System.assertEquals(true, validCard.isValid());
        System.assertEquals(false, validCard.isExpired());

        //t Testing invalid card
        System.assertEquals(false, invalidCard.isValid());
        System.assertEquals(true, invalidCard.isExpired());
    }

    @isTest static void creditCardGettersAndSetters() {
        // Variables for setters and comparing getters
        CreditCard card = new CreditCard();
        String cardNum = '4444222211111111';
        String cardExp = '04/2026';
        String cardCVV = '123';

        // Setters
        card.setCardNumber(cardNum);
        card.setExpirationDate(cardExp);
        card.setCvv(cardCVV);

        // Getters
        System.assertEquals(cardNum, card.getCardNumber());
        System.assertEquals(cardExp, card.getExpirationDate());
        System.assertEquals(cardCVV, card.getCVV());
        System.assertEquals('Visa', card.getType());
    }

    @isTest static void addressGettersAndSetters() {
        // All variables for the setters and comparing getters
        Address address = new Address();
        String pKeyName = 'customerAddressId';
        String pKeyValue = '12345';
        String fName = 'Sebastian';
        String lName =  'Berna';
        String company = 'Google Inc.';
        String phoneNum = '123-456-7890';
        String faxNum = '67890';
        String email = 'seberna@gmail.com';
        String stAdd = '214 NW Monroe Ave';
        String city = 'Corvallis';
        String state = 'OR';
        String zipCode = '97330';
        String country = 'US';

        // Setters
        address.setCustomerAddressId(pKeyValue);
        address.setFirstName(fName);
        address.setLastName(lName);
        address.setCompany(company);
        address.setPhoneNumber(phoneNum);
        address.setFaxNumber(faxNum);
        address.setEmail(email);
        address.setAddress(stAdd);
        address.setCity(city);
        address.setState(state);
        address.setZip(zipCode);
        address.setCountry(country);

        // Getters
        System.assertEquals('customerAddressId', address.getPrimaryKeyField());
        System.assertEquals(pKeyValue, address.getPrimaryKeyValue());
        System.assertEquals(fName, address.getFirstName());
        System.assertEquals(lName, address.getLastName());
        System.assertEquals(company, address.getCompany());
        System.assertEquals(phoneNum, address.getPhoneNumber());
        System.assertEquals(faxNum, address.getFaxNumber());
        System.assertEquals(Email, address.getEmail());
        System.assertEquals(stAdd, address.getAddress());
        System.assertEquals(city, address.getCity());
        System.assertEquals(state, address.getState());
        System.assertEquals(zipCode, address.getZip());
        System.assertEquals(country, address.getCountry());
    }
}