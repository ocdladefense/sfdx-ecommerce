public with sharing class AuthNetAddressCollection {
    

    public List<AuthNetAddress> addresses;

    public List<AuthNetAddress> authNetAddresses;
    
    public Map<String, Object> theMap =new Map<String, AuthNetAddress>();

    public AuthNetAddressCollection() {

        this.addresses= new List<AuthNetAddress>();
    }
    
    public AuthNetAddressCollection(List<AuthNetAddress> addresses) {
        
        List<AuthNetAddress> tmp = addresses;
        
        
		List<AuthNetAddress> options = new List<AuthNetAddress>();
        
       	List<AuthNetAddress> defaultFirst = new List<AuthNetAddress>();
        
        for(AuthNetAddress addy : tmp) {

            theMap.put(addy.getCustomerAddressId(), addy);

            if(addy.isDefault()) {
                defaultFirst.add(addy);
            }
              
            else {
            	
                options.add(addy);
            }
        }
        
        // Effectively appends others *after the default option,
        // keeping the default first in the list.
        defaultFirst.addAll(options);
        
        this.addresses = defaultFirst;
    }
    
    public List<AuthNetAddress> getAsList() {
        return this.addresses;
    }
    
    
    public AuthNetAddress getDefault() {
        return this.size() > 0 ? this.addresses[0] : null;
    }
    
    public Integer size() {
        return null == this.addresses ? 0 : this.addresses.size();
    }

    public Integer getsSize() {
        return null == this.addresses ? 0 : this.addresses.size();
    }


}