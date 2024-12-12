public with sharing class getContact {
    @AuraEnabled(cacheable = true)
    public static list<Contact> getContacts(string name){
        string searchKey = '%'+name+'%';
        list<Contact> contacts = [SELECT Id, Name, FirstName, LastName, Phone, Email FROM Contact WHERE Name LIKE :searchKey LIMIT 5];
        return contacts;
    }
}