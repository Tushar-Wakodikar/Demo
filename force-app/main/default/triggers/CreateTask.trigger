trigger CreateTask on OpportunityLineItemDeletionAttempt__e (after insert) {
    
    list<Task> taskList = new list<Task>();
    for(OpportunityLineItemDeletionAttempt__e oppLine :trigger.new){
        Task ts = new Task();
        ts.OwnerId = oppLine.UserId__c;
        ts.Status = 'In Progress';
        ts.Subject = 'Call';
        ts.WhatId = oppLine.OpportunityId__c;
        ts.Priority = 'Normal';
        ts.ActivityDate = system.today();
        ts.Description = 'Someone was Trying to Delete oppLine Item of opp Id : '+oppLine.UserId__c;
        taskList.add(ts);
    }
    if(!taskList.isEmpty()){
        insert taskList;
        System.debug('Task Created With Id :'+taskList[0].id);
    }
}