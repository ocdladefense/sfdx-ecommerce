public virtual class AuthorizeDotNetType {
    protected List<String> orderedFieldList = new List<String>();
    protected Map<String, Object> props = new Map<String, Object>();

    public AuthorizeDotNetType() {

    }

    public List<String> getOrderedFieldList() {
        return orderedFieldList;
    }

    public Map<String, Object> getProps() {
        return props;
    }

    public void setProp(String key, Object value) {
        this.props.put(key, value);
    }

    public Object get(String key) {
        return this.props.get(key);
    }

    public void setOrderedFieldList(List<String> fieldList) {
        this.orderedFieldList = fieldList;
    }

    public void addField(String key) {
        this.orderedFieldList.add(key);
    }
}