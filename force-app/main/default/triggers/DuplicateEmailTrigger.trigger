trigger DuplicateEmailTrigger on Contact (before insert) {

    if(trigger.isBefore){
        if(trigger.isInsert){
            set<string> emailIds = new set<string>();
            for(Contact con :trigger.new){
                emailIds.add(con.Email);
            }
            
            list<Contact> conList = new list<Contact>();
            conList=[SELECT Email FROM Contact WHERE Email in :emailIds];
            
            set<string> duplicateEmail = new set<string>();
            for(contact con :conlist){
                duplicateEmail.add(con.Email);
            }
            
            for(Contact con:trigger.new){
                if(duplicateEmail.contains(con.Email)){
                    con.addError('Duplicate Email exist ...........');
                }
            }
        }
    }
    
}