@isTest
public class TestSerialization {

    @isTest
    private static void invokeType() {

        // Define a set of fields on an object to be serialized.
        Set<String> fields = new Set<String>{'f1','f2','f3'};

        AuthorizeDotNetType t1 = new AuthorizeDotNetType();
        t1.setFields(fields);
        t1.addField('f4');
        t1.ignoreField('f1');

        t1.put('f1','someID');
        t1.put('f2','myVal');
        t1.put('f3',5);
        t1.put('f4',True);

        String key = t1.getPrimaryKeyField();
        Object value = t1.getPrimaryKeyValue();
        
        Object var = t1.get('f3');

        Set<String> ignored = t1.getIgnoredFields();
        Set<String> keys = t1.keySet();


        try {
            JsonPayloadException.ErrorTypes theErrorType = JsonPayloadException.ErrorTypes.SERIALIZATION_ERROR;

            JsonPayloadException e = new JsonPayloadException(theErrorType, 'ERROR');
            String msg = e.getMessage();

        } catch(Exception e) {

        }
    }

    @isTest
    private static void invokeSerializer() {

        // Define a set of fields on an object to be serialized.
        Set<String> fields = new Set<String>{'f1','f2','f3'};

        AuthorizeDotNetType t1 = new AuthorizeDotNetType();
        t1.setFields(fields);
        t1.addField('f4');
        t1.addField('f5');
        t1.ignoreField('f1');

        t1.put('f1','someID');
        t1.put('f2','myVal');
        t1.put('f3',5);
        t1.put('f5',null);
        

        JsonPayload payload = new JsonPayload();

        // payload.writeStartObject();
        // payload.writeFieldName(this.requestType+'Request');
        payload.writeStartObject();
        // payload.writeObjectField('merchantAuthentication', this.merchantAuthentication);
        try {
            payload.writeObjectFields(t1);
        } catch(JsonPayloadException e) {


        }

        t1.put('f4',True);
        payload.writeObjectFields(t1);

       
        payload.writeEndObject();

        // payload.writeFieldName('foo');
        payload.writeStartObject();
        // payload.writeEndObject();
        payload.writeEndObject();

        String theJson = payload.getAsString();
    }
}