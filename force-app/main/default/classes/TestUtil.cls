public class TestUtil {
    public static Account createAccount(string name, string AccountNumber, string Active){
        Account acc = new Account();
        acc.Name = name;
        acc.AccountNumber = AccountNumber;
        acc.Active__c = Active; 
        return acc;
    }

}