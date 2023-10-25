public class QueryRequest extends HttpRequestMessage {

    private String query;

    public QueryRequest() {

    }

    public void setQuery(String query) {
        this.query = query;
    }
}