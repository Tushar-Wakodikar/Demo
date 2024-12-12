public class ConditionalStatementsDemo {
    /*if(condition){
code if true
}*/
    // Example
    public void demoIf(){
        String nameOne = 'Shoeb';
        String nameTwo = 'Inder';
        if(nameOne == 'Shoeb'){
            system.debug('Sheikh');
        }
        if(nameTwo == 'Inder'){
            system.debug('Kanojia');
        }
    }
    
    private void demoIfElse(){
        /*
if(conditon){
code executed if true
}
else{
	code executed when if is not executed
}
*/
        
        String nameOne = 'Shoeb';
        String nameTwo = 'Inder';
        
        if(nameOne == 'Inder'){
            System.debug('Sheikh');
        }
        else{
            system.debug('Kanojia');
        }
    }
    
    public void invokeMethod(){
        demoIfElse();
    }
}