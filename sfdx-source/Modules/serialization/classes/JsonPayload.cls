public class JsonPayload {



    JSONGenerator gen;
    


    public JsonPayload() {
        gen = JSON.createGenerator(true);
    }



    public void writeObjectField(String fieldName, Object obj) {

        if(obj instanceof AuthorizeDotNetType) {
            this.writeObjectFields(fieldName, (AuthorizeDotNetType)obj);
        }
        else gen.writeObjectField(fieldName, obj);
    }

    public void writeObjectFields(AuthorizeDotNetType obj) {
        writeObjectFields(null, obj);
    }

    public void writeObjectFields(IOrderedMap obj) {
        writeObjectFields(null, obj);
    }

    public void writeObjectFields(String fieldName, AuthorizeDotNetType obj) {
        String primaryKeyFieldName = obj.getPrimaryKeyField();
        String primaryKeyValue = obj.getPrimaryKeyValue();
       

        if(primaryKeyFieldName != null) {
            System.debug(primaryKeyFieldName + ' is: '+ primaryKeyValue);
        }
        if(primaryKeyValue == null && primaryKeyFieldName != null) {
            obj.ignoreField(primaryKeyFieldName);
            system.debug('ignored field ' + primaryKeyFieldName);
        }
        System.debug('leaving suthnet writeObjectfields');
        writeObjectFields(fieldName, (IOrderedMap)obj);
    }

    public void writeObjectFields(String fieldName, IOrderedMap obj) {
        
        // Convert obj to a Map.
        Map<String,Object> it = obj.toMap();
        
        if(null != fieldName) {
            gen.writeFieldName(fieldName);
            System.debug('JSON object ' + fieldName);
            gen.writeStartObject();
        }
        // iterate through the map calling gen.writeStringField() if value or if not value call gen.writeNullField()
        Set<String> keys = obj.keySet();

        //what if obj has no ignored fields
        if(obj.getIgnoredFields()!=null){
            keys.removeAll(obj.getIgnoredFields());
        }

        for(String key : keys) {

            if(!it.containsKey(key)) {
                throw new JsonPayloadException(JsonPayloadException.ErrorTypes.SERIALIZATION_ERROR,
                key + ' is not present in the specified object.');
            }
            Object value = it.get(key);

            //System.debug(key);
            // Test the type of value:
            if(value instanceof AuthorizeDotNetType) {
                System.debug('found authnet object for '+ key);
                this.writeObjectFields(key, (AuthorizeDotNetType)value);  
            } else if(value instanceof IOrderedMap) {
                System.debug('found IOrderedMap object for ' + key);
                this.writeObjectFields(key, (IOrderedMap)value);  
            } else if(value instanceof Boolean) {
                // System.debug('found boolean');
                if(value == null) continue;
                this.writeBooleanField(key, (Boolean)value); 
            } else if(value instanceof String) {
                //System.debug('string');
                this.writeStringField(key, (String)value);
            } else if(value instanceof Integer) {
                //System.debug('integer');
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