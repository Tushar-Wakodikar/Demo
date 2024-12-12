trigger DeleteContactWithSameAccountName on Account (before insert) {
    
    if(trigger.isBefore){
        if(trigger.isInsert){
            
            set<string> accNameList = new set<string>();
            for(Account acc: trigger.new){
                accNameList.add(acc.name);
            }
            
            list<Contact> conList = new list<Contact>();
            conList = [SELECT id, FirstName, LastName From Contact WHERE LastName in :accNameList];
            
            delete conList;
        }
    }
}