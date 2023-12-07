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

    @isTest static void creditCardExpiration() {
        // Constructor a new and a expired card
        String userInput = '04/2026';
        String formattedDate = AuthorizeDotNet.formatDateString(userInput);
        CreditCard card = new CreditCard('4444222211111111', formattedDate, '123');
        CreditCard expiredCard = new CreditCard('44', AuthorizeDotNet.formatDateString('04/2001'), '123');
        
        // Testing expiration card
        System.assertEquals(false, card.isExpired());
        System.assertEquals(true, expiredCard.isExpired());
    }

    @isTest static void creditCardValidation() {
        // Constructor a valid and invalid card
        String userInput = '04/2026';
        String formattedDate = AuthorizeDotNet.formatDateString(userInput);
        CreditCard validCard = new CreditCard('4444222211111111', formattedDate, '123');
        CreditCard invalidCard = new CreditCard('44', AuthorizeDotNet.formatDateString('04/2001'), '123');
        
        // Testing card validation
        System.assertEquals(true, validCard.isValid());
        System.assertEquals(false, invalidCard.isValid());
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

    @isTest static void paymentProfileGettersAndSetters() {
        // Initiailizing variables
        Address address = new Address('Sebastian', 'Berna', '214 NW Monroe Ave', 'Corvallis', 'OR', '97330');
        CreditCard card = new CreditCard('4111111111111122','11/2024');
        Payment payment = new Payment(card);

        CreditCard cardForMap = new CreditCard('4111111111115555','05/2028');
        Payment payForMap = new Payment(cardForMap);
        Address addrForMap = new Address('Map', 'Mapperton', '365 Map Rd', 'New Map', 'Map-opolis', '78542');

        CustomerPaymentProfile paymentProfile = new CustomerPaymentProfile();
        Map<String,Object> cardMap = payForMap.toMap();
        Map<String,String> addrMap = new Map<String,String> {
            'firstName' => 'Map',
            'lastName' => 'Mapperton',
            'address' => '365 Map Rd',
            'city' => 'New Map',
            'state' => 'Map-opolis',
            'zip' => '78542',
            'country' => 'US'
        };

        // Assert variables are null
        System.assertEquals(null, paymentProfile.getPayment());
        System.assertEquals(null, paymentProfile.getBillTo());

        // Setters
        paymentProfile.setBillTo(address);
        paymentProfile.setPayment(payment);
        paymentProfile.setCard(card);

        // Getters
        paymentProfile.getBillTo();
        paymentProfile.getPayment();
        paymentProfile.getPayment().getCreditCard();
        paymentProfile.addField('testFieldBlank');
        paymentProfile.put('testFieldInt', 1);
        String getFromType = (String)paymentProfile.get('customerPaymentProfileId');

        // Assert setters worked
        System.assertEquals(address, paymentProfile.getBillTo());
        System.assertEquals(card, paymentProfile.getPayment().getCreditCard());
        System.assertEquals(paymentProfile.getCustomerPaymentProfileId(), getFromType);

        // Tests FromMap methods
        card = CustomerPaymentProfile.newCardFromPaymentMap(cardMap);
        address = CustomerPaymentProfile.newAddressFromMap(addrMap);
        
        System.assertEquals(cardForMap.getCardNumber(), card.getCardNumber());
        System.assertEquals(cardForMap.getExpirationDate(), card.getExpirationDate());
        System.assertEquals(addrForMap.getFirstName(), address.getFirstName());
    }
}