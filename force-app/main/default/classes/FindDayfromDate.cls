public class FindDayfromDate {
    
    List<String> weekDays = new List<String>();
    
    public FindDayfromDate(){
        weekDays.add('Sunday');
        weekDays.add('Monday');
        weekDays.add('Tuesday');
        weekDays.add('Wednesday');
        weekDays.add('Thursday');
        weekDays.add('Friday');
        weekDays.add('Saturday');
    }
        
    public string getDay(Date inputDate){
        Date dt = inputDate.toStartofWeek();
        Integer dayOfWeek = dt.daysBetween(inputDate);
        string day = weekdays[dayOfWeek];
        return day;
    }
    
    public list<Contact> createContact(string fname, string lname, integer n){
        list<Contact> contlist = new list<Contact>();
        for(integer i=1;i<=n;i++){
            Contact cont = new Contact();
            cont.FirstName=fname;
            cont.LastName=lname;
            contlist.add(cont);
            }
        insert contlist;
        return contlist;
    }
    
}