public class ContactClone implements Queueable {
    
    private Contact con;
    private string industryValue;
    
    public ContactClone(Contact con, String industryValue){
        this.con=con;
        this.industryValue=industryValue;
    }
    
    public void execute(QueueableContext qc){
        try{
            list<Account> accList = [SELECT id, Name FROM Account WHERE Industry =:industryValue Limit 200];
            
            list<Contact> conList = new list<Contact>();
            for(Account acc:accList){
                Contact c = con.clone(false,false,false,false);
                c.AccountId = acc.id;
                conList.add(c);
            }
            
            if(!conList.isEmpty()){
                insert conList;
            }
        }
        catch(DmlException e){
            system.debug('DmlException '+e.getMessage());
        }
        catch(Exception e){
            system.debug('Exception '+e.getMessage());
        }
    }
}