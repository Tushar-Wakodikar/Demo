public class SendGreeting {
	@InvocableMethod
    public static List<contact> greet(List<Account> account){
        
        List<contact> cList = new List<contact>();
        for(account acc: account){
            contact c = new contact();
            c.LastName = acc.name;
            cList.add(c);
        }
        
        return cList;
       

        
        
        
        //return ;
    }
    
    public string value(integer num){
        string output;
        if(num==0){
            output='Number is Zero';
        }
        else if(num>0){
            output='Number is Positive';
        }
        else{
            output='Number is Negative';
        }
        return output;
            
    }
    
}