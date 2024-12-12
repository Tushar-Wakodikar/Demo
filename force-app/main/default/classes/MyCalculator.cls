public class MyCalculator {

    public List<string> ListName = new List<string>();{
    Listname.add('Monday');
    Listname.add('Tuesday');
    Listname.add('Wedsenday');
    Listname.add('Thursday');
    Listname.add('Friday');
    Listname.add('Saturday');
    Listname.add('Sunday');
    }
    
    public string getName(integer i){
        if (i >= 0 && i <= listName.size()) {
            return listName[i-1];
        } else {
            return 'Index out of bounds';
        }
    }

	public void num(integer a){
        for(integer i=0;i<=a;i++){
            system.debug(i);
        }
        
        
}

    public string conv(integer a, string b){
        string output;
        if(b=='km to m'){
            output = a+' km is equals to '+ a*1000 +' m';
        }
        else if(b=='m to km'){
            output= a+ ' m is equals to '+ a/1000+ ' km';
        }
        else if(b=='kg to g'){
            output= a+ ' kg is equals to '+ a*1000+ ' g';
        }
        else if(b=='g to kg'){
            output= a+' g is equals to '+a/1000+ ' kg';
        }
        else {
            output= 'Give Proper Notation Ex. kg to g or km to m or vise versa';
        }
     return output;   
    }
}