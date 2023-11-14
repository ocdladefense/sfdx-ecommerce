public class CreateCustomerShippingAddressRequest extends AuthorizeDotNetRequest {
    //no merchant info needed
    private String customerProfileId;
    private Address address;
    private Boolean defaultShippingAddress = false;

public CreateCustomerShippingAddressRequest() {
    super('createCustomerShippingAddress');
}

public CreateCustomerShippingAddressRequest(Address address) {
    this();
    this.address = address;
}






public void setCustomerProfileId(String customerProfileId) {
    this.customerProfileId = customerProfileId;
}

public void setAddress(Address address) {
    this.address = address;
}

public void setDefaultShippingAddress(Boolean defaultShippingAddress) {
    this.defaultShippingAddress = defaultShippingAddress;
}

public String getCustomerProfileId() {
    return this.customerProfileId;
}

public Address getAddress() {
    return this.address;
}

public Boolean getDefaultShippingAddress() {
    return this.defaultShippingAddress;
}


public override String getBody() {

    
    
    JsonPayload payload = new JsonPayload();

    payload.writeStartObject();
    payload.writeFieldName(this.requestType+'Request');
    payload.writeStartObject();
    payload.writeObjectField('merchantAuthentication', this.merchantAuthentication);
    

    // Continue processing the JSON for the request.
    payload.writeStringField('customerProfileId', this.customerProfileId);
    payload.writeObjectField('address', this.address);
    
    payload.writeBooleanField('defaultShippingAddress', getDefaultShippingAddress());
    payload.writeEndObject();
    payload.writeEndObject();
    // Use the generator to create one or more objects for the payload json,
    // *in the exact order as required by the Authorize.net documentation.
    return payload.getAsString();
}
}