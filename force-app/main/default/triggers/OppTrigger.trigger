trigger OppTrigger on Opportunity (before insert, before update, after insert, after update, before Delete, after Delete) {
    
    if(trigger.isBefore){
        if(trigger.isInsert){
            //OppTriggerHandler.AmountSum(trigger.new);
            //OppTriggerHandler.primaryOpp(trigger.new, trigger.oldMap);
            //OppTriggerHandler.stageCloseLost(trigger.new, trigger.oldMap);
        }
        if(trigger.isUpdate){
            //OppTriggerHandler.primaryOpp(trigger.new, trigger.oldMap);
            //OppTriggerHandler.stageCloseLost(trigger.new, trigger.oldMap);
        }
    }
    if(trigger.isAfter){
        if(trigger.isInsert){
            //OppTriggerHandler.SendEmail(trigger.new);
        }
        if(trigger.isUpdate){
            //OppTriggerHandler.SendEmail(trigger.new);
        }
    }
    if(trigger.isBefore){
        if(trigger.isDelete){
            //OppTriggerHandler.PreventClosedWonOpportunityDeletion(trigger.old);
        }
    }
    
}