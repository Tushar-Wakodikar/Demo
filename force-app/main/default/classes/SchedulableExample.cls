public class SchedulableExample implements schedulable {
    public static void execute(schedulableContext sc){
        Account acc = new Account();
        acc.Name = 'Schedulable Account Creation';
        insert acc;
    }
}