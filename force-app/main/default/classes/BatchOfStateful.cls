public class BatchOfStateful implements database.batchable<sObject>,database.stateful {
    public integer sum =0;
    public database.querylocator start(database.batchableContext b){
        system.debug('Start Method in Process');
        string query='SELECT id, Active__c FROM Account';
        return database.getQueryLocator(query);
    }
    public void execute(database.batchableContext b, list<Account> accList){
        try{
            list<Account> updateAccList = new list<Account>();
            for(Account acc:accList){
                acc.Active__c = 'Yes';
                updateAccList.add(acc);
                sum++;
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
        system.debug(sum);
    }
    public void finish(database.batchableContext b){
        system.debug(sum);
    }

}