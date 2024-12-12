trigger CreateContactIfAccountCreated on Account (after insert) {

    list<Contact> conList = new list<Contact>();
    for(Account acc:trigger.new){
        Contact con = new Contact();
        con.LastName =acc.name;
        con.AccountId=acc.Id;
        conList.add(con);
    }
    insert conList;

}