public class MyCalss {
    public integer number1;
    public string name;
    public boolean isActive;
    public Decimal balance;
    
    public MyCalss(){
        system.debug('Inside the default constructor');
    }
    
    public MyCalss(Decimal bal){
        balance=bal;
    }
    
    public MyCalss(Decimal bal,string name2){
        balance=bal;
        name=name2;
    }
    
    public static void accountVSOpp(){
        
        map<id,integer> contMap = new map<id, integer>();
        list<Account> accList = [SELECT id, (SELECT id FROM Opportunities) FROM Account];
        
        for(Account acc : accList){
            contMap.put(acc.id , acc.Opportunities.size());
        }
        
        system.debug(contMap);
        
        map<id, list<opportunity>> oppList = new map<id, list<opportunity>>();
        
        for(Account acc : accList){
            oppList.put(acc.id, acc.Opportunities);
        }
        
        system.debug(oppList);
        
        map<id, list<Contact>> ContactMap = new map<id, list<Contact>>();
        
        list<Account> AccountList = [SELECT id, (SELECT id FROM Contacts) FROM Account WHERE id IN :oppList.keyset()];
        
        for(Account acc : AccountList){
            ContactMap.put(acc.id, acc.Contacts);
        }
        
    }
    
    public static void aggregateResult(){
        
        map<id, decimal> sumOfOpp = new map<id, decimal>();
        list<AggregateResult> arList = [SELECT AccountId, sum(amount) summation From Opportunity Group by AccountId];
        
        for(AggregateResult ar:arList){
            sumOfOpp.put((id) ar.get('AccountId'), (decimal) ar.get('summation'));
        }
    }
    
    public static void accountPhone(list<Account> newList){
        
        for(Account acc : newList){
            if(acc.Phone ==null || acc.Phone == ''){
                acc.Phone.addError('Insert Phone Field ');
                acc.addError('Check Phone Field');
            }
        }
    }
    
    public static void updatePhone(list<Account> newList){
        map<id, string> accmap = new map<id, string>();
        for(Account acc : newList){
            accmap.put(acc.id, acc.Phone);
        }
        list<Contact> conList = [SELECT id, Phone, AccountId FROM Contact WHERE AccountId IN :accMap.keySet()];
        
        list<Contact> updateContact = new List<Contact>();
        for(Contact con:conList){
            if(con.AccountId != null){
                con.Phone = accmap.get(con.AccountId);
                updateContact.add(con);
            }
        }
        if(!updateContact.isEmpty()){
            update updateContact;
        }
    }
    
    public static void updateDescription(list<Contact> newList){
        map<id, Contact> conMap = new Map<id, Contact>();
        for(Contact con : newList){
            if(con.AccountId != null && con.Description != null){
                conMap.put(con.AccountId,con);
            }
        }
        
        list<Account> accList = new list<Account>();
        if(!conMap.isEmpty()){
            for(id AccId :conMap.keySet()){
                Account acc = new Account();
                acc.id = accId;
                acc.Description = conMap.get(AccId).Description;
                accList.add(acc);
            }
        }
        if(!accList.isEmpty()){
            update accList;
        }
    }
    
    public static void createContact(list<Account> newList){
        list<Contact> conList = new list<Contact>();
        for(Account acc: newList){
            Contact con = new Contact();
            con.AccountId = acc.id;
            con.FirstName = acc.Name;
            Con.LastName = 'Contacts';
            conList.add(con);
        }
        if(!conList.isEmpty()){
            insert conList;
        }
    }
    
    public static void opportunity(list<Opportunity> newList){
        for(Opportunity opp : newList){
            if(opp.StageName == 'Closed Won' && opp.CloseDate<=date.today()){
                opp.CloseDate.addError('Close Date Should not be Past Date');
            }
            if(opp.Amount<=1000){
                opp.Amount.addError('Amount is Greater Then 1000');
            }
        }        
    }
    
    public static list<Contact> createContacts(list<string> conLastName){
        list<Contact> resultCon = new List<Contact>();
        for(string conName: conLastName){
            Contact con = new Contact();
            con.LastName = conName;
            resultCon.add(con);
        }
        insert resultCon;
        return resultCon;
    }
    
    public static map<id, decimal> oppResult(set<id> contid){
        map<id, decimal> accMap = new map<id, decimal>();
        List<Contact> conList = [SELECT id, LastName, AccountId From Contact Where id IN :contId];
        set<id> accIds = new set<id>();
        for(Contact con :conList){
            accIds.add(con.AccountId);
        }
        list<AggregateResult> aggList = [Select AccountId, avg(Probability) pro From Opportunity Where AccountId In:accIds Group by AccountId];
        for(AggregateResult arg: aggList){
            accMap.put((id) arg.get('AccountId'), (decimal) arg.get('pro'));
        }
        Return accMap;
    }
    
    public static Account createAccount(string name){
        Account acc = new Account();
        acc.name = name;
        insert acc;
        Contact con = new Contact();
        con=MyCalss.createContact(acc.Id, acc);
        insert con;
        return acc;
    }
    
    public static Contact createContact(id accId, Account acc){
        Contact con = new Contact();
        con.AccountId = acc.id;
        con.LastName = acc.Name;
        return con;
    }
    
    public static Contact retrunIds(id conId){
       Contact con = [Select id, LastName From Contact Where id = :conId];
        return con;
    }
    
    public static integer countAcc(id accId){
        list<Contact> conList = [Select id From Contact Where AccountId =: accId];
        integer Conresult = conList.size();
        return Conresult;
    }
}