public class Calculator {

    public void operationToBePerformed(integer a, integer b, string operation){
        integer result;
        system.debug('Value of a is '+a);
        system.debug('Value of a is '+b);
        if(operation=='addition'){
            integer result1=addition(a,b);
            system.debug('Addition of a and b is '+result1);
            result=multi(result1);
            system.debug('Multiply by 5 of result is '+result);
            print(result1);
            print(result);
        }
        else if(operation=='substraction'){
            result=substraction(a,b);
        }
        
    }
    
    private integer addition(integer num1,integer num2){
        integer add=num1+num2;
        return add;
    }
    
    private integer substraction(integer num1,integer num2){
        integer sub=num1+num2;
        return sub;
    }
    
    private integer multi(integer num3){
       return num3*5;
    }
    
    private void print(integer res){
        system.debug('Calling print Method and the result is '+res);
    }
    
}