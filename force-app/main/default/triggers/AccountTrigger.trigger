trigger AccountTrigger on Account (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    
    if(trigger.isBefore){
        if(trigger.isInsert){
            //AccountTriggerHandler.deleteContactWithSameAccountName(trigger.new);
            //AccountTriggerHandler.validateDuplicateAccount(trigger.new);
            //AccountTriggerHandler.addPrefixMr(trigger.new);
            //AccountTriggerHandler.countContact(trigger.new);
            //AccountTriggerHandler.countContact(trigger.new);
            //AccountTriggerHandler.billShippingAddress(trigger.new);
            //AccountTriggerHandler.createContactIfAccountCreated(trigger.new);
        }
        if(trigger.isUpdate){
            //AccountTriggerHandler.updateAssociatedContact(trigger.new);
            //AccountTriggerHandler.billShippingAddress(trigger.new);
        }
    }
    
    if(trigger.isAfter){        
        if(trigger.isInsert){
            //AccountTriggerHandler.updateAssociatedContact(trigger.new);
            //AccountTriggerHandler.countContact(trigger.new);
            //AccountTriggerHandler.createContactIfAccountCreated(trigger.new);
            AccountHandler.createDestinationContact(trigger.new, null);
        }
        if(trigger.isUpdate){
            //AccountTriggerHandler.updateAssociatedContact(trigger.new);
            AccountHandler.createDestinationContact(trigger.new, trigger.oldMap);
            
        }
    }
    
}