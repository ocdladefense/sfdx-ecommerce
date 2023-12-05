
public class HttpServiceMock implements HttpCalloutMock {
    


    public HttpServiceMock() {}


    
    public HttpResponse respond(HttpRequest req) {

        HttpResponse resp = new HttpResponse();
        

        resp.setBody('<html></html>');
        resp.setStatusCode(200);
        resp.setStatus('Apex generated Mock HttpResponse.');

        return resp;
    }

}