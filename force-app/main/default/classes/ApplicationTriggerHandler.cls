public class ApplicationTriggerHandler {
    
    public static void updateApplication(list<Application__c> newList){
        set<id> AppId = new set<id>();
        for(Application__c app: newList){
            if(app.Job__c != null){
                AppId.add(app.Job__c);
            }
        }
        map<id, integer> appMap = new map<id, integer>();
        list<AggregateResult> appReceived = [SELECT Job__c, count(id) FROM Application__c WHERE Job__c IN :AppId Group by Job__c];
        
        map<id, integer> passMap = new map<id, integer>();
        map<id, integer> failMap = new map<id, integer>();
        list<Application__c> appList = [SELECT id, Job__c, Pass_Or_Fail__c FROM Application__c WHERE Job__c IN :AppId AND Pass_Or_Fail__c IN ('Pass','Fail')];
        
        for(AggregateResult ar: appReceived){
            appMap.put((id) ar.get('Job__c'), (integer) ar.get('expr0'));
        }
        
        for(id jobId: AppId){
            passMap.put(jobId,0);
            failMap.put(jobId,0);
        }
        
        for(Application__c app:appList){
            if(app.Pass_Or_Fail__c == 'Pass'){
                passMap.put(app.Job__c, passMap.get(app.Job__c)+1);
            }
            else if(app.Pass_Or_Fail__c == 'Fail'){
                failMap.put(app.Job__c, failMap.get(app.Job__c)+1);
            }
        }
        
        list<Job__c> updateJob = new list<Job__c>();
        for(id jobId :AppId){
            Job__c jb = new Job__c();
            jb.id = jobId;
            jb.Application_Received__c = appMap.get(jobId);
            jb.Candidates_Pass__c = passMap.get(jobId);
            jb.Candidates_Fail__c = string.valueOf(failMap.get(jobId));
            updateJob.add(jb);
        }
        
        if(updateJob.size()>0){
            update updateJob;
        }
        
    }
    
    public static void Description(list<Application__c> newList){
        map<id, string> CandId = new map<id, string>();
        for(Application__c app: newList){
            if(app.Candidate__c != null){
                CandId.put(app.Candidate__c, app.Pass_Or_Fail__c);
            }
        }
        
        list<Candidate__c> candList = new list<Candidate__c>();
        for(id can: CandId.keyset()){
            Candidate__c con = new Candidate__c();
            con.id=can;
            con.Description__c = CandId.get(can);
            candList.add(con);
        }
        
        if(candList.size()>0){
            update candList;
        }
        
    }
    
    public static void passOrFail(list<Application__c> newList){
        
        set<id> AppId = new set<id>();
        for(Application__c app: newList){
            
        }
        
    }
    
}