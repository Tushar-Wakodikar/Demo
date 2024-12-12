public class ContactTriggerHandler {
    
    public static void createContact(list<Contact> newList){
        
        set<Id> accountIds = new set<Id>();
        
        for(contact con:newList){
            if(con.AccountId !=null){
                accountIds.add(con.AccountId);
            }
        }
        
        map<Id, account> accountMap = new map<id, account>([SELECT Id, Name FROM Account WHERE id in :accountIds]);
        
        for(Contact cont:newList){
            if(cont.AccountId !=null && accountMap.containsKey(cont.AccountId)){
                Account acc = new Account();
                acc = accountMap.get(cont.AccountId);
                cont.FirstName = acc.Name;
            }
        }
    }
    
    public static void validateDuplicateEmail(list<Contact> newList){
        set<string> emailIds = new set<string>();
        for(Contact con :newList){
            emailIds.add(con.Email);
        }
        
        list<Contact> conList = new list<Contact>();
        conList=[SELECT Email FROM Contact WHERE Email in :emailIds];
        
        set<string> duplicateEmail = new set<string>();
        for(contact con :conlist){
            duplicateEmail.add(con.Email);
        }
        
        for(Contact con:newList){
            if(duplicateEmail.contains(con.Email)){
                con.addError('Duplicate Email exist ...........');
            }
        }
    }
    
    public static void updateAccountPhone(list<Contact> newList){
        
        set<id> AccountIds = new set<id>();
        for(Contact con:newList){
            if(con.AccountId !=null){
                AccountIds.add(con.AccountId);
            }
        }
        
        map<id, Account> accountMap = new map<id, Account>([SELECT id, Phone FROM Account WHERE id IN :AccountIds]);
        
        list<Account> accountsToUpdate = new list<Account>();
        for(Contact con : newList){
            if(con.AccountId !=null && con.Phone !=null){
                Account acc = accountMap.get(con.Accountid);
                if(acc !=null && acc.Phone == null){
                    acc.Phone = con.Phone;
                    accountsToUpdate.add(acc);
                }
            }
        }
        
        if(!accountsToUpdate.isEmpty()){
            update accountsToUpdate;
        }
        
    }
    
    public static void updateOpp(list<Contact> newList){
        
        map<id, string> conMap = new map<id, string>();
        for(Contact con : newList){
            conMap.put(con.AccountId, con.Phone);
        }
        
        List<Opportunity> oppList = [SELECT id, Phone__c, AccountId FROM Opportunity WHERE AccountId IN : conMap.keyset()];
        
        list<Opportunity> updateOpp = new list<Opportunity>();
        
        for(Opportunity opp : oppList){
            if(conMap.get(opp.AccountId) != null && opp.Phone__c != conMap.get(opp.AccountId)){
                opp.Phone__c = conMap.get(opp.AccountId);
                updateOpp.add(opp);
            }
        }
        
        if(!updateOpp.isEmpty()){
            update updateOpp;
        }
    }
    
    public static void uppdateAcc(list<Contact> newList){
        
        set<id> Accountids = new set<id>();
        
        for(Contact con : newList){
            if(con.AccountId != null){
                Accountids.add(con.Accountid);
            }
        }
        
        //list<Account> accList = [SELECT id,(SELECT id FROM Contacts) FROM Account WHERE Id IN :Accountids];
        
        map<id, integer> countMap = new map<id, integer>();
        
        /*for(Account acc : accList){
countMap.put(acc.id, acc.Contacts.size());		
}*/
        
        for (AggregateResult ar : [SELECT AccountId, COUNT(Id) FROM Contact WHERE AccountId IN :accountIds GROUP BY AccountId]) {
            countMap.put((Id) ar.get('AccountId'), (Integer) ar.get('expr0'));
        }
        
        list<Account> updateAccount = new list<Account>();
        
        for(id accid : countMap.keyset()){
            Account acc = new Account();
            acc.id = accid;
            acc.Count_of_Contact__c = countMap.get(acc.id);
            updateAccount.add(acc);
        }
        
        if(!updateAccount.isEmpty()){
            update updateAccount;
        }
    }
    
    public static void updatePhone(list<Contact> newList){
        
        map<id, string> accId = new map<id, string>();
        for(Contact con : newList){
            if(con.AccountId != null && con.Is_Primary__c == true){
                accId.put(con.AccountId, con.Phone);
            }
        }
        list<Account> accList = [SELECT id, (SELECT id FROM Contacts Where Is_Primary__c = true) FROM Account Where Id IN :accId.keyset()];
        list<Account> updateAcc = new list<Account>();
        for(Account acc: accList){
            if(acc.id != null){
                acc.Phone = accId.get(acc.id);
                updateAcc.add(acc);
            }
            
            if(!updateAcc.isEmpty()){
                update updateAcc;
            }
            
        }
    }
    
    public static void accountPhoneError(list<Contact> newList){
        set<id> accIds = new set<id>();
        set<id> accWithPhone = new set<id>();
        for(contact con : newList){
            if(con.AccountId != null){
                accIds.add(con.AccountId);
            }
        }
        list<Account> accList = [Select Id, Phone From Account Where id in :accIds and Phone != null];
        for (Account acc:accList){
            if(acc.Phone != null){
                accWithPhone.add(acc.id);
            }
        }
        for(contact con : newList){
            if(accWithPhone.contains(con.AccountId)){
                con.addError('Update Account Phone Number');
            }
        }
    }
    
    public static void maxAssociatedContact(list<Contact> newList){
        set<id> AccIds = new set<id>();
        for(Contact con: newList){
            if(con.AccountId != null){
                AccIds.add(con.AccountId);
            }
        }
        list<AggregateResult> aggList = [Select AccountId, count(id) ct From Contact Where AccountId In :AccIds Group by AccountId];
        map<id, integer> countContact = new map<id, integer>();
        for(AggregateResult arg: aggList){
            countContact.put((id) arg.get('AccountId'), (integer) arg.get('ct'));
        }
        
        for(Contact con : newList){
            if(con.AccountId != null && countContact.get(con.AccountId)>=3){
                con.addError('You make max 3 Contact into a Account');
            }
        }
    }
    
    public static void UniquePhone(list<Contact> newList){
        set<id> accIds = new set<id>();
        for(Contact con :newList){
            if(con.AccountId != null && con.Phone != null){
                accIds.add(con.AccountId);
            }
        }
        map<id, set<string>> accMap = new map<id, set<string>>();
        for(Account acc :[SELECT id, Phone, (SELECT id, Phone FROM Contacts) FROM Account WHERE id IN :accIds]){
            set<string> phoneSet = new set<string>();
            for(Contact con : acc.Contacts){
                phoneSet.add(con.Phone);
            }
            accMap.put(acc.id, phoneSet);
        }
        for(Contact con:newList){
            if(con.AccountId != null && con.Phone != null && accMap.get(con.AccountId).contains(con.Phone)){
                con.addError('Duplicate Phone Number');
            }
        }
        
    }
    
    public static void createAccountAndRelate(list<Contact> newList){
        list<Account> accList = new list<Account>();
        for(Contact con:newList){
            if(con.AccountId == null){
                string name = con.FirstName+' '+con.LastName;
                Account acc= new Account();
                acc.Name = name;
                acc.Phone = con.Phone;
                accList.add(acc);
            }
        }
        if(!accList.isEmpty()){
            insert accList;
        }
        map<string, id> newAccount = new map<string, id>();
        for(Account acc: accList){
            if(!accList.isEmpty()){
                newAccount.put(acc.Name, acc.id);
            }
        }
        for(Contact con:newList){
            if(newAccount.containskey(con.FirstName+' '+con.LastName)){
                con.AccountId = newAccount.get(con.FirstName+' '+con.LastName);
            }
        }
    }
    
    public static void createAccount(list<Contact> newList){
        list<Account> accList = new list<Account>();
        for(Contact con :newList){
            Account acc = new Account();
            acc.Name = con.LastName;
            accList.add(acc);
        }
        if(!accList.isEmpty()){
            update accList;
        }
    }
    
    public static void rollupOnAccount(list<contact> newList){
        set<id> accIds = new set<id>();
        for(contact con:newList){
            accIds.add(con.AccountId);
        }
        List<AggregateResult> groupedResults = [SELECT AccountId, COUNT(Id) contactCount FROM Contact WHERE AccountId IN :accIds GROUP BY AccountId];
    }
    
    public static void checkDestinationBeforeDeletion(list<Contact> oldList){
        set<Id> AccIds = new set<Id>();
        for(Contact con:oldList){
            if(con.AccountId != null){
                AccIds.add(con.AccountId);
            }
        }
        
        List<Account> accList = [SELECT Id, Name, Destination__c from Account Where Id IN:AccIds And Destination__c != null];
        map<Id, Account> accMap = new map<Id, Account>();
        if(!accList.isEmpty()){
            for(Account acc: accList){
                accMap.put(acc.Id, acc);
            }
        }
        if(!accMap.isEmpty()){
            for(Contact con:oldList){
                if(accMap.get(con.AccountId).Destination__c != null && accMap.get(con.AccountId).Destination__c.contains(con.LastName)){
                    con.addError('This Contact Cannot be Deleted');
                }
            }
        }
    }    
}