public class FetchContactLWC {
    
    public class ContactWrapper {
        @AuraEnabled
        public String FirstName { get; set; }        
        @AuraEnabled
        public String LastName { get; set; }        
        @AuraEnabled
        public String Email { get; set; }        
        @AuraEnabled
        public String Phone { get; set; }
    }
    
    @AuraEnabled(cacheable=true)
    public static list<Contact> getContact(string name, string mailId){
        list<Contact> conList = [SELECT id, FirstName, LastName, Email, Phone, AccountId, Account.Name, CreatedDate FROM Contact WHERE Name LIKE :'%'+name+'%' AND Email LIKE :'%'+mailId+'%'];
        return conList;
    }
    
    @AuraEnabled
    public static void mergeContacts(String priConId, String secConId, ContactWrapper priContact) {
        try {
            Contact primary = [SELECT Id, FirstName, LastName, Email, Phone, AccountId FROM Contact WHERE Id = :priConId];
            Contact secondary = [SELECT Id, FirstName, LastName, Email, Phone, AccountId FROM Contact WHERE Id = :secConId];

            primary.FirstName = priContact.FirstName;
            primary.LastName = priContact.LastName;
            primary.Email = priContact.Email;
            primary.Phone = priContact.Phone;
            
            update primary;
            
            delete secondary;
        } catch (Exception e) {
            throw new AuraHandledException('Error merging contacts: ' + e.getMessage());
        }
    }
    
    @AuraEnabled
    public static list<Contact> getContacts(list<String> name){
        list<Contact> conList = [SELECT id, FirstName, LastName From Contact Where FirstName LIKE :'%'+name[0]+'%' AND LastName LIKE :'%'+name[1]+'%'];
        return conList;
    }

}