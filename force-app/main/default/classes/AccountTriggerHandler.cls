public class AccountTriggerHandler {
    
    public static void createContactIfAccountCreated(list<Account> newList){
        list<Contact> conList = new list<Contact>();
        for(Account acc:newList){
            Contact con = new Contact();
            con.LastName =acc.name;
            //con.AccountId=acc.Id;
            conList.add(con);
        }
        if(!conList.isEmpty()){
            insert conList;
        }
    }
    
    public static void deleteContactWithSameAccountName(list<Account> newList){
        set<string> accNameList = new set<string>();
        for(Account acc: newList){
            accNameList.add(acc.name);
        }
        
        list<Contact> conList = new list<Contact>();
        conList = [SELECT id, FirstName, LastName From Contact WHERE LastName in :accNameList];
        
        delete conList;
    }
    
    public static void validateDuplicateAccount(list<Account> newList){
        
        set<string> nameList = new set<string>();
        for(Account acc : newList){
            nameList.add(acc.name);
        }
        list<Account> accList = new list<Account>();
        accList = [SELECT id, Name FROM Account WHERE Name IN : nameList];
        
        set<string> duplicateName = new set<string>();
        for(Account acc: accList){
            duplicateName.add(acc.name);
        }
        
        for(Account acc: newList){
            if(duplicateName.contains(acc.name)){
                acc.addError('Duplicate Account Name');
            }
        }
    }
    
    public static void addPrefixMr(list<Account> newList){
        
        for(Account acc:newList){
            if(!acc.Name.startsWith('Mr')){
                acc.name = 'Mr. ' + acc.name;
            }
        }
    }
    
    public static void updateAssociatedContact(list<Account> newList){
        
        map<id, string> accMap = new map<id, string>();
        for(Account acc:newList){
            accMap.put(acc.id,acc.Phone);
        }
        
        list<Contact> conList = [SELECT id, Phone, AccountId FROM Contact WHERE AccountId IN :accMap.keyset()];
        
        list<Contact> updateContactList = new list<Contact>();
        for(Contact con:conList){
            if(con.AccountId != null){
                con.Phone = accMap.get(con.AccountId);
                updateContactList.add(con);
            }
        }
        if(updateContactList.size()>0) {
            update updateContactList;
        }
    }
    
    public static void countContact(list<Account> newList){
        
        set<id> AccountIds = new set<id>();
        for(Account acc: newList){
            AccountIds.add(acc.id);
        }
        
        List<Account> accList = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIds];
        
        List<Account> accountsToUpdate = new List<Account>();
        
        for(Account acc : accList){
            acc.Count_of_Contact__c = acc.Contacts.size();
            accountsToUpdate.add(acc);
        }
        
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
        
    }
    
    public static void amountSumOpp(list<Account> newList){
        
        set<id> AccountIds = new set<id>();
        for(Account acc: newList){
            AccountIds.add(acc.id);
        }
        
        List<Opportunity> oppList = [SELECT Amount, AccountId FROM Opportunity WHERE AccountId IN :AccountIds];
        
    }
    
    public static void billShippingAddress(list<Account> newList){
        for(Account acc: newList){
            if (acc.ShippingStreet != null && acc.BillingStreet == null){
                acc.BillingStreet = acc.ShippingStreet;
                acc.BillingCity = acc.ShippingCity;
                acc.BillingCountry = acc.ShippingCountry;
                acc.BillingState = acc.ShippingState;
                acc.BillingPostalCode = acc.ShippingPostalCode;
            }
            
            else if(acc.BillingStreet != null && acc.ShippingStreet == null){
                acc.ShippingStreet = acc.BillingStreet;
                acc.ShippingCity = acc.BillingCity;
                acc.ShippingCountry = acc.BillingCountry;
                acc.ShippingState = acc.BillingState;
                acc.ShippingPostalCode = acc.BillingPostalCode;
            } 
        }
        
    }    
}