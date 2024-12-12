trigger ClientErrorTrigger on Client__c (before insert, before update) {

    if(trigger.isBefore){
        if(trigger.isInsert || trigger.isUpdate){
            for(Client__c cli : trigger.new){
                if(cli.First_Name__c=='Test'){
                    cli.First_Name__c.addError('The name "Test" is not allowed for Client.');
                    cli.addError('Give a Valid First Name');
                }
            }
        }
    }
}