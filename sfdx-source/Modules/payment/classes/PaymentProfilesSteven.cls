public class paymentProfilesSteven {

    public static String getJSONResponse(String url) {
        Http client = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://appdev.ocdla.org/customer/905372692/cards');
        HttpResponse response = http.send(request);
        return response.getBody();
    }

    public static Map<String, Object> parseJSON(String jsonPayload) {
        Map<String, Object> parsedData = (Map<String, Object>) JSON.deserializeUntyped(jsonPayload);
        return parsedData;
    }

    /* Map<String,Map<String,String>> cards = JSON.deserialize(body, Map<String,Map<String,String>>.class); */
}