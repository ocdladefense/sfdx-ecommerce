public class Url {

    public static String formatQueryString(Map<String,String> params) {
        if(null == params || params.size() == 0) return '';
        
        String[] parts = new String[]{};
            
        for(String name : params.keySet()){
            String[] tmp = new String[]{name};
            String value = params.get(name);
            if(null != value && '' != value.trim()) {
                tmp.add(value);
            }

            parts.add(String.join(tmp,'='));
        }
        
        return parts.size() > 0 ? ('?'+String.join(parts,'&')) : '';
    }
    
    public static Boolean isAbsoluteUrl(String url) {
		return null != url && url.startsWith('http');
    }
    
}