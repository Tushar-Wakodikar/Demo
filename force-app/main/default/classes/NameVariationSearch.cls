public class NameVariationSearch {
    
    public static list<Contact> searchContactByName(string searchTerm){
        
        list<list<sObject>> searchResult = [FIND :searchTerm IN All FIELDS RETURNING Contact(Id, FirstName, LastName)];
        
        return (list<Contact>) searchResult[0];
    }
    
}