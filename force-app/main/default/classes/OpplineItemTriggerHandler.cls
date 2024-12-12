public class OpplineItemTriggerHandler {
    
    public static void updateOppAmount(list<OpportunityLineItem> newList){
        set<id> oppId = new set<id>();
        for(OpportunityLineItem oppLine :newList ){
            if(oppLine.OpportunityId != null){
                oppId.add(oppLine.OpportunityId);
            }
        }
        list<AggregateResult> aggList = [SELECT OpportunityId, sum(TotalPrice) sumation From OpportunityLineItem WHERE OpportunityId IN :oppId Group by OpportunityId];
        list<Opportunity> oppList = new list<Opportunity>();
        
        for(AggregateResult aggRes :aggList){
            Opportunity opp = new Opportunity();
            decimal sumValue = (decimal) aggRes.get('sumation');
            opp.id = (id) aggRes.get('OpportunityId');
            opp.Description = string.valueOf(sumValue);
            oppList.add(opp);
        }
        if(!oppList.isEmpty()){
            update oppList;
        }
    }
    
    public static void deleteOppLine(list<OpportunityLineItem> oldList){
        set<id> oppId = new set<id>();
        for(OpportunityLineItem oppLine :oldList){
            if(oppLine.OpportunityId != null){
                oppId.add(oppLine.OpportunityId);
            }
            list<Opportunity> oppList = [SELECT id, Amount FROM Opportunity WHERE id IN :oppId And Amount>50000];
            
            List<OpportunityLineItemDeletionAttempt__e> events = new List<OpportunityLineItemDeletionAttempt__e>();
            
            set<id> oppIds =new set<id>();
            for(Opportunity opp :oppList){
                if(opp.Amount > 50000){
                    oppIds.add(opp.id);
                    OpportunityLineItemDeletionAttempt__e event = new OpportunityLineItemDeletionAttempt__e();
                    event.OpportunityId__c = opp.id;
                    event.UserId__c = UserInfo.getUserId();
                    events.add(event);
                }
            }
            /*if(!oppIds.isEmpty()){
                //createTask(oppIds);
                id jobId = system.enqueueJob(new OpportunityQueueable(oppIds));
                system.debug('Queueable Job Id is: '+jobId);
            }*/
            if(!events.isEmpty()){
                EventBus.publish(events);
            }
            for(OpportunityLineItem oppLine1 :oldList){
                if(oppIds.contains(oppLine1.OpportunityId)){
                    oppLine1.addError('You Cannot Delete This Item');
                }
            }
        }
    } 
    
    public static void createTask(list<OpportunityLineItem> oldList){
        set<id> oppId = new set<id>();
        for(OpportunityLineItem oppLine :oldList){
            if(oppLine.OpportunityId != null){
                oppId.add(oppLine.OpportunityId);
            }
            list<Opportunity> oppList = [SELECT id, Amount FROM Opportunity WHERE id IN :oppId And Amount>50000];
            
            list<Task> taskList = new list<Task>();
            if(!oppList.isEmpty()){
                For(Opportunity opp :oppList){
                    if(opp.Amount>50000){
                        Task ts = new Task();
                        ts.OwnerId = userInfo.getUserId();
                        ts.Status = 'In Progress';
                        ts.Subject = 'Call';
                        ts.WhatId = opp.id;
                        ts.Priority = 'Normal';
                        ts.ActivityDate = system.today();
                        ts.Description = 'Someone was Trying to Delete oppLine Item of opp Id : '+opp;
                        taskList.add(ts);
                    }
                }
            }
            if(!taskList.isEmpty()){
                database.SaveResult[] srList = Database.insert(taskList, false);
                system.debug('Task Created Id is: '+taskList[0].id);
            }
        }
    }
}