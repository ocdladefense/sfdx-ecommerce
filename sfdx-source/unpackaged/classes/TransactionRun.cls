public class TransactionRun {




    public void chargeCard() {

        // Mara's customer.
        Customer c = new Customer('916376196');

        // AuthNet customer profile.
        CustomerProfile profile = c.getCustomerProfile();

        // If they've indicated a default payment profile...
        // CustomerPaymentProfile defaultPaymentMethod = profile.getDefaultPaymentProfile();

        // Simplest transaction needs only an amount.
        Decimal orderTotal = 45.00; // example order amount to be charged.


        AuthNetTransaction tx = new AuthNetTransaction(orderTotal);

        // Uncomment to pay with card details instead of profile.
        //tx.payWith('4111111111111111', '2024-10');
        tx.useCustomerProfile(profile);

        CreateTransactionRequest req = new CreateTransactionRequest(tx);
        System.debug(req.getBody());
        AuthorizeDotNetClient client = new AuthorizeDotNetClient();

        AuthorizeDotNetResponse resp = client.send(req);

        System.debug(resp.getBody());
    }
}