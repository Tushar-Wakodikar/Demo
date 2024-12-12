public class ReturnWapperDemo {
    public static list<ContactWrapper> returnContact (string Email){
        list<Contact> conList = [SELECT id, Email, Birthdate, Phone, Salutation, FirstName, LastName, Is_Primary__c
                                 FROM Contact WHERE Email =:Email];
        list<ContactWrapper> wrapList = new list<ContactWrapper>();
        for(contact con:conList){
            ContactWrapper wrap = new ContactWrapper();
            wrap.Email = con.Email;
            wrap.Birthdate = con.Birthdate;
            wrap.conId = con.id;
            wrap.Phone = con.Phone;
            wrap.Salutation = con.Salutation;
            wrap.FirstName = con.FirstName;
            wrap.LastName = con.LastName;
            wrap.IsPrimary = con.Is_Primary__c;
            wrapList.add(wrap);
        }
        return wrapList;
    }
}