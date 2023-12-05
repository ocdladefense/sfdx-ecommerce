public virtual class AuthorizeDotNetType implements IOrderedMap {

    // This list determines the order that data will be retrieved when we iterator over
    

    protected Map<String, Object> data = new Map<String, Object>();

    protected String primaryKeyField;

    protected Set<String> fields = new Set<String>();

    protected Set<String> ignoredFields = new Set<String>();




    public AuthorizeDotNetType() {
        this.fields = new Set<String>();
    }


    public void put(String key, Object value) {
        this.data.put(key, value);
    }


    public Object get(String key) {
        return this.data.get(key);
    }


    public virtual String getPrimaryKeyField() {
        return null;
    }

    // Create a getPrimaryKeyValue, gets
    public virtual String getPrimaryKeyValue() {
        return null;
    }

    public Set<String> getIgnoredFields() {
        return this.ignoredFields;
    }

    public void ignoreField(String fieldName) {
        if(this.ignoredFields == null) {
            this.ignoredFields = new Set<String>();
        }

        this.ignoredFields.add(fieldName);
    }

    public virtual Set<String> keySet() {
        return this.fields;
    }


    public void setFields(Set<String> fieldList) {
        this.fields = fieldList;
    }

    public void addField(String key) {
        this.fields.add(key);
    }

    public virtual Map<String,Object> toMap() {
        String theJson = this.data.values().size() > 0 ? JSON.serialize(this.data) : JSON.serialize(this);
        // deserialize address String into Map<String, Object>
        return (Map<String, Object>)JSON.deserializeUntyped(theJson);
    }
}