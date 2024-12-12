public class NewCalculator {
    
    public void add(integer a,integer b){
        integer result=a+b;
        system.debug(' Addition of a and b is '+result);
    }
    
    public void sub(integer a,integer b){
        integer result=b-a;
        system.debug(' Substraction of a and b is '+result);
    }
    
    public void Multi(integer a,integer b){
        integer result=a*b;
        system.debug(' Multiplication of a and b is '+result);
    }
    
    public void Div(integer a,integer b){
        integer result=b/a;
        system.debug(' Division of a and b is '+result);
    }
    
    public void degree(decimal a, string b){
        if(b=='C'){
           decimal result=(a*9/5)+32;
            system.debug(a+' '+b+' is equal to '+result+' F');
        }
        else if(b=='F'){
            decimal result=(a-32)*5/9;
            system.debug(a+' '+b+' is equal to '+result+' C');
        }
    }
    
    public map<string,string> getAccount(){
        List<Account> accList=new List<Account>();
        accList=[Select ID, Name from Account limit 10];
        map<string,string> mapList = new map<string,string>();
        for(Account acc:accList){
            mapList.put(acc.id,acc.name);
        }
        return mapList;    
    }
    
    public List<Contact> getContact(){
        List<Contact> contList=new List<Contact>();
        contList=[Select ID, FirstName, LastName from Contact limit 10];
        return contList;
    }
    
    public void expenses(){
        list<Account> accList = [SELECT Id, Name, AnnualRevenue FROM Account WHERE AnnualRevenue >= 500 LIMIT 10];
        list<decimal> expenses=new list<decimal>();
        list<id> accountIdList = new list<id>();
        for(Account acc:accList){
            expenses.add(acc.AnnualRevenue);
            accountIdList.add(acc.id);
            system.debug(acc.AnnualRevenue);
        }
        List<Contact> contList = [SELECT id, name FROM Contact where Accountid in:accountIdList];
        list<id> contID = new list<id>();
        for(Contact cont:contList){
            contID.add(cont.id);
        }
        system.debug(expenses);
        system.debug(contId);
    }
    
    public void Account(){
        
    }
    
    public static integer getGcd(integer a,integer b){      
        while (b!=0){
        integer temp= b;
        b= Math.mod(a, b);
            //system.debug(b);
        a= temp;
        }
        return a;
    }
    
    public static integer getLCM(integer a, integer b){
        if(a==0 || b==0){
            return 0;
        }
        else {
            integer c=Math.abs(a*b)/getGcd(a,b);
            return c;
        }
        
    }
    
    public static integer sumOfNat(integer a){
        integer res= (a+1)*a/2;
        return res;
    }
    
}