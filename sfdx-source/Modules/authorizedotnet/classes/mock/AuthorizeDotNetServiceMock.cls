public class AuthorizeDotNetServiceMock implements HttpCalloutMock {
    


    public AuthorizeDotNetServiceMock() {}


    
    public HttpResponse respond(HttpRequest req) {
        //System.debug('making a respond request');

        HttpResponse resp = new HttpResponse();
        
        String requestType = req.getHeader('X-Request-Type');

        System.debug(requestType);

        String responseType = requestType.capitalize()+'MockResponse';
       
 

        System.Type t = Type.forName(responseType);
        if(t == null) {
            throw new AuthorizeDotNetException('Could not find type matching to ' + responseType);
        }
        IMockResponse mock = (IMockResponse)t.newInstance();


        resp.setHeader('Content-Type', 'application/json');
       
        String theBody = mock.getBody();
        
        if(theBody == null) {
            throw new AuthorizeDotNetException('mock.getBody should not return a null value. ' + responseType);
        }

        resp.setBody(mock.getBody());
        resp.setStatusCode(200);
        resp.setStatus('Apex generated Mock HttpResponse.');
 
        //System.debug('The mock response status code is ' + codeForDebug);
        return resp;
    }

}