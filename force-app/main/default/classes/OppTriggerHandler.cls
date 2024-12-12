public class OppTriggerHandler {
    
    public static void AmountSum(list<Opportunity> newList){
        
        set<id> AccountIds = new set<id>();
        
        for(Opportunity opp : newList){
            if(opp.accountId !=null){
                AccountIds.add(opp.Accountid);
            }
        }
        
        //list<Opportunity> oppList = [SELECT id, AccountId, Amount FROM Opportunity WHERE AccountId IN :AccountIds];
        list<AggregateResult> oppList = [SELECT AccountId, sum(Amount) amount From Opportunity Where AccountId IN :AccountIds Group by AccountId];
        
        map<id, decimal> totalAmount = new map<id, decimal>();
        
        /*for (Opportunity opp : oppList) {
if (opp.Amount != null) {
if (totalAmount.containsKey(opp.AccountId)) {
totalAmount.put(opp.AccountId, totalAmount.get(opp.AccountId) + opp.Amount);
} else {
totalAmount.put(opp.AccountId, opp.Amount);
}
}
}*/
        
        for(AggregateResult ar:oppList) {
            totalAmount.put((id) ar.get('AccountId'), (decimal) ar.get('amount') );
        }
        
        list<Account> updateAccount = new list<Account>();
        for(id accId : totalAmount.keyset()){
            Account acc = new Account();
            acc.id = accId;
            acc.AnnualRevenue = totalAmount.get(accId);
            updateAccount.add(acc);
        }
        
        if(!updateAccount.isEmpty()){
            update updateAccount;
        }
        
    }
    
    public static void avgOpp(list<Opportunity> newList){
        
        set<id> accId = new set<id>();
        for(Opportunity opp: newList){
            if(opp.AccountId != null){
                accId.add(opp.AccountId);
            }
        }
        list<AggregateResult> arList = [SELECT AccountId, avg(amount) aver FROM Opportunity WHERE AccountId IN :accId Group by AccountId];
        map<id, decimal> oppMap = new map<id, decimal>();
        list<Account> updateAcc = new list<Account>();
        for(AggregateResult ar:arList){
            oppMap.put((id) ar.get('AccountId'), (decimal) ar.get('aver'));
        }
        
        for(id aId: accId){
            Account acc = new Account();
            acc.id = aId;
            acc.AnnualRevenue = oppMap.get(aId);
            updateAcc.add(acc);
        }
        
        update updateAcc;
    }
    
    public static void maxOpp(list<Opportunity> newList){
        
        set<id> accId = new set<id>();
        for(Opportunity opp: newList){
            if(opp.AccountId != null){
                accId.add(opp.AccountId);
            }
        }
        list<AggregateResult> arList = [SELECT AccountId, max(amount) maxamount FROM Opportunity WHERE AccountId IN :accId Group by AccountId];
        list<Account> updateAcc = new list<Account>();
        for(AggregateResult ar:arList){
            id accountId = (id) ar.get('AccountId');
            decimal maxAmount = (decimal) ar.get('maxamount');
            Account acc = new Account();
            acc.id = accountId;
            acc.AnnualRevenue = maxAmount;
            updateAcc.add(acc);
        }
        
        update updateAcc;
    }
    
    public static void primaryOpp(list<Opportunity> newList, map<id, opportunity> oldMap){
        set<id> accIds = new set<id>();
        for(Opportunity opp : newList){
            if(opp.AccountId != null && opp.Account_Number__c != null && oldMap.get(opp.id).Account_Number__c != opp.Account_Number__c){
                accIds.add(opp.AccountId);
            }
        }
        map<id, string> accMap = new map<id, string>();
        list<Account> accList = [Select id, AccountNumber From Account where id in :accIds AND AccountNumber != null];
        for(Account acc :accList){
            accMap.put(acc.id, acc.AccountNumber);
        }
        for(Opportunity opp : newList){
            if(opp.AccountId != null && accMap.containsKey(opp.AccountId) && opp.Account_Number__c == accMap.get(opp.AccountId)){
                opp.Primary_Opportunity__c = true;
            }
        }
    }
    
    public static void stageCloseLost(list<Opportunity> newList, map<id, opportunity> oldMap){
        for(Opportunity opp: newList){
            if(oldMap.get(opp.id).StageName == 'Closed Lost' && opp.StageName == 'Needs Analysis'){
                opp.StageName.addError('Mark Stage Closed Lost');
            }
        }
    }
    
    public static void PreventClosedWonOpportunityDeletion(list<Opportunity> newList){
        for(Opportunity opp: newList){
            if(opp.StageName=='Closed Won'){
                opp.addError('You cannot delete an Opportunity with a Stage of "Closed Won".');
            }
        }
    }
    
    public static void SendEmail(list<Opportunity> newList){
        list<Messaging.Email> emailList = new list<Messaging.Email>();
        Id currentUserId = UserInfo.getUserId();
        list<user> currentUser = [SELECT id, FirstName, LastName, Email FROM User WHERE Id = :currentUserId];
        for(Opportunity opp : newList){
            if(Opp.StageName=='Closed Won'){
                Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
                list<string> toAddress = new list<string>{currentUser[0].Email};
                emailMsg.setToAddresses(toAddress);
                string emailSub = 'Welcome '+ opp.Name;
                emailMsg.setSubject(emailSub);
                string disName = currentUser[0].FirstName+' '+currentUser[0].LastName;
                emailMsg.setSenderDisplayName(disName);
                
                string content = 'Hi ' + opp.Name + ',<br/><br/>' +
                    'Welcome to Salesforce EcoSystem! <br/><br/>' +
                    'Begin your Salesforce Admin and Developer Journey with '+currentUser[0].FirstName+' '+currentUser[0].LastName+',<br/><br/>'+
                    'Happy Learning!!!<br/><br/>'+
                    'Thank You!<br/>'+
                    currentUser[0].FirstName+' '+currentUser[0].LastName;
                emailMsg.setHtmlBody(content);
                emailList.add(emailMsg);
            }
        }
        Messaging.sendEmail(emailList);
    }
    
}