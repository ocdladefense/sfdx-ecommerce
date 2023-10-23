public with sharing class CreditCardFetchResponseMock implements HttpCalloutMock {
        
    public CreditCardFetchResponseMock() {
        
    }
    
    public HttpResponse respond(HttpRequest req) {
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String cardsEndpoint = 'https://appdev.ocdla.org/customer/905372692/cards';
        String body = req.getEndpoint() == cardsEndpoint ? savedCreditCardsResponseBody() : '{}';        
	
        res.setBody(body);
        res.setStatusCode(200);
        res.setStatus('Apex generated Mock HttpResponse.');
        
        return res;
    }

    public String savedCreditCardsResponseBody() {
        Map<String, Map<String,String>> creditCards = new Map<String, Map<String,String>> {
            '905264262' => new Map<String, string>{'isDefault'=>'true', 'id'=>'905264262', 'cardNumber'=>'XXXX4532', 'expirationDate'=>'2024-08', 'cardType'=>'visa', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'},
            '905264263' => new Map<String, string>{'isDefault'=>'false', 'id'=>'905264263', 'cardNumber'=>'XXXX4632', 'expirationDate'=>'2023-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'},
            '905264264' => new Map<String, string>{'isDefault'=>'false', 'id'=>'905264264', 'cardNumber'=>'XXXX4786', 'expirationDate'=>'2043-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'},
            '905264265' => new Map<String, string>{'isDefault'=>'false', 'id'=>'905264265', 'cardNumber'=>'XXXX4912', 'expirationDate'=>'2025-08', 'cardType'=>'mastercard', 'firstName'=>'John', 'lastName'=>'Doe', 'address'=>'123 Main St.', 'city'=>'Eugene', 'zip'=>'97402', 'state'=>'OR'}
        };

        return JSON.serialize(creditCards);
    }
}