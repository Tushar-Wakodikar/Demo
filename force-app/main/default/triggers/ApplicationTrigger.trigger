trigger ApplicationTrigger on Application__c (before insert, after insert, before update, after update) {
    
    if(trigger.isBefore){
        if(trigger.isInsert){
            
        }
        if(trigger.isUpdate){
            
        }
        
    }
    
    if(trigger.isAfter){
        if(trigger.isInsert){
            ApplicationTriggerHandler.updateApplication(trigger.new);
            ApplicationTriggerHandler.Description(trigger.new);
        }
        if(trigger.isUpdate){
            ApplicationTriggerHandler.updateApplication(trigger.new);
            ApplicationTriggerHandler.Description(trigger.new);
        }
    }

}