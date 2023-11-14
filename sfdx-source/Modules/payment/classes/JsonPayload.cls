public with sharing class JsonPayload {
    JSONGenerator gen;
    
    public JsonPayload() {
        gen = JSON.createGenerator(true);
    }

    public void writeObjectField(String fieldName, AuthorizeDotNetType obj) {
        gen.writeFieldName(fieldName);
        //JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        // serialize address object into a String
        String json_instance = Json.serialize(obj);
        // deserialize address String into Map<String, Object>
        Map<String, Object> untyped_instance = (Map<String, Object>)JSON.deserializeUntyped(json_instance);
        // iterate through the map calling gen.writeStringField() if value or if not value call gen.writeNullField()
        for(String key : obj.getOrderedFieldList()) {
            String value = (String)untyped_instance.get(key);
            if(value != null) {
                gen.writeStringField(key, value);
            }
            else {
                gen.writeNullField(key);
            }

        }
        gen.writeEndObject();
    }

    public void writeObjectField(String fieldName, Object obj) {
        gen.writeObjectField(fieldName, obj);
    }

    public void writeStartObject() {
        gen.writeStartObject();
    }

    public void writeFieldName(String fieldName) {
        gen.writeFieldName(fieldName);
    }

    public void writeStringField(String fieldName, String fieldValue) {
        gen.writeStringField(fieldName, fieldValue);
    }

    public void writeBooleanField(String fieldName, Boolean value) {
        gen.writeBooleanField(fieldName, value);
    }

    public void writeEndObject() {
        gen.writeEndObject();
    }

    public String getAsString() {
        return gen.getAsString();
    }
}