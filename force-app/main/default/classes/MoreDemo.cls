public class MoreDemo {
    public void rollName() {
        
        list<string> listname = new list<string>();
        listname.add ('Shubham');
        listname.add('Prashant');
        listname.add('Akshay');
        listname.add('Sohel');
        listname.add('Ganesh');
        listname.add('Furkan');
        listname.add('Kalyani');
     
        for(integer i=1; i<listname.size(); i++){
            map<integer,string> students = new map<integer,string>();
            students.put(i,listname[i]);
            system.debug('name and Roll no. of Student '+ students);
            
        }
        
    }      
    
    public void creatAccOpp(id contId){
        Contact con = [SELECT id, Name, AccountId FROM Contact WHERE id=:contId];
        Account acc;
        if(con.AccountId == null){
            acc = new Account();
            acc.Name='New Account';
            insert acc;
            
            con.AccountId=acc.Id;
            update con;
            system.debug('Account Id is '+acc.id);
        }
        else{
            acc = [SELECT id, Name FROM Account WHERE id=:con.AccountId LIMIT 1];
            system.debug('Account Id is '+acc.id);
        }
        List<Opportunity> oppList = [SELECT id, Name FROM Opportunity WHERE AccountId=:acc.id];
        if(opplist.isEmpty()){
            Opportunity opp = new Opportunity();
            opp.Name='New Opportunity';
            opp.StageName='Prospecting';
            opp.CloseDate=system.today();
            opp.AccountId=acc.id;
            insert opp;
            system.debug('Opportunity Id is '+opp.id);
        }
        else{
            system.debug('Opportunity Id is '+oppList);
        }
    }
    
    public map<id,string> contactOpportunity (list<id> accId){
                
        map<id,string> result = new map<id,string>();
        for(id acc:accId){
            list<Contact> contList = [Select id, LastName From Contact Where AccountId =:acc];
        	list<Opportunity> oppList = [Select id, Name From Opportunity Where AccountId =:acc];
            result.put(acc,'Cont-'+contList.size()+' Opp-'+oppList.size());
        }
        
        return result;
    }
    
    public integer monthly_total=0;
    public static integer yearly_total=0;
    
    public void getbalance(){
        monthly_total++;
        yearly_total++;
    }
    
    public static integer debitBalance=0;
    public integer limitBalance=500;
    
    public string getBalance1(){
        if(debitBalance==limitBalance){
            string output='You Have Reached the Limit';
            return output;
        }
        else{
            debitBalance +=100;
            return null;
        }
            
    }

}