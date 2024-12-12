trigger ContactTrigger on Contact (before insert, after insert, before update, after update, before delete, after delete, after unDelete) {
    
    if(trigger.isBefore){
        if(trigger.isInsert){
            //ContactTriggerHandler.createContact(trigger.new);
            //ContactTriggerHandler.validateDuplicateEmail(trigger.new);
            //ContactTriggerHandler.maxAssociatedContact(trigger.new);
            //ContactTriggerHandler.UniquePhone(trigger.new);
            //ContactTriggerHandler.createAccountAndRelate(trigger.new);
        }
        if(trigger.isUpdate){
            //ContactTriggerHandler.updateAccountPhone(trigger.new);
            //ContactTriggerHandler.UniquePhone(trigger.new);
        }
        if(trigger.isDelete){
            ContactTriggerHandler.checkDestinationBeforeDeletion(trigger.old);
        }
        
    }
    
    if(trigger.isAfter){
        if(trigger.isInsert){
            //ContactTriggerHandler.updateOpp(trigger.new);
            //ContactTriggerHandler.createAccount(trigger.new);
        }
        if(trigger.isUpdate){
            //ContactTriggerHandler.updateOpp(trigger.new);
            //ContactTriggerHandler.uppdateAcc(trigger.new);
        }
        
    }
    
}