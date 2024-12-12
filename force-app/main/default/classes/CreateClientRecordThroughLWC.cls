public class CreateClientRecordThroughLWC {
    @AuraEnabled
    public static string createClient(string firstname, string middlename, string lastname, string phone, string email, string gender){
        try{
            Client__c clt = new Client__c();
            clt.First_Name__c = firstname;
            clt.Middle_Number__c = middlename;
            clt.Last_Name__c = lastname;
            clt.Contact_Number__c = phone;
            clt.Email_ID__c = email;
            clt.Gender__c = gender;
            insert clt;
            return clt.id;
        }
        catch(Exception e){
            return e.getMessage();
        }
    }
}