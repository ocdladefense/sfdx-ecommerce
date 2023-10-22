
@isTest
public with sharing class PaymentProfileTestMCW {
    @isTest static void testForTest(){
        Test.startTest();
        Integer i = 1;
        Test.stopTest();
        System.assertEquals(1, i);
    }
}