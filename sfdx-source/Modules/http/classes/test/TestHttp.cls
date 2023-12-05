@isTest
public class TestHttp {
    public TestHttp() {

    }

    @isTest
    private static void invokeClient() {

        Test.setMock(HttpCalloutMock.class, new HttpServiceMock());

        HttpClient client = new HttpClient();
        HttpRequestMessage req = new HttpRequestMessage();

        String endpoint1 = client.getEndpoint('notExist');
        client.addHeader('X-Custom-Client', 'X-Http-Client');

        HttpResponseMessage resp = client.send(req);

        try {
            throw new HttpException('ERROR');
        } catch(Exception e) {
            // System.assert(e instanceOf Exception);
        }


        // Instantiate a URL
        HttpUrl url = new HttpUrl('https://my.test.url/path');



        String mimeType = 'application/x-www-form-urlencoded';
        Map<String,String> params = new Map<String,String>{'foo' => 'bar'};

        String encoded = HttpUrl.encodeParams(params, mimeType);

        url.addParam('baz');
        url.addParam('pow','wham');

        params = url.getParams();

        String theUrl = url.toString();
    }


    @isTest
    private static void invokeRequest1() {
        HttpRequestMessage req = new HttpRequestMessage();

        req.setHeader('Content-Type','application/json');

        String value = req.getHeader('Content-Type');
        Map<String,String> headers = req.getHeaders();

        req.setBody('{}');

        Object theBody = req.deserializeBody();

        String b1 = req.getBody();
        Blob b2 = req.getBodyAsBlob();
        Map<String,String> m1 = req.getBodyAsMap();


        req.setBody('<html></html>');
        Dom.Document doc1 = req.getBodyDocument();
    }


    @isTest
    private static void invokeRequest2() {
        HttpRequestMessage req = new HttpRequestMessage();

        req.setEndpoint('https://my.test.com/service');
        req.setMethod('POST');
        req.addParam('foo');
        req.addParam('foo','bar');
        
        req.setHeader('Content-Type','application/json');
        req.setBody('<html></html>');
        req.setBody(new Map<String,String>{'foo' => 'bar'});
        req.formatBody(new Map<String,String>{'foo' => 'bar'});
        Map<String,String> params = req.getParams();
        String theEndpoint = req.getEndpoint();
        String theParams = req.getParamsAsQueryString();

        HttpRequest req2 = req.getAsHttpRequest();
    }


    @isTest
    private static void invokeResponse() {
        HttpResponse r1 = new HttpResponse();

        r1.setHeader('Content-Type','application/json');

        HttpResponseMessage resp = new HttpResponseMessage();
        resp = new HttpResponseMessage(r1);
    }
}