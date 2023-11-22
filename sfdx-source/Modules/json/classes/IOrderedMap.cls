public interface IOrderedMap {

    Map<String, Object> toMap();

    void setFields(Set<String> fieldList);

    void addField(String key);

    Set<String> keySet();

    void ignoreField(String field);

    Set<String> getIgnoredFields();
}