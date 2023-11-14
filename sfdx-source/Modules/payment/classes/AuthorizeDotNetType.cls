public virtual class AuthorizeDotNetType {
    protected List<String> orderedFieldList;

    public AuthorizeDotNetType() {

    }

    public virtual String getBody() {
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        // serialize address object into a String
        String json_instance = Json.serialize(this);
        // deserialize address String into Map<String, Object>
        Map<String, Object> untyped_instance = (Map<String, Object>)JSON.deserializeUntyped(json_instance);
        // iterate through the map calling gen.writeStringField() if value or if not value call gen.writeNullField()
        for(String key : orderedFieldList) {
            String value = (String)untyped_instance.get(key);
            if(value != null) {
                gen.writeStringField(key, value);
            }
            else {
                gen.writeNullField(key);
            }

        }
        gen.writeEndObject();
        return gen.getAsString();
    }
}