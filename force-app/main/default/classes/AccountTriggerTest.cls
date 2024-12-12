@isTest
public class AccountTriggerTest {
    @testSetup
    public static void accountCreate(){
        List<Account> accList = new List<Account>();
        for(Integer i=1; i<500; i++){
            Account acc = new Account();
            acc.Name = 'TestTrigger'+i;
            string dest;
            if(i>0 && i<251){
                dest = null;
            }else{
                dest = 'India; Pakistan; United Kingdom';
            }
            acc.Destination__c = dest;
            accList.add(acc);
        }
        insert accList;
    }
    
    @isTest
    public static void createDestinationContactTest(){
        List<Account> acclist = [SELECT id, Name, Destination__c, (SELECT id, LastName, AccountId from Contacts) From Account Where Name LIKE 'TestTrigger%' AND Destination__c = null];
        //Contact con = [SELECT id, LastName, AccountId from Contact Where AccountId =:acclist[6].Id];
        //system.assertEqual
        for(Account acc:acclist){
            system.assertEquals(0, acc.contacts.size(), 'Zero Contact');
        }
        List<Account> updateAccount = new List<Account>();
        for(Account acc:accList){
            acc.Destination__c =  'India;Switzerland';
            updateAccount.add(acc);
        }
        update updateAccount;
        List<Account> acclist1 = [SELECT id, Name, Destination__c, (SELECT id, LastName, AccountId from Contacts) From Account Where id IN:updateAccount];
        for(Account acc1:acclist1){
            system.assertEquals(2, acc1.contacts.size(), 'Two Contact');
        }
        List<Account> acclist2 = [SELECT id, Name, Destination__c, (SELECT id, LastName, AccountId from Contacts) From Account Where Name LIKE 'TestTrigger%' AND Destination__c = 'India; Pakistan; United Kingdom'];
        for(Account acc2:acclist2){
            system.assertEquals(3, acc2.contacts.size(), 'Three Contact');
        }
        List<Account> updateAccount1 = new List<Account>();
        for(Account acc2:acclist2){
            acc2.Destination__c = 'India';
            updateAccount1.add(acc2);
        }
        update updateAccount1;
        List<Account> acclist3 = [SELECT id, Name, Destination__c, (SELECT id, LastName, AccountId from Contacts) From Account Where id IN:updateAccount1];
        for(Account acc3:acclist3){
            system.assertEquals(1, acc3.contacts.size(), 'One Contact');
        }
        List<Account> acclist4 = [SELECT id, Name, Destination__c, (SELECT id, LastName, AccountId from Contacts) From Account Where Name LIKE 'TestTrigger%' AND Destination__c = 'India'];
        system.debug('Test size -'+acclist4.size());
        List<Account> updateAccount2 = new List<Account>();
        for(Account acc2:acclist4){
            acc2.Destination__c = null;
            updateAccount2.add(acc2);
        }
        update updateAccount2;
        List<Account> acclist5 = [SELECT id, Name, Destination__c, (SELECT id, LastName, AccountId from Contacts) From Account Where id IN:updateAccount2];
        for(Account acc5:acclist5){
            system.assertEquals(0, acc5.contacts.size(), 'One Contact');
        }
    }
}