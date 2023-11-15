public interface IOrderedMap {

    Map<String, Object> toMap();

    void put(String key, Object value);

    Object get(String key);

    void setFields(List<String> fieldList);

    void addField(String key);

    List<String> keySet();
}