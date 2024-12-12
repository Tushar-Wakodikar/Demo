public class MainClass {
    @testvisible //It is used to visible method only to test class
    static integer Sumation(integer num1, integer num2){
        integer sum = num1+num2;
        return sum;
    }
    public static void updateAccount(string name){
        list<Account> updateAccList = new list<Account>();
        list<Account> accList = [SELECT id, Name From Account WHERE Active__C = 'No' and Name =:name];
        if(accList.size()>0){
            for(Account acc:accList){
                acc.Active__c = 'Yes';
                updateAccList.add(acc);
            }
            update updateAccList;
        }
    }
    public static void updateAccountInfo(string name){
        list<Account> updateAccList = new list<Account>();
        list<Account> accList = [SELECT id, Name, Active__c From Account WHERE AccountNumber = '9999' and Name =:name];
        if(accList.size()>0){
            for(Account acc:accList){
                if(acc.Active__c == 'Yes'){
                    acc.AccountNumber = '1234';
                } else{
                    acc.AccountNumber = '123456';
                }
                updateAccList.add(acc);
            }
            update updateAccList;
        }
    }
}