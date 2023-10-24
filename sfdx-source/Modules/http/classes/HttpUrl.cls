public class HttpUrl {

    
    private Map<String,String> params;
    
    private String url;
    
    
    public HttpUrl(String url) {
        this.params = new Map<String,String>();
        this.url = url;
    }
      
    
    public void addParam(String key) {
        this.addParam(key, null);
    }

    public void addParam(String key, String value) {
        this.params.put(key,value);
    }

    public Map<String,String> getParams() {
        return this.params;
    } 

    public String getParamsAsQueryString() {
		return encodeParams(this.params);
    }
    
    public static String encodeParams(Map<String,String> params, String mimeType) {
        if('application/x-www-form-urlencoded' == mimeType) {
            String[] kvp = new String[]{};
            String result = '';
            
            for(String key : params.keySet()) {
                String value = params.get(key);
                String[] parts = new String[]{key,params.get(key)};
                
                kvp.add(value == null ? key : String.join(parts,'='));
            }
    
            return String.join(kvp,'&');
        }
        
        return JSON.serialize(params);
    }
    
    public static String encodeParams(Map<String,String> params) {
        return encodeParams(params,'application/x-www-form-urlencoded');
    }
    
    public PageReference getAsPageReference() {
        return new PageReference(this.toString());
    }  
    
    public override String toString() {
        String query = this.getParamsAsQueryString();
        
        return String.isBlank(query) ? this.url : (this.url + '?' + query);
    }
    
}