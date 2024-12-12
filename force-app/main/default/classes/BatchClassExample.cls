public class BatchClassExample implements database.batchable<sObject>{
    
    public database.querylocator start(database.batchableContext b){
        system.debug('Start Method in Process');
        string query='SELECT id, Active__c FROM Account';
        return database.getQueryLocator(query);
    }
    public void execute(database.batchableContext b, list<Account> accList){
        try{
            system.debug('Size of AccList is -'+accList.size());
            list<Account> updateAccList = new list<Account>();
            for(Account acc:accList){
                acc.Active__c = 'No';
                updateAccList.add(acc);
            }
            if(!updateAccList.isEmpty()){
                update updateAccList;
            }
            system.debug('Execute Method in Process');
        }
        catch(DmlException e){
            system.debug('DmlException-'+e.getMessage());
        }
        catch(Exception e){
            system.debug('Exception-'+e.getMessage());
        }
    }
    public void finish(database.batchableContext b){
        
    }
    
}