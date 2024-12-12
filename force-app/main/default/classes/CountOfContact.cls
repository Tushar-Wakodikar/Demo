public class CountOfContact {
    
    public integer contId(String accId){
        list<Contact> contList = [SELECT Id, FirstName, LastName FROM Contact Where AccountId = :accId];
        integer count=contList.size();
        return count;
    }
    
    public Account createAcc(string name){
        Account acc=new Account();
        acc.name=name;
        insert acc;
        return acc;
    }
    
    public Contact createCont(string lname,id Accid){
        Contact cont = new Contact();
        cont.lastName =lname;
        cont.AccountId = Accid;
        insert cont;
        return cont;
    }
    
    public list<Contact> createContact(id accId, integer count){
        
        list<contact> contactList = [SELECT id, LastName FROM Contact Where AccountId=:accId];
        if(contactList.size()>=1){
            return null;
        }
        else{
            list<contact> createContact=new list<contact>();
            for(integer i=1; i<=count; i++){
                contact cont= new contact();
                cont.LastName= 'Test'+i;
                cont.AccountId=accId;
                createContact.add(cont);
            }
            insert createContact;
            return createContact;
        }
    }
    
    public list<Contact> crtCont(id accId, integer n){
        
        list<Contact> contactList = [SELECT id, LastName FROM Contact Where AccountId=:accId];
        list<Contact> createContactList=new list<Contact>();
        for(integer i=(contactList.size()+1);i<=n;i++){
            Contact con = new Contact();
            con.LastName='ContactTest'+i;
            con.AccountId=accId;
            createContactList.add(con);
        }
        insert createContactList;
        return createContactList;
    }
    
    public Account crtAcc (string accName){
        list<Account> acclist = [SELECT Id, Name FROM Account WHERE Name=:accName];
        if(!acclist.isEmpty()){
            return null;
        }
        else{
            Account acc= new Account();
            acc.Name=accName;
            insert acc;
            return acc;
        }
    }
    
    public list<Contact> createContact2(id accId, integer count){
        list<Contact> conList = [SELECT id FROM Contact WHERE AccountId=:accId];
        list<Contact> insertConList = new list<Contact>();
        integer diff=count-conList.size();
        if(diff>0){
            for(integer i=1; i<=diff;i++){
                contact con= new contact();
                con.LastName='xyz';
                con.AccountId=accId;
                insertConList.add(con);
            }
            insert insertConList;
            return insertConList;
        }
        else if(diff<0){
            diff=diff*-1;
            conList = [SELECT id FROM Contact WHERE AccountId =: accId LIMIT : diff];
            delete conList;
            return null;
        }
        else{
            return null;
        }
    }
    
    public list<Contact> oppAcc(id oppId){
        Opportunity opp=[SELECT Id, AccountId, Name FROM Opportunity WHERE id=:oppId];
        id accId=opp.AccountId;
        list<Contact> contactList = [SELECT id, LastName FROM Contact WHERE AccountId=:accId];
        return contactList;
    }
    
    public List<Contact> getContact(set<id> oppIds){
        set<id> accIds = new set<id>();
        list<Opportunity> oppList = [SELECT Id, AccountId, Name FROM Opportunity WHERE id IN:oppIds];
        for(opportunity opp: oppList){
            accIds.add(opp.AccountId);
        }
        list<Contact> contactList = [SELECT id, LastName FROM Contact WHERE AccountId IN :accIds];
        return contactList;
    }
    
    public Account crtAccount(string accname){
        Account acc = new Account();
        acc.Name=accname;
        insert acc;
        return acc;
    }
    
}