@isTest
public class MainClassTest {
    @testSetup
    public static void testData(){
        Account acc = new Account();
        acc.Name = 'Akshay';
        acc.Active__c = 'No';
        insert acc;
    }
    @isTest
    public static void SumationTest(){
        integer total = MainClass.Sumation(3,5);
        system.assertEquals(8,total,'Error in Actual and Expected');
    }
    @istest
    public static void updateAccountTest(){
        Account acc = [Select id, Name, Active__c From Account Where Name ='Akshay'];
        //Account acc=TestUtil.createAccount('Akshay','877','Yes');
        MainClass.updateAccount('Akshay');
    }
    @isTest
    public static void updateAccountInfoNegativeTest(){
        Account acc = [Select id, Name, Active__c From Account Where Name = 'Akshay'];
        acc.AccountNumber = '9999';
        update acc;
        MainClass.updateAccountInfo('Akshay');
    }
	@isTest
    public static void updateAccountInfoPositiveTest(){
        Account acc = [Select id, Name, Active__c From Account Where Name = 'Akshay'];
        acc.AccountNumber = '9999';
        acc.Active__c = 'Yes';
        update acc;
        MainClass.updateAccountInfo('Akshay');
    }
}