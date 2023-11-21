public interface IOrderedMap {

    Map<String, Object> toMap();

    void setFields(Set<String> fieldList);

    void addField(String key);

    Set<String> keySet();

    void removeField(String field);
}