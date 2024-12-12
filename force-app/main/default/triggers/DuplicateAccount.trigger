trigger DuplicateAccount on Account (before insert) {
    
    if(trigger.isBefore){
        if(trigger.isInsert){
            set<string> nameList = new set<string>();
            for(Account acc : trigger.new){
                nameList.add(acc.name);
            }
            list<Account> accList = new list<Account>();
            accList = [SELECT id, Name FROM Account WHERE Name IN : nameList];
            
            set<string> duplicateName = new set<string>();
            for(Account acc: accList){
                duplicateName.add(acc.name);
            }
            
            for(Account acc: trigger.new){
                if(duplicateName.contains(acc.name)){
                    acc.addError('Duplicate Account Name');
                }
                if(!acc.Name.startsWith('Mr')){
                    acc.name = 'Mr. ' + acc.name;
                }
            }
        }
    }
    
}