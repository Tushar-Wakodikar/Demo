trigger ContactAccountTrigger on Contact (before insert, before update) {

    if(trigger.isBefore){
        if(trigger.isInsert || trigger.isUpdate){
            
            set<Id> accountIds = new set<Id>();
            
            for(contact con:trigger.new){
                if(con.AccountId !=null){
                    accountIds.add(con.AccountId);
                }
            }
                
                map<Id, account> accountMap = new map<id, account>([SELECT Id, Name FROM Account WHERE id in :accountIds]);
                                
                for(Contact cont:trigger.new){
                    if(cont.AccountId !=null && accountMap.containsKey(cont.AccountId)){
                        Account acc = new Account();
                        acc = accountMap.get(cont.AccountId);
                        cont.FirstName = acc.Name;
                    }
                }
        }
    }
    
}