public class OpportunityQueueable implements Queueable {
    set<id> setIds = new set<id>();
    public OpportunityQueueable(set<id> ids){
        setIds = ids;
    }
    public void execute(QueueableContext qc){
        list<Task> taskList = new list<Task>();
       for(id opp :setIds){
            Task ts = new Task();
            ts.OwnerId = userInfo.getUserId();
            ts.Status = 'In Progress';
            ts.Subject = 'Call';
            ts.WhatId = opp;
            ts.Priority = 'Normal';
            ts.ActivityDate = system.today();
            ts.Description = 'Someone was Trying to Delete oppLine Item of opp Id : '+opp;
            taskList.add(ts);
        }
        if(!taskList.isEmpty()){
            insert taskList;
        }
    }
}