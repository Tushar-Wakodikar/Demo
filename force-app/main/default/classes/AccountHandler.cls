public class AccountHandler {
    public static void createDestinationContact(list<Account> newList, map<id, Account> oldMap){
        Map<Id, List<String>> addDes = new Map<Id, List<String>>();
        Map<Id, List<String>> removeDes = new Map<Id, List<String>>();
        
        // Identify added and removed destinations for each account
        for(Account acc : newList){
            List<String> lstDestination = new List<String>();
            List<String> oldDestination = new List<String>();
            List<String> addDest = new List<String>();
            List<String> removeDest = new List<String>();
            
            if(oldMap == null){ // Insert case
                if(acc.Destination__c != null){
                    addDest = acc.Destination__c.split(';');
                }
            }
            
            else if(oldMap != null){ // Update case
                if((acc.Destination__c != null || acc.Destination__c == null) && acc.Destination__c != oldMap.get(acc.Id).Destination__c){
                    if(acc.Destination__c != null){
                        lstDestination = acc.Destination__c.split(';');
                    }
                    if(oldMap.get(acc.Id).Destination__c != null || acc.Destination__c == null){
                        oldDestination = oldMap.get(acc.Id).Destination__c.split(';');
                    }
                    
                    // Check for added destinations
                    for(String s: lstDestination){
                        if(!oldDestination.contains(s)){
                            addDest.add(s);
                        }
                    }
                    
                    // Check for removed destinations
                    for(String s: oldDestination){
                        if(!lstDestination.contains(s)){
                            removeDest.add(s);
                        }
                    }
                }
            }
            
            // Add to map if any destinations were added or removed
            if(!addDest.isEmpty()){
                addDes.put(acc.Id, addDest);
            }
            if(!removeDest.isEmpty()){
                removeDes.put(acc.Id, removeDest);
            }
        }        
        
        // Prepare contacts for insertion
        List<Contact> insertCon = new List<Contact>();
        
        // Insert contacts for added destinations
        if(addDes != null){
            for(Id accId :addDes.keySet()){
                for(String dest :addDes.get(accId)){
                    Contact con = new Contact();
                    con.LastName = dest;
                    con.AccountId = accId;
                    insertCon.add(con);
                }
            }
        }
        
        // Query all contacts to be deleted in one go
        if(removeDes != null){
            Set<String> destToRemove = new Set<String>();
            for (List<String> destList : removeDes.values()) {
                destToRemove.addAll(destList);
            }
            List<Contact> contactsToDelete = [SELECT Id, LastName, AccountId FROM Contact WHERE AccountId IN :removeDes.keySet() AND LastName IN :destToRemove];
            if(!contactsToDelete.isEmpty()){
                delete contactsToDelete;
            }
        }
        
        // Perform DML      
        if(!insertCon.isEmpty()){
            Insert insertCon;
        }
    }        
}