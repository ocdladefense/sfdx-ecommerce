public class AuthorizeDotNetServiceMock implements HttpCalloutMock {
    public AuthorizeDotNetServiceMock() {

}

    public HttpResponse respond(HttpRequest req) {
        System.debug('making a responde request');
        HttpResponse resp = new HttpResponse();

        
        
        
        String mockType = req.getHeader('X-Request-Type')+'MockResponse';
        System.Type t = Type.forName(mockType);

        IMockResponse mock = (IMockResponse)t.newInstance();

        resp.setHeader('Content-Type', 'application/json');
        resp.setBody(mock.getBody());
        resp.setStatusCode(200);
        resp.setStatus('Apex generated Mock HttpResponse.');
        // resp.setHeader('X-Request-Type')

        return resp;
    }
}