public with sharing class accountRecordRetrive {
    @AuraEnabled(cacheable=true)
    public static list<Account> getAccount(string accountName){
        try {
            if(accountName == null){
                list<Account> accList = [SELECT Id, Name From Account LIMIT 5];
                return accList;
            }
            else {
                string srcText = '%'+accountName+'%';
            list<Account> accList = [SELECT Id, Name From Account WHERE Name LIKE :srcText LIMIT 5];
            return accList;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static list<Contact> getContact(id accountId){
        try {
            List<Contact> conList = [SELECT id, Name From Contact WHERE AccountId =: accountId];
            return conList;
        }
         catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}