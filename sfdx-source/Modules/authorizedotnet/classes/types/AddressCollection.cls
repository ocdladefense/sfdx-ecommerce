public class AddressCollection {

    public List<Address> addresses;
    
    public Map<String, Object> theMap =new Map<String, Address>();

    public AddressCollection (){
        this.addresses= new List<Address>();
    }
    
    public AddressCollection(List<Address> addresses) {
        
        List<Address> tmp = addresses;
        
        
		List<Address> options = new List<Address>();
        
       	List<Address> defaultFirst = new List<Address>();
        
        for(Address addy : tmp) {

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
    
    public List<Address> getAsList() {
        return this.addresses;
    }
    
    
    public Address getDefault() {
        return this.size() > 0 ? this.addresses[0] : null;
    }
    
    public Integer size() {
        return null == this.addresses ? 0 : this.addresses.size();
    }

    public Integer getsSize() {
        return null == this.addresses ? 0 : this.addresses.size();
    }


}