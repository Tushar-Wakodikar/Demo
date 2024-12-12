public class FutureExample {
    
    @Future
    public static void futureMethod(string lName){
        profile p = [SELECT id FROM Profile WHERE Name='Standard User'];
        UserRole r = [SELECT id FROM UserRole WHERE Name='COO'];
        User usr = new User(alias='apexs', email='akshayWakodikar1997@gmail.com', emailencodingkey='UTF-8', 
                            lastName = lName, languagelocalekey='en_US', localesidkey='en_US', profileId =p.id, 
                            userroleid= r.id, timezonesidkey='America/Los_Angeles', 
                            userName='AkshayWakodikar@apexhours.com');
        insert usr;
    }
    public static void createData(){
        Account acc = new Account();
        acc.Name = 'Future Acc';
        insert acc;
        
        system.debug('sync Method');
        
        //futureMethod('CIG10');
        createContact();
        createOpp();
        createLead();
        ID jobID = System.enqueueJob(new QueueableExample());
        system.debug('JobId-- '+ jobId);
    }
    @future
    public static void createContact(){
        Contact con = new Contact();
        con.LastName = 'Future Contact';
        insert con;
        
        system.debug('Future Method Create Contact');
    }
    @future
    public static void createOpp(){
        Opportunity opp = new Opportunity();
        opp.Name = 'Future Opportunity';
        opp.StageName = 'Prospecting';
        opp.CloseDate = system.today();
        insert opp;
        
        system.debug('Future Method Create Opportunity');
    }
    @future
    public static void createLead(){
        Lead ld = new Lead();
        ld.LastName = 'Future Lead';
        ld.Company = 'BMC';
        ld.Status = 'Closed - Converted';
        ld.Rating = 'Hot';
        insert ld;
        
        system.debug('Future Method Create Lead');
    }
    
}