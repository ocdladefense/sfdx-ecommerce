@isTest
public class ShippingAddressRequestTest {
    public ShippingAddressRequestTest() {

    }

    @isTest static void updateCustomerShippingAddress() {

        UpdateCustomerShippingAddressRequest req = new UpdateCustomerShippingAddressRequest();
        req.setCustomerProfileId('1234');
        Address newAddress = new Address('J.', 'Berna', '214 NW Monroe Ave', 'Albany', 'OR', '97330');
        newAddress.setCompany('OCDLA');
        req.setAddress(newAddress);

       
        String result = req.getBody();
        Integer indexMerchantAuthentication = result.indexOf('merchantAuthentication');
        Integer indexCustomerProfileId = result.indexOf('customerProfileId');
        Integer indexAddress = result.indexOf('address');
        Integer indexDefaultShippingAddress= result.indexOf('defaultShippingAddress');
        Integer startObjectMatches = result.countMatches('{');

        System.debug(result);

        System.assert(indexMerchantAuthentication<indexCustomerProfileId);
        System.assert(indexCustomerProfileId<indexAddress);
        System.Assert(indexAddress<indexDefaultShippingAddress);
        System.assert(4==startObjectMatches);


    }

    @isTest public void shippingAddressTypeConstructor(){
        Address newAddress = new Address('J.', 'Berna', '214 NW Monroe Ave', 'Albany', 'OR', '97330');
        ShippingAddress shippingAddress = new ShippingAddress(newAddress, 'getCustomerShippingAddress');
        shippingAddress.setCompany('OCDLA');
        shippingAddress.setCustomerAddressId('123');

        System.debug(shippingAddress);
        System.debug(shippingAddress.keySet());
        System.debug(shippingAddress.keySet().contains('customerAddressId'));
        System.Assert(shippingAddress.keySet().contains('customerAddressId'));

        ShippingAddress shippingAddress2 = new ShippingAddress('J.', 'Berna', '214 NW Monroe Ave', 'Albany', 'OR', '97330');
        System.debug(shippingAddress2);
        System.debug(shippingAddress2.keySet());

        System.debug(shippingAddress2.keySet().contains('customerAddressId'));
        System.Assert(!shippingAddress2.keySet().contains('customerAddressId'));

        shippingAddress2.setUpdateRequestFields();
        System.debug(shippingAddress2.keySet().contains('customerAddressId'));
        System.Assert(shippingAddress2.keySet().contains('customerAddressId'));


    }
}