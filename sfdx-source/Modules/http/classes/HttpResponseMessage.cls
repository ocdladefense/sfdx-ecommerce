public class HttpResponseMessage extends HttpMessage {
    public HttpResponseMessage() {

    }

    public HttpResponseMessage(HttpResponse resp) {
        List<String> headers = resp.getHeaderKeys();

        
        for(String key : headers) {
            this.setHeader(key,resp.getHeader(key));
        }

        this.body = resp.getBody();
    }


}