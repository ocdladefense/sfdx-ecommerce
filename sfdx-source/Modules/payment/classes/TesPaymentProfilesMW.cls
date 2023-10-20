public with sharing class TesPaymentProfilesMW {
    public TesPaymentProfilesMW() {
    //each test begins with isTest annotation
    //each test needs to use AuthorizeDotNetMockResponse to get testable data without calling a server

    //three steps to test
    //fetch http payload and deserialize
    //convert deserialized payload to list of credit card types
    //convert list of credit card types to list of select options

    //what needs to be asserted
    //the count of the list is as expected

    //convert to CC objects
    //the data in the list matches the data expected
    //the datatype matches what is expected

    //convert to select options
    //exp is appended to correct card
    }
}