public class paymentProfilesSteven {
    public static String getJSONResponse(String url) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        HttpResponse response = http.send(request);
        return response.getBody();
    }
}