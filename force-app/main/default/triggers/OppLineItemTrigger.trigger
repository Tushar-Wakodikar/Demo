trigger OppLineItemTrigger on OpportunityLineItem (After insert, After update, before delete) {
    
   /* if(trigger.isBefore){
        if(trigger.isInsert){
            SerialNumberSetting__c settings = SerialNumberSetting__c.getOrgDefaults();
            Decimal nextSerialNumber = settings.NextSerialNumber__c;
            
            for(OpportunityLineItem oli :trigger.new){
                if(nextSerialNumber !=null){
                    oli.Serial_no__c = string.valueOf(nextSerialNumber);
                    
                    nextSerialNumber = nextSerialNumber+1;
                }
                else{
                    oli.Serial_no__c = string.valueOf(1);
                    nextSerialNumber = 1;
                }
            }
            settings.NextSerialNumber__c = nextSerialNumber;
            update settings;
        }
    } */
   
    if(trigger.isAfter){
        if(trigger.isUpdate || trigger.isInsert){
            OpplineItemTriggerHandler.updateOppAmount(trigger.new);
        }
    }
    
    if(trigger.isBefore){
        if(trigger.isDelete){
            //OpplineItemTriggerHandler.createTask(trigger.old);
            OpplineItemTriggerHandler.deleteOppLine(trigger.old);
        }
    }
    
}