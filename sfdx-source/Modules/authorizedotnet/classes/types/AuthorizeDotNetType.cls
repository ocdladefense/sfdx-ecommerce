public virtual class AuthorizeDotNetType implements IOrderedMap {

    // This list determines the order that data will be retrieved when we iterator over
    protected Set<String> fields { get { return keySet(); } set { fields = value; } }

    protected Map<String, Object> data = new Map<String, Object>();

    protected String primaryKeyField{ get { return getPrimaryKeyField(); } set { primaryKeyField = value; } }

    public virtual String getPrimaryKeyField() {
        return primaryKeyField;
    }

    public AuthorizeDotNetType() {
        this.fields = new Set<String>();
    }


    public void put(String key, Object value) {
        this.data.put(key, value);
    }


    public Object get(String key) {
        return this.data.get(key);
    }

    // Create a getPrimaryKeyValue, gets
    public String getPrimaryKeyValue() {
        Map<String,Object> theMap = toMap();
        return theMap.get(primaryKeyField) != null ? (String)theMap.get(primaryKeyField) : null;
    }

    public void setFields(Set<String> fieldList) {
        this.fields = fieldList;
    }

    public void addField(String key) {
        this.fields.add(key);
    }

    public void removeField(String key) {
        this.fields.remove(key);
    }

    public void removePrimaryKeyField() {
        this.fields.remove(this.primaryKeyField);
    }

    public virtual Set<String> keySet() {
        return this.fields;
    }

    public virtual Map<String,Object> toMap() {
        String theJson = JSON.serialize(this);
        // deserialize address String into Map<String, Object>
        return (Map<String, Object>)JSON.deserializeUntyped(theJson);
    }
}