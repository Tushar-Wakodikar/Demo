public class BalanceManager {

    public static integer debitBalance=0;
    private final integer limitBalance=500;
          
    public void increaseDebitBalance(){
        if(debitBalance<limitBalance){
            debitBalance +=100;
        }
        else if(debitBalance>=limitBalance){
            system.debug('You Have Reached the Limit');
        }
    }
    
    public static integer getDebitBalance(){
        return debitBalance;
    }
    
    public integer getLimitBalance(){
        return limitBalance;
    }
    
}