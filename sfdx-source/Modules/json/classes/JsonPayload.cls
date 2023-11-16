public class JsonPayload {



    JSONGenerator gen;
    


    public JsonPayload() {
        gen = JSON.createGenerator(true);
    }


    /*
    public void writeObjectField(String fieldName, IOrderedMap obj) {
        gen.writeFieldName(fieldName);
        //JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        // serialize address object into a String
        Map<String,Object> it = obj.toMap();
        // iterate through the map calling gen.writeStringField() if value or if not value call gen.writeNullField()
        for(String key : obj.keySet()) {
            String value = (String)it.get(key);
            if(null == value) {
                gen.writeNullField(key);
            }
            else {
                gen.writeStringField(key, value);
            }

        }
        gen.writeEndObject();
    }
    */


    public void writeObjectField(String fieldName, Object obj) {

        if(obj instanceof IOrderedMap) {
            this.writeObjectFields(fieldName, (IOrderedMap)obj);
        }
        else gen.writeObjectField(fieldName, obj);
    }

    public void writeObjectFields(IOrderedMap obj) {
        writeObjectFields(null, obj);
    }

  

    public void writeObjectFields(String fieldName, IOrderedMap obj) {

        // Convert obj to a Map.
        Map<String,Object> it = obj.toMap();
        
        if(null != fieldName) {
            gen.writeFieldName(fieldName);
            gen.writeStartObject();
        }
        // iterate through the map calling gen.writeStringField() if value or if not value call gen.writeNullField()
        for(String key : obj.keySet()) {

            Object value = it.get(key);

            // Test the type of value:
            if(value instanceof IOrderedMap) {
                System.debug('found authnet object');
                this.writeObjectFields(key, (IOrderedMap)value);  
            } else if(value instanceof String) {
                this.writeStringField(key, (String)value);
            } else if(value instanceof Integer) {
                this.writeNumberField(key, (Integer)value);
            } else if(null == value) {
                this.gen.writeNullField(key);
            } else {
                this.writeObjectField(key, value);
            }

        }

        if(null != fieldName) {
            gen.writeEndObject();
        }
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

    public void writeNumberField(String fieldName, INteger fieldValue) {
        gen.writeNumberField(fieldName, fieldValue);
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