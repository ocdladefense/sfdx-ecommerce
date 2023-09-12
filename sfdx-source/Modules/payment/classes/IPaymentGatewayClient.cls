public interface IPaymentGatewayClient {

    TransactionResponse send(TransactionRequest req);
}