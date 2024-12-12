public class BatchClassContact implements database.batchable<sObject>{
    
    public database.queryLocator start(database.batchableContext bc){
        string query = 'SELECT id, FirstName, LastName FROM Contact WHERE AccountId = Null';
        return database.getQueryLocator(query);
    }
    public void execute(database.batchableContext bc, list<Contact> conList){
        try{
            list<Account> accList = new list<Account>();
            for(Contact con:conList){
                Account acc= new Account();
                acc.Name = con.FirstName+' '+con.LastName+' Batchable';
                accList.add(acc);
            }
            if(!accList.isEmpty()){
                database.saveResult[] srList = database.insert(accList,false);
                for(database.saveResult sr :srList){
                    if(sr.isSuccess()){
                        system.debug('Sucessful inserted Accounts'+sr.getId());
                    }
                    else{
                        for(database.error err:sr.getErrors()){
                            system.debug('Error-'+err.getStatusCode()+':'+err.getMessage());
                            system.debug('Fields That affect Error: '+err.getFields());
                        }
                    }
                }
            }
            map<string, id> accMap = new map<string, id>();
            for(Account acc: accList){
                accMap.put(acc.Name,acc.id);
            }
            for(Contact con:conList){
                con.AccountId = accMap.get(con.FirstName+' '+con.LastName+'Batchable');
            }
            if(!conList.isEmpty()){
                database.SaveResult[] srList = database.update(conList,false);
                for(database.SaveResult sr:srList){
                    if(sr.isSuccess()){
                        system.debug('Successfull updated Contact. Contact ID: '+sr.getId());
                    }
                    else{
                        for(Database.error err: sr.getErrors()){
                            System.debug('Error- '+err.getStatusCode()+':'+err.getMessage());
                            system.debug('Fields That affect Error: '+err.getFields());
                        }
                    }
                }
            }
        }
        catch(DmlException e){
            system.debug('DmlException-'+e.getMessage());
        }
        catch(Exception e){
            system.debug('Exception-'+e.getMessage());
        }
    }
    public void finish(database.batchableContext bc){
        
    }
    
}